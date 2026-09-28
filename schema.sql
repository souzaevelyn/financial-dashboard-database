-- Schema do Banco de Dados SQLite para Financial Dashboard
-- Autor: Sistema Financeiro
-- Data: 2024

-- Tabela de Usuários
CREATE TABLE IF NOT EXISTS user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password VARCHAR(200) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Cotações
CREATE TABLE IF NOT EXISTS quote (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    currency_pair VARCHAR(20) NOT NULL,
    rate REAL NOT NULL,
    date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);

-- Tabela de Conversões
CREATE TABLE IF NOT EXISTS conversion (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    amount_brl REAL NOT NULL,
    amount_usd REAL NOT NULL,
    rate REAL NOT NULL,
    date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);

-- Índices para melhorar performance
CREATE INDEX IF NOT EXISTS idx_user_email ON user(email);
CREATE INDEX IF NOT EXISTS idx_quote_user_id ON quote(user_id);
CREATE INDEX IF NOT EXISTS idx_quote_date ON quote(date);
CREATE INDEX IF NOT EXISTS idx_conversion_user_id ON conversion(user_id);
CREATE INDEX IF NOT EXISTS idx_conversion_date ON conversion(date);

-- Dados de exemplo (opcional, para teste)
-- INSERT INTO user (name, email, password) VALUES 
-- ('Usuario Teste', 'teste@example.com', 'hashed_password_here');
