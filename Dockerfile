FROM python:3.11-slim

WORKDIR /app

# Copiar scripts de inicialização
COPY schema.sql .
COPY init_db.py .

# Criar diretório para o banco de dados
RUN mkdir -p data

# Inicializar o banco de dados
RUN python init_db.py

# Volume para persistência do banco de dados
VOLUME ["/app/data"]

# Comando para manter o container rodando
CMD ["tail", "-f", "/dev/null"]
