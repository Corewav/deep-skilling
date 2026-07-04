SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP PACKAGE CustomerManagement'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PACKAGE EmployeeManagement'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP PACKAGE AccountOperations'; EXCEPTION WHEN OTHERS THEN NULL; END;
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

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15','YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20','YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15','YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20','YYYY-MM-DD'));

INSERT INTO Accounts VALUES (1, 1, 'Savings', 5000, SYSDATE);
INSERT INTO Accounts VALUES (2, 1, 'Checking', 3000, SYSDATE);
INSERT INTO Accounts VALUES (3, 2, 'Savings', 7000, SYSDATE);

COMMIT;

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer(
        p_customer_id IN NUMBER,
        p_name IN VARCHAR2,
        p_dob IN DATE,
        p_balance IN NUMBER
    );

    PROCEDURE UpdateCustomer(
        p_customer_id IN NUMBER,
        p_name IN VARCHAR2,
        p_balance IN NUMBER
    );

    FUNCTION GetCustomerBalance(
        p_customer_id IN NUMBER
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer(
        p_customer_id IN NUMBER,
        p_name IN VARCHAR2,
        p_dob IN DATE,
        p_balance IN NUMBER
    )
    AS
    BEGIN
        INSERT INTO Customers(CustomerID, Name, DOB, Balance, LastModified)
        VALUES(p_customer_id, p_name, p_dob, p_balance, SYSDATE);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Customer added successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Customer already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END AddCustomer;

    PROCEDURE UpdateCustomer(
        p_customer_id IN NUMBER,
        p_name IN VARCHAR2,
        p_balance IN NUMBER
    )
    AS
    BEGIN
        UPDATE Customers
        SET Name = p_name,
            Balance = p_balance,
            LastModified = SYSDATE
        WHERE CustomerID = p_customer_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Customer not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Customer updated successfully.');
        END IF;
    END UpdateCustomer;

    FUNCTION GetCustomerBalance(
        p_customer_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_balance NUMBER;
    BEGIN
        SELECT Balance
        INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;

        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END GetCustomerBalance;

END CustomerManagement;
/

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee(
        p_employee_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_department IN VARCHAR2,
        p_hire_date IN DATE
    );

    PROCEDURE UpdateEmployee(
        p_employee_id IN NUMBER,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_department IN VARCHAR2
    );

    FUNCTION CalculateAnnualSalary(
        p_employee_id IN NUMBER
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee(
        p_employee_id IN NUMBER,
        p_name IN VARCHAR2,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_department IN VARCHAR2,
        p_hire_date IN DATE
    )
    AS
    BEGIN
        INSERT INTO Employees(EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES(p_employee_id, p_name, p_position, p_salary, p_department, p_hire_date);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee hired successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Employee already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END HireEmployee;

    PROCEDURE UpdateEmployee(
        p_employee_id IN NUMBER,
        p_position IN VARCHAR2,
        p_salary IN NUMBER,
        p_department IN VARCHAR2
    )
    AS
    BEGIN
        UPDATE Employees
        SET Position = p_position,
            Salary = p_salary,
            Department = p_department
        WHERE EmployeeID = p_employee_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Employee not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Employee updated successfully.');
        END IF;
    END UpdateEmployee;

    FUNCTION CalculateAnnualSalary(
        p_employee_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_salary NUMBER;
    BEGIN
        SELECT Salary
        INTO v_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id;

        RETURN v_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END CalculateAnnualSalary;

END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount(
        p_account_id IN NUMBER,
        p_customer_id IN NUMBER,
        p_account_type IN VARCHAR2,
        p_balance IN NUMBER
    );

    PROCEDURE CloseAccount(
        p_account_id IN NUMBER
    );

    FUNCTION GetTotalBalance(
        p_customer_id IN NUMBER
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount(
        p_account_id IN NUMBER,
        p_customer_id IN NUMBER,
        p_account_type IN VARCHAR2,
        p_balance IN NUMBER
    )
    AS
    BEGIN
        INSERT INTO Accounts(AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES(p_account_id, p_customer_id, p_account_type, p_balance, SYSDATE);

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Account opened successfully.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('Error: Account already exists.');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END OpenAccount;

    PROCEDURE CloseAccount(
        p_account_id IN NUMBER
    )
    AS
    BEGIN
        DELETE FROM Accounts
        WHERE AccountID = p_account_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Account not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Account closed successfully.');
        END IF;
    END CloseAccount;

    FUNCTION GetTotalBalance(
        p_customer_id IN NUMBER
    ) RETURN NUMBER
    AS
        v_total_balance NUMBER;
    BEGIN
        SELECT NVL(SUM(Balance), 0)
        INTO v_total_balance
        FROM Accounts
        WHERE CustomerID = p_customer_id;

        RETURN v_total_balance;
    END GetTotalBalance;

END AccountOperations;
/

DECLARE
    v_customer_balance NUMBER;
    v_annual_salary NUMBER;
    v_total_balance NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('===== Customer Package =====');

    CustomerManagement.AddCustomer(3, 'Robert Brown', TO_DATE('1995-02-10','YYYY-MM-DD'), 3000);
    CustomerManagement.UpdateCustomer(1, 'John Updated', 2000);

    v_customer_balance := CustomerManagement.GetCustomerBalance(1);
    DBMS_OUTPUT.PUT_LINE('Customer Balance: ' || v_customer_balance);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '===== Employee Package =====');

    EmployeeManagement.HireEmployee(3, 'Rahul Sharma', 'Tester', 50000, 'IT', SYSDATE);
    EmployeeManagement.UpdateEmployee(2, 'Senior Developer', 75000, 'IT');

    v_annual_salary := EmployeeManagement.CalculateAnnualSalary(2);
    DBMS_OUTPUT.PUT_LINE('Annual Salary: ' || v_annual_salary);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '===== Account Package =====');

    AccountOperations.OpenAccount(4, 3, 'Savings', 9000);
    AccountOperations.CloseAccount(2);

    v_total_balance := AccountOperations.GetTotalBalance(1);
    DBMS_OUTPUT.PUT_LINE('Total Customer Balance: ' || v_total_balance);
END;
/

SELECT * FROM Customers;
SELECT * FROM Employees;
SELECT * FROM Accounts;