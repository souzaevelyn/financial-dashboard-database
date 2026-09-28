#!/usr/bin/env python3
"""
Script de inicialização do banco de dados SQLite
Este script cria o banco de dados e executa o schema.sql
"""

import sqlite3
import os

def init_database():
    """Inicializa o banco de dados com o schema"""
    
    # Caminho do banco de dados
    db_path = os.path.join(os.path.dirname(__file__), 'financial.db')
    
    # Caminho do schema SQL
    schema_path = os.path.join(os.path.dirname(__file__), 'schema.sql')
    
    try:
        # Conectar ao banco de dados (cria se não existir)
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # Ler e executar o schema
        with open(schema_path, 'r', encoding='utf-8') as f:
            schema_sql = f.read()
            cursor.executescript(schema_sql)
        
        # Commit das mudanças
        conn.commit()
        
        print(f"[OK] Banco de dados inicializado com sucesso: {db_path}")
        print(f"[OK] Schema executado: {schema_path}")
        
        # Mostrar tabelas criadas
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        print(f"[OK] Tabelas criadas: {[table[0] for table in tables]}")
        
    except sqlite3.Error as e:
        print(f"[ERROR] Erro ao inicializar banco de dados: {e}")
        return False
    except Exception as e:
        print(f"[ERROR] Erro inesperado: {e}")
        return False
    finally:
        if conn:
            conn.close()
    
    return True

if __name__ == "__main__":
    print("Inicializando banco de dados Financial Dashboard...")
    if init_database():
        print("\nBanco de dados pronto para uso!")
    else:
        print("\nFalha ao inicializar banco de dados.")
