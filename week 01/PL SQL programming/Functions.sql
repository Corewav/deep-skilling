SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION CalculateAge'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION CalculateMonthlyInstallment'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP FUNCTION HasSufficientBalance'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Accounts CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Customers CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Loans CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
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
    LastModified DATE
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE
);

INSERT INTO Customers VALUES (1,'John Doe',TO_DATE('1985-05-15','YYYY-MM-DD'),1000,SYSDATE);
INSERT INTO Customers VALUES (2,'Jane Smith',TO_DATE('1990-07-20','YYYY-MM-DD'),1500,SYSDATE);

INSERT INTO Accounts VALUES (1,1,'Savings',10000,SYSDATE);
INSERT INTO Accounts VALUES (2,2,'Checking',5000,SYSDATE);

INSERT INTO Loans VALUES (1,1,500000,8,SYSDATE,ADD_MONTHS(SYSDATE,60));

COMMIT;

CREATE OR REPLACE FUNCTION CalculateAge(
    p_dob DATE
)
RETURN NUMBER
IS
    v_age NUMBER;
BEGIN
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE,p_dob)/12);
    RETURN v_age;
END;
/

CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    p_loan_amount NUMBER,
    p_interest_rate NUMBER,
    p_years NUMBER
)
RETURN NUMBER
IS
    v_monthly_installment NUMBER;
BEGIN
    v_monthly_installment :=
        (p_loan_amount + (p_loan_amount*p_interest_rate*p_years/100))
        /(p_years*12);

    RETURN ROUND(v_monthly_installment,2);
END;
/

CREATE OR REPLACE FUNCTION HasSufficientBalance(
    p_account_id NUMBER,
    p_amount NUMBER
)
RETURN BOOLEAN
IS
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID=p_account_id;

    IF v_balance>=p_amount THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

DECLARE
    v_age NUMBER;
    v_emi NUMBER;
BEGIN

    DBMS_OUTPUT.PUT_LINE('Scenario 1');

    v_age:=CalculateAge(TO_DATE('1985-05-15','YYYY-MM-DD'));

    DBMS_OUTPUT.PUT_LINE('Age = '||v_age);

    DBMS_OUTPUT.PUT_LINE(CHR(10)||'Scenario 2');

    v_emi:=CalculateMonthlyInstallment(500000,8,5);

    DBMS_OUTPUT.PUT_LINE('Monthly Installment = '||v_emi);

    DBMS_OUTPUT.PUT_LINE(CHR(10)||'Scenario 3');

    IF HasSufficientBalance(1,3000) THEN
        DBMS_OUTPUT.PUT_LINE('Customer has sufficient balance.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
    END IF;

    IF HasSufficientBalance(2,10000) THEN
        DBMS_OUTPUT.PUT_LINE('Customer has sufficient balance.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
    END IF;

END;
/