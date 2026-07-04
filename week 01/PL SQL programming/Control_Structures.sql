SET SERVEROUTPUT ON;

DROP TABLE Loans CASCADE CONSTRAINTS;
DROP TABLE Transactions CASCADE CONSTRAINTS;
DROP TABLE Accounts CASCADE CONSTRAINTS;
DROP TABLE Customers CASCADE CONSTRAINTS;

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

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
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

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 12000, 'FALSE', SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, 'FALSE', SYSDATE);
INSERT INTO Customers VALUES (3, 'Robert Brown', TO_DATE('1958-02-10', 'YYYY-MM-DD'), 25000, 'FALSE', SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 12000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 1500, SYSDATE);
INSERT INTO Accounts VALUES (3, 3, 'Savings', 25000, SYSDATE);

INSERT INTO Loans VALUES (1, 1, 5000, 8, SYSDATE, SYSDATE + 20);
INSERT INTO Loans VALUES (2, 2, 10000, 10, SYSDATE, SYSDATE + 60);
INSERT INTO Loans VALUES (3, 3, 7000, 9, SYSDATE, SYSDATE + 25);

COMMIT;

PROMPT Scenario 1: Apply 1% discount to loan interest rates for customers above 60

BEGIN
    FOR customer_record IN (
        SELECT c.CustomerID, c.Name, c.DOB, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
    )
    LOOP
        IF TRUNC(MONTHS_BETWEEN(SYSDATE, customer_record.DOB) / 12) > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE LoanID = customer_record.LoanID;

            DBMS_OUTPUT.PUT_LINE(
                'Discount applied for ' || customer_record.Name ||
                ', Loan ID: ' || customer_record.LoanID
            );
        END IF;
    END LOOP;

    COMMIT;
END;
/

PROMPT Scenario 2: Mark customers as VIP if balance is greater than 10000

BEGIN
    FOR customer_record IN (
        SELECT CustomerID, Name, Balance
        FROM Customers
    )
    LOOP
        IF customer_record.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'TRUE'
            WHERE CustomerID = customer_record.CustomerID;

            DBMS_OUTPUT.PUT_LINE(customer_record.Name || ' promoted to VIP.');
        ELSE
            UPDATE Customers
            SET IsVIP = 'FALSE'
            WHERE CustomerID = customer_record.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
END;
/

PROMPT Scenario 3: Reminder for loans due within next 30 days

BEGIN
    FOR loan_record IN (
        SELECT c.Name, l.LoanID, l.EndDate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE(
            'Reminder: Dear ' || loan_record.Name ||
            ', your loan ID ' || loan_record.LoanID ||
            ' is due on ' || TO_CHAR(loan_record.EndDate, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/

PROMPT Final Customers Table

SELECT * FROM Customers;

PROMPT Final Loans Table

SELECT * FROM Loans;