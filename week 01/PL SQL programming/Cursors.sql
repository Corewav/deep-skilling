SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE Transactions CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Loans CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Accounts CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
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

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(20),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Customers VALUES (1,'John Doe',TO_DATE('1985-05-15','YYYY-MM-DD'),10000,SYSDATE);
INSERT INTO Customers VALUES (2,'Jane Smith',TO_DATE('1990-07-20','YYYY-MM-DD'),15000,SYSDATE);

INSERT INTO Accounts VALUES (1,1,'Savings',10000,SYSDATE);
INSERT INTO Accounts VALUES (2,2,'Checking',15000,SYSDATE);

INSERT INTO Transactions VALUES (1,1,SYSDATE,2000,'Deposit');
INSERT INTO Transactions VALUES (2,1,SYSDATE,500,'Withdrawal');
INSERT INTO Transactions VALUES (3,2,SYSDATE,3000,'Deposit');

INSERT INTO Loans VALUES (1,1,50000,8,SYSDATE,ADD_MONTHS(SYSDATE,60));
INSERT INTO Loans VALUES (2,2,80000,10,SYSDATE,ADD_MONTHS(SYSDATE,48));

COMMIT;

DECLARE

    CURSOR GenerateMonthlyStatements IS
    SELECT c.CustomerID,
           c.Name,
           t.TransactionID,
           t.Amount,
           t.TransactionType,
           t.TransactionDate
    FROM Customers c
    JOIN Accounts a
    ON c.CustomerID = a.CustomerID
    JOIN Transactions t
    ON a.AccountID = t.AccountID
    WHERE EXTRACT(MONTH FROM t.TransactionDate)=EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM t.TransactionDate)=EXTRACT(YEAR FROM SYSDATE);

BEGIN

    DBMS_OUTPUT.PUT_LINE('===== Monthly Statements =====');

    FOR transaction_record IN GenerateMonthlyStatements LOOP

        DBMS_OUTPUT.PUT_LINE(
            'Customer : '||transaction_record.Name||
            ' | Transaction ID : '||transaction_record.TransactionID||
            ' | Type : '||transaction_record.TransactionType||
            ' | Amount : '||transaction_record.Amount
        );

    END LOOP;

END;
/

DECLARE

    CURSOR ApplyAnnualFee IS
    SELECT AccountID
    FROM Accounts;

    annual_fee NUMBER:=500;

BEGIN

    DBMS_OUTPUT.PUT_LINE(CHR(10)||'===== Applying Annual Fee =====');

    FOR account_record IN ApplyAnnualFee LOOP

        UPDATE Accounts
        SET Balance=Balance-annual_fee,
            LastModified=SYSDATE
        WHERE AccountID=account_record.AccountID;

        DBMS_OUTPUT.PUT_LINE('Annual fee applied to Account ID : '||account_record.AccountID);

    END LOOP;

    COMMIT;

END;
/

DECLARE

    CURSOR UpdateLoanInterestRates IS
    SELECT LoanID,InterestRate
    FROM Loans;

BEGIN

    DBMS_OUTPUT.PUT_LINE(CHR(10)||'===== Updating Loan Interest Rates =====');

    FOR loan_record IN UpdateLoanInterestRates LOOP

        UPDATE Loans
        SET InterestRate=InterestRate+0.5
        WHERE LoanID=loan_record.LoanID;

        DBMS_OUTPUT.PUT_LINE(
            'Loan ID : '||
            loan_record.LoanID||
            ' Updated Interest Rate : '||
            (loan_record.InterestRate+0.5)||'%'
        );

    END LOOP;

    COMMIT;

END;
/

SELECT * FROM Accounts;

SELECT * FROM Loans;