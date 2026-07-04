SET SERVEROUTPUT ON;

BEGIN EXECUTE IMMEDIATE 'DROP TRIGGER UpdateCustomerLastModified'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TRIGGER LogTransaction'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TRIGGER CheckTransactionRules'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE AuditLog CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE Transactions CASCADE CONSTRAINTS'; EXCEPTION WHEN OTHERS THEN NULL; END;
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
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE AuditLog (
    AuditID NUMBER PRIMARY KEY,
    TransactionID NUMBER,
    AccountID NUMBER,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    AuditDate DATE
);

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15','YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20','YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 10000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 5000, SYSDATE);

COMMIT;

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_balance NUMBER;
BEGIN
    SELECT Balance
    INTO v_balance
    FROM Accounts
    WHERE AccountID = :NEW.AccountID;

    IF UPPER(:NEW.TransactionType) = 'DEPOSIT' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'Deposit amount must be positive.');
        END IF;

    ELSIF UPPER(:NEW.TransactionType) = 'WITHDRAWAL' THEN
        IF :NEW.Amount <= 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Withdrawal amount must be positive.');
        END IF;

        IF :NEW.Amount > v_balance THEN
            RAISE_APPLICATION_ERROR(-20003, 'Withdrawal amount cannot exceed account balance.');
        END IF;

    ELSE
        RAISE_APPLICATION_ERROR(-20004, 'Invalid transaction type.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_audit_id NUMBER;
BEGIN
    SELECT NVL(MAX(AuditID), 0) + 1
    INTO v_audit_id
    FROM AuditLog;

    INSERT INTO AuditLog (
        AuditID,
        TransactionID,
        AccountID,
        Amount,
        TransactionType,
        AuditDate
    )
    VALUES (
        v_audit_id,
        :NEW.TransactionID,
        :NEW.AccountID,
        :NEW.Amount,
        :NEW.TransactionType,
        SYSDATE
    );
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 1: Updating customer record');
END;
/

UPDATE Customers
SET Balance = Balance + 500
WHERE CustomerID = 1;

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 2: Inserting valid transactions');
END;
/

INSERT INTO Transactions VALUES (1, 1, SYSDATE, 2000, 'Deposit');
INSERT INTO Transactions VALUES (2, 2, SYSDATE, 1000, 'Withdrawal');

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 3: Testing invalid withdrawal');
END;
/

BEGIN
    INSERT INTO Transactions VALUES (3, 2, SYSDATE, 9000, 'Withdrawal');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 3: Testing invalid deposit');
END;
/

BEGIN
    INSERT INTO Transactions VALUES (4, 1, SYSDATE, -500, 'Deposit');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
        ROLLBACK;
END;
/

SELECT * FROM Customers;
SELECT * FROM Transactions;
SELECT * FROM AuditLog;