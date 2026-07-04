SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE SafeTransferFunds'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE UpdateSalary'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE AddNewCustomer'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE ErrorLog'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Accounts CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Employees CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Customers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    IsVIP VARCHAR2(5),
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

CREATE TABLE ErrorLog (
    ErrorID NUMBER PRIMARY KEY,
    ErrorMessage VARCHAR2(4000),
    ErrorDate DATE
);

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15','YYYY-MM-DD'), 1000, 'FALSE', SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20','YYYY-MM-DD'), 1500, 'FALSE', SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 5000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 2000, SYSDATE);

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15','YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20','YYYY-MM-DD'));

COMMIT;

CREATE OR REPLACE PROCEDURE LogError(
    p_message IN VARCHAR2
)
AS
    v_error_id NUMBER;
BEGIN
    SELECT NVL(MAX(ErrorID), 0) + 1
    INTO v_error_id
    FROM ErrorLog;

    INSERT INTO ErrorLog(ErrorID, ErrorMessage, ErrorDate)
    VALUES(v_error_id, p_message, SYSDATE);

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE SafeTransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
)
AS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds.');
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount
    WHERE AccountID = p_to_account;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Destination account not found.');
    END IF;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Fund transfer successful.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        LogError('SafeTransferFunds failed: Source account not found.');
        DBMS_OUTPUT.PUT_LINE('Error: Source account not found.');

    WHEN OTHERS THEN
        ROLLBACK;
        LogError('SafeTransferFunds failed: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UpdateSalary(
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM Employees
    WHERE EmployeeID = p_employee_id;

    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Employee ID does not exist.');
    END IF;

    UPDATE Employees
    SET Salary = Salary + (Salary * p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee salary updated successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        LogError('UpdateSalary failed: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE AddNewCustomer(
    p_customer_id IN NUMBER,
    p_name IN VARCHAR2,
    p_dob IN DATE,
    p_balance IN NUMBER
)
AS
BEGIN
    INSERT INTO Customers(CustomerID, Name, DOB, Balance, IsVIP, LastModified)
    VALUES(p_customer_id, p_name, p_dob, p_balance, 'FALSE', SYSDATE);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Customer added successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        LogError('AddNewCustomer failed: Customer ID ' || p_customer_id || ' already exists.');
        DBMS_OUTPUT.PUT_LINE('Error: Customer ID already exists.');

    WHEN OTHERS THEN
        ROLLBACK;
        LogError('AddNewCustomer failed: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 1: Fund Transfer');
    SafeTransferFunds(1, 2, 1000);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 1 Error Test');
    SafeTransferFunds(2, 1, 10000);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 2: Update Salary');
    UpdateSalary(1, 10);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 2 Error Test');
    UpdateSalary(99, 10);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 3: Add Customer');
    AddNewCustomer(3, 'Robert Brown', TO_DATE('1995-02-10','YYYY-MM-DD'), 3000);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 3 Error Test');
    AddNewCustomer(1, 'Duplicate Customer', TO_DATE('1999-01-01','YYYY-MM-DD'), 5000);
END;
/

SELECT * FROM Accounts;
SELECT * FROM Employees;
SELECT * FROM Customers;
SELECT * FROM ErrorLog;