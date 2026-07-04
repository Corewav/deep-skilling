SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE ProcessMonthlyInterest'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE UpdateEmployeeBonus'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PROCEDURE TransferFunds'; EXCEPTION WHEN OTHERS THEN NULL; END;
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

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15','YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20','YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 10000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 5000, SYSDATE);
INSERT INTO Accounts VALUES (3, 1, 'Savings', 8000, SYSDATE);

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15','YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20','YYYY-MM-DD'));
INSERT INTO Employees VALUES (3, 'Rahul Sharma', 'Tester', 50000, 'IT', TO_DATE('2019-01-10','YYYY-MM-DD'));

COMMIT;

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01),
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' savings account(s) updated with 1% monthly interest.');

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percentage / 100)
    WHERE Department = p_department;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department: ' || p_department);
    ELSE
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee(s) received bonus in department: ' || p_department);
    END IF;

    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account IN NUMBER,
    p_to_account IN NUMBER,
    p_amount IN NUMBER
)
AS
    v_source_balance NUMBER;
    v_destination_count NUMBER;
BEGIN
    IF p_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Transfer amount must be greater than zero.');
        RETURN;
    END IF;

    SELECT Balance
    INTO v_source_balance
    FROM Accounts
    WHERE AccountID = p_from_account;

    SELECT COUNT(*)
    INTO v_destination_count
    FROM Accounts
    WHERE AccountID = p_to_account;

    IF v_destination_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Destination account not found.');
        RETURN;
    END IF;

    IF v_source_balance < p_amount THEN
        DBMS_OUTPUT.PUT_LINE('Insufficient balance in source account.');
        RETURN;
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount,
        LastModified = SYSDATE
    WHERE AccountID = p_to_account;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Funds transferred successfully.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Source account not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Transfer failed: ' || SQLERRM);
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 1: Process Monthly Interest');
    ProcessMonthlyInterest;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 2: Update Employee Bonus');
    UpdateEmployeeBonus('IT', 10);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 3: Transfer Funds');
    TransferFunds(1, 2, 2000);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Insufficient Balance Test');
    TransferFunds(2, 1, 50000);
END;
/

SELECT * FROM Accounts;
SELECT * FROM Employees;