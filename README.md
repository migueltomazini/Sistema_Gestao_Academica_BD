# Sistema de Gestão Acadêmica - Projeto Final de Bases de Dados (SCC0240)

## Descrição do Projeto

Este repositório contém o Projeto Final da disciplina de **Bases de Dados (SCC0240)**, do Instituto de Ciências Matemáticas e de Computação (ICMC) da Universidade de São Paulo (USP).

O objetivo do projeto é desenvolver um banco de dados completo para um sistema de gestão acadêmica de uma instituição de ensino. O trabalho abrange desde a modelagem conceitual (MER-X) e relacional até a implementação e manipulação do banco de dados em PostgreSQL, incluindo a criação de tabelas, inserção de dados, consultas complexas, otimização com índices e uso de visões.

## Integrantes do Grupo

| Nome                                | NUSP     |
| ----------------------------------- | -------- |
| Bruno Basckeira Chinaglia           | 14562233 |
| Isabela Beatriz Sousa Nunes Farias  | 13823833 |
| Miguel Rodrigues Tomazini           | 14599300 |
| Victor Moreli dos Santos            | 14610514 |

### Como rodar o projeto

Certifique-se de que o PostgreSQL e a ferramenta `psql` estão instalados e configurados corretamente em seu sistema antes de continuar.

## Linux

1. **Clone este repositório:**

```bash
git clone https://github.com/migueltomazini/Sistema_Gestao_Academica_BD.git
cd Sistema_Gestao_Academica_BD/sql
```

2. Crie o banco de dados no PostgreSQL:

```bash
sudo -u postgres psql

CREATE DATABASE gestao_academica;
\q
```

3. Execute os scripts SQL na ordem correta:

```bash
# 1. Criação das tabelas
sudo -u postgres psql -d gestao_academica -f 4.criacao_tabelas.sql

# 2. Inserção de dados
sudo -u postgres psql -d gestao_academica -f 4.insercao_dados.sql

# 3. Criação das visões (Exercício 8)
sudo -u postgres psql -d gestao_academica -f 8.visoes.sql

# 4. Criação dos índices (Exercício 7)
sudo -u postgres psql -d gestao_academica -f 7.indices.sql

# 5. Execução das consultas (Exercício 6)
sudo -u postgres psql -d gestao_academica -a -f 6.consultas.sql
```

## Windows

1. Clone este repositório:

```bash
git clone https://github.com/migueltomazini/Sistema_Gestao_Academica_BD.git
cd Sistema_Gestao_Academica_BD\sql
```

2. Crie o banco de dados no PostgreSQL:

```bash
psql -U postgres

CREATE DATABASE gestao_academica;
\q
```
> Dica: Caso psql não seja reconhecido, adicione o caminho da pasta bin do PostgreSQL (por exemplo: C:\Program Files\PostgreSQL\17\bin) às variáveis de ambiente do sistema.

3. Execute os scripts SQL na ordem correta:

```bash
# 1. Criação das tabelas
psql -U postgres -d gestao_academica -f 4.criacao_tabelas.sql

# 2. Inserção de dados
psql -U postgres -d gestao_academica -f 4.insercao_dados.sql

# 3. Criação das visões (Exercício 8)
psql -U postgres -d gestao_academica -f 8.visoes.sql

# 4. Criação dos índices (Exercício 7)
psql -U postgres -d gestao_academica -f 7.indices.sql

# 5. Execução das consultas (Exercício 6)
psql -U postgres -d gestao_academica -a -f 6.consultas.sql
```
