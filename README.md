# Financial Dashboard Database

Módulo de persistência de dados para o sistema de Dashboard Financeiro, utilizando SQLite.

## Descrição

Este módulo contém o schema do banco de dados e scripts de inicialização para o sistema de Dashboard Financeiro. Utiliza SQLite como banco de dados relacional, sendo ideal para desenvolvimento e pequenas aplicações.

## Estrutura do Banco de Dados

### Tabelas

#### user
Armazena informações dos usuários do sistema.

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | INTEGER (PK) | Identificador único do usuário |
| name | VARCHAR(100) | Nome completo do usuário |
| email | VARCHAR(120) | Email do usuário (único) |
| password | VARCHAR(200) | Senha hash do usuário |
| created_at | TIMESTAMP | Data de criação do registro |

#### quote
Armazena cotações de moedas salvas pelos usuários.

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | INTEGER (PK) | Identificador único da cotação |
| user_id | INTEGER (FK) | ID do usuário que salvou a cotação |
| currency_pair | VARCHAR(20) | Par de moedas (ex: USDBRL) |
| rate | REAL | Taxa de câmbio |
| date | TIMESTAMP | Data da cotação |
| created_at | TIMESTAMP | Data de criação do registro |

#### conversion
Armazena conversões de BRL para USD realizadas pelos usuários.

| Coluna | Tipo | Descrição |
|--------|------|-----------|
| id | INTEGER (PK) | Identificador único da conversão |
| user_id | INTEGER (FK) | ID do usuário que fez a conversão |
| amount_brl | REAL | Valor em Reais |
| amount_usd | REAL | Valor em Dólares |
| rate | REAL | Taxa de câmbio utilizada |
| date | TIMESTAMP | Data da conversão |
| created_at | TIMESTAMP | Data de criação do registro |

### Índices

- `idx_user_email`: Índice no campo email da tabela user
- `idx_quote_user_id`: Índice no campo user_id da tabela quote
- `idx_quote_date`: Índice no campo date da tabela quote
- `idx_conversion_user_id`: Índice no campo user_id da tabela conversion
- `idx_conversion_date`: Índice no campo date da tabela conversion

## Instalação

### Pré-requisitos
- Python 3.11 ou superior
- SQLite (incluído no Python)

### Configuração do Ambiente Local

1. Navegue até o diretório do banco de dados:
```bash
cd financial-dashboard/database
```

2. Execute o script de inicialização:
```bash
python init_db.py
```

Isso criará o arquivo `financial.db` com todas as tabelas e índices definidos.

## Uso

### Acesso Direto ao Banco de Dados

Você pode acessar o banco de dados diretamente usando SQLite:

```bash
sqlite3 financial.db
```

Exemplos de consultas:

```sql
-- Listar todos os usuários
SELECT * FROM user;

-- Listar cotações de um usuário específico
SELECT * FROM quote WHERE user_id = 1;

-- Listar conversões recentes
SELECT * FROM conversion ORDER BY created_at DESC LIMIT 10;
```

### Integração com Backend

O backend Flask se conecta automaticamente ao banco de dados através da configuração:

```python
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///../database/financial.db'
```

## Docker

### Construir a imagem Docker
```bash
docker build -t financial-dashboard-db .
```

### Executar o container
```bash
docker run -v $(pwd)/data:/app/data financial-dashboard-db
```

### Executar com persistência
```bash
docker run -d \
  --name financial-db \
  -v $(pwd)/financial.db:/app/financial.db \
  financial-dashboard-db
```

## Backup e Restauração

### Backup
```bash
# Backup do banco de dados
cp financial.db financial.db.backup

# Ou usando SQLite
sqlite3 financial.db ".backup financial.db.backup"
```

### Restauração
```bash
# Restaurar do backup
cp financial.db.backup financial.db
```

## Manutenção

### Limpar Dados de Teste
```sql
-- Deletar todos os dados (cuidado!)
DELETE FROM quote;
DELETE FROM conversion;
DELETE FROM user;
```

### Recriar o Banco de Dados
```bash
# Remover o banco de dados existente
rm financial.db

# Reexecutar a inicialização
python init_db.py
```

## Estrutura do Projeto

```
database/
├── schema.sql         # Schema SQL do banco de dados
├── init_db.py         # Script de inicialização
├── financial.db       # Banco de dados SQLite (criado após init)
├── Dockerfile         # Configuração Docker
└── README.md          # Documentação
```

## Segurança

- Senhas são armazenadas como hash (não texto plano)
- Índices criados para melhorar performance
- Relacionamentos com CASCADE DELETE para integridade referencial

## Troubleshooting

### Erro: "database is locked"
Isso pode acontecer se múltiplas instâncias tentarem acessar o banco simultaneamente. Certifique-se de que apenas uma instância da API está rodando.

### Erro: "no such table"
Execute o script de inicialização novamente:
```bash
python init_db.py
```

## Tecnologias Utilizadas

- SQLite 3
- Python 3.11
- SQL

## Licença

Este projeto é desenvolvido para fins educacionais.
