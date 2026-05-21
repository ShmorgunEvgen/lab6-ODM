DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS tokens;
DROP TABLE IF EXISTS wallet;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    creation_time TIMESTAMP,
    password_hash VARCHAR(255) NOT NULL
);
CREATE TABLE tokens (
    id SERIAL PRIMARY KEY,
	user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    token_value VARCHAR(255) UNIQUE NOT NULL,
    expiration_time TIMESTAMP,
    creation_time TIMESTAMP,
    is_revoked BOOLEAN DEFAULT FALSE
);
CREATE TABLE wallet (
    id SERIAL PRIMARY KEY,
	user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id),
    name VARCHAR(100) NOT NULL,
    balance NUMERIC(20, 2),
    currency VARCHAR(3) NOT NULL
);
CREATE TABLE category (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL CHECK (type IN ('income', 'expense'))
);
CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    category_id INTEGER,
    FOREIGN KEY (category_id) REFERENCES category(id),
    amount NUMERIC(20, 2) CHECK (amount > 0),
    creation_time TIMESTAMP,
    wallet_id INTEGER REFERENCES wallet(id),
    comment VARCHAR(100)
);
INSERT INTO users (name, email, creation_time, password_hash)
VALUES
    ('Alice', 'alice@example.com', CURRENT_TIMESTAMP, 'pmWkWSBCL51Bfkhn79xPuKBKHz//H6B+mY6G9/eieuM='),
    ('Bob', 'bob@example.com', CURRENT_TIMESTAMP, 'Z23S500sHzxfN/oNozH9fs3/ywTdCYOXXiYwOA8KOMg='),
	('Carol', 'carol@example.com', CURRENT_TIMESTAMP, 'eUovZaD3LeVZBMzlJCVSWXhQD1CwrTIH74NQF8HqRU=');

INSERT INTO tokens (user_id, token_value, expiration_time, creation_time)
VALUES
    (1, 'alice_token_123', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP),
    (2, 'bob_token_456', CURRENT_TIMESTAMP + INTERVAL '3 days', CURRENT_TIMESTAMP),
	(3, 'carol_token_456', CURRENT_TIMESTAMP + INTERVAL '2 days', CURRENT_TIMESTAMP);

INSERT INTO wallet (user_id, name, balance, currency)
VALUES
    (1, 'Alice Головний Рахунок', 15000.50, 'UAH'),
    (1, 'Alice Доларовий Рахунок', 500.00, 'USD'),
    (2, 'Bob Головний Рахунок', 0.00, 'UAH'),
	(3, 'Carol Головний Рахунок', 1000.00, 'UAH');

INSERT INTO category (name, type)
VALUES
    ('Заплата', 'income'),
    ('Стипендія', 'income'),
    ('Їжа', 'expense'),
    ('Транспорт', 'expense'),
    ('Розваги', 'expense');

INSERT INTO transactions (category_id, amount, creation_time, wallet_id, comment)
VALUES
    (2, 2000.00, CURRENT_TIMESTAMP, 1, 'Стипендія'),
    (3, 430.75, CURRENT_TIMESTAMP, 1, 'Магазин'),
    (4, 35.00, CURRENT_TIMESTAMP, 1, 'Білет'),
    (2, 50000.00, CURRENT_TIMESTAMP, 3, 'Зарплата'),
    (5, 50000.00, CURRENT_TIMESTAMP, 3, 'Казино'),
	(1, 20000.00, CURRENT_TIMESTAMP, 4, '');

ALTER TABLE transactions
DROP COLUMN comment;

