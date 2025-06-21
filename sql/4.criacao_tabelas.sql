-- Arquivo: 4.criacao_tabelas.sql
-- Descrição: Script para criar toda a estrutura do banco de dados (tabelas e restrições).

-- Já normalizadas

-- Apaga as tabelas existentes para garantir um ambiente limpo.
DROP TABLE IF EXISTS Matricula_Nota CASCADE;
DROP TABLE IF EXISTS Avaliacao CASCADE;
DROP TABLE IF EXISTS RealizarMatricula CASCADE;
DROP TABLE IF EXISTS Oferecimento CASCADE;
DROP TABLE IF EXISTS DiscipCompoeCurso CASCADE;
DROP TABLE IF EXISTS Professor_AreaEspecializacao CASCADE;
DROP TABLE IF EXISTS Curso_Infraestrutura CASCADE;
DROP TABLE IF EXISTS RegrasGeral CASCADE;
DROP TABLE IF EXISTS Curso CASCADE;
DROP TABLE IF EXISTS Departamento CASCADE;
DROP TABLE IF EXISTS Disciplina CASCADE;
DROP TABLE IF EXISTS Aluno CASCADE;
DROP TABLE IF EXISTS Professor CASCADE;
DROP TABLE IF EXISTS Funcionario CASCADE;
DROP TABLE IF EXISTS RecebeMsg CASCADE;
DROP TABLE IF EXISTS Mensagem CASCADE;
DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS Unidade_Escola CASCADE;
DROP TABLE IF EXISTS Sala CASCADE;
DROP TABLE IF EXISTS CriterioAprovacao CASCADE;
DROP TABLE IF EXISTS Bloco CASCADE; 
DROP TABLE IF EXISTS CursoRequisitoDisciplina CASCADE; 
DROP TABLE IF EXISTS CursoRequisitoCurso CASCADE; 
DROP TABLE IF EXISTS Matricula_Bolsa CASCADE; 

-- Tabelas que não possuem chaves estrangeiras (ou que referenciam tabelas já criadas)
CREATE TABLE Unidade_Escola (
    ID_Unidade SERIAL PRIMARY KEY,
    Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(2) NOT NULL,
    Pais VARCHAR(50) NOT NULL
);

CREATE TABLE Bloco (
    ID_Unidade INTEGER NOT NULL,
    NomeBloco VARCHAR(100) NOT NULL,
    PRIMARY KEY (ID_Unidade, NomeBloco),
    FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Usuario (
    NomeUsuario VARCHAR(100) NOT NULL,
    SobrenomeUsuario VARCHAR(100) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    Papel VARCHAR(20) NOT NULL CHECK (Papel IN ('Aluno', 'Professor', 'Funcionario')),
    DataNascimento DATE NOT NULL,
    Endereco_Rua VARCHAR(255),
    Endereco_Nro VARCHAR(20),
    Endereco_Bairro VARCHAR(100),
    Sexo VARCHAR(20),
    Email VARCHAR(255) UNIQUE NOT NULL,
    Senha VARCHAR(255) NOT NULL,
    ID_Unidade INTEGER NOT NULL,
    NomeBloco VARCHAR(100),   -- Pode ser NULL pois o usuário não necessariamente deve estar associado a um bloco, somente a uma unidade
    PRIMARY KEY (NomeUsuario, SobrenomeUsuario, Telefone),
    FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabelas de especialização de Usuario
CREATE TABLE Aluno (
    NomeAluno VARCHAR(100) NOT NULL,
    SobrenomeAluno VARCHAR(100) NOT NULL,
    TelefoneAluno VARCHAR(15) NOT NULL,
    PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno),
    FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno) REFERENCES Usuario(NomeUsuario, SobrenomeUsuario, Telefone) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Professor (
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    Titulacao VARCHAR(100),
    PRIMARY KEY (NomeProfessor, SobrenomeProfessor, TelefoneProfessor),
    FOREIGN KEY (NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES Usuario(NomeUsuario, SobrenomeUsuario, Telefone) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Funcionario (
    NomeFuncionario VARCHAR(100) NOT NULL,
    SobrenomeFuncionario VARCHAR(100) NOT NULL,
    TelefoneFuncionario VARCHAR(15) NOT NULL,
    PRIMARY KEY (NomeFuncionario, SobrenomeFuncionario, TelefoneFuncionario),
    FOREIGN KEY (NomeFuncionario, SobrenomeFuncionario, TelefoneFuncionario) REFERENCES Usuario(NomeUsuario, SobrenomeUsuario, Telefone) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabelas principais da estrutura acadêmica
CREATE TABLE Departamento (
    Codigo VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(255) UNIQUE NOT NULL,
    ProfessorChefe_Nome VARCHAR(100) NOT NULL,
    ProfessorChefe_Sobrenome VARCHAR(100) NOT NULL,
    ProfessorChefe_Telefone VARCHAR(15) NOT NULL,
    FOREIGN KEY (ProfessorChefe_Nome, ProfessorChefe_Sobrenome, ProfessorChefe_Telefone) REFERENCES Professor(NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Disciplina (
    Sigla VARCHAR(10) PRIMARY KEY,
    Nome_Disciplina VARCHAR(255) UNIQUE NOT NULL,
    Quantidade_AulasSemanais INTEGER NOT NULL CHECK (Quantidade_AulasSemanais > 0),
    Material_Didatico TEXT,
    ID_Unidade INTEGER NOT NULL,
    NomeBloco VARCHAR(100),
    FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabela de Salas
CREATE TABLE Sala (
    Codigo VARCHAR(20) PRIMARY KEY,
    CapacidadeMaxSala INTEGER NOT NULL CHECK (CapacidadeMaxSala > 0)
);

CREATE TABLE Curso (
    ID_Curso VARCHAR(10) PRIMARY KEY,
    NomeCurso VARCHAR(255) UNIQUE NOT NULL,
    CargaHoraria INTEGER NOT NULL,
    NumeroVagas INTEGER NOT NULL,
    Ementa TEXT,
    SalaPadrao VARCHAR(20),
    Nivel_de_Ensino VARCHAR(50) NOT NULL,
    Departamento_Codigo VARCHAR(10) NOT NULL,
    ID_Unidade INTEGER NOT NULL,
    NomeBloco VARCHAR(100),
    FOREIGN KEY (SalaPadrao) REFERENCES Sala(Codigo) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (Departamento_Codigo) REFERENCES Departamento(Codigo) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (ID_Unidade) REFERENCES Unidade_Escola(ID_Unidade) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- Tabelas de relacionamento e atributos multivalorados
CREATE TABLE DiscipCompoeCurso (
    ID_Curso VARCHAR(10) NOT NULL,
    Sigla VARCHAR(10) NOT NULL,
    Semestre INTEGER NOT NULL,
    PRIMARY KEY (ID_Curso, Sigla),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Sigla) REFERENCES Disciplina(Sigla) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Professor_AreaEspecializacao (
    Professor_Nome VARCHAR(100) NOT NULL,
    Professor_Sobrenome VARCHAR(100) NOT NULL,
    Professor_Telefone VARCHAR(15) NOT NULL,
    AreaEspecializacao VARCHAR(255) NOT NULL,
    PRIMARY KEY (Professor_Nome, Professor_Sobrenome, Professor_Telefone, AreaEspecializacao),
    FOREIGN KEY (Professor_Nome, Professor_Sobrenome, Professor_Telefone) REFERENCES Professor(NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabelas de oferta, matrícula e avaliação
CREATE TABLE Oferecimento (
    Sigla_Disciplina VARCHAR(10) NOT NULL,
    Periodo INTEGER NOT NULL,
    Ano INTEGER NOT NULL,
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    CapacidadeMaxTurma INTEGER,
    Sala_Codigo VARCHAR(20) NOT NULL,
    PRIMARY KEY (Sigla_Disciplina, Periodo, Ano, NomeProfessor, SobrenomeProfessor, TelefoneProfessor),
    FOREIGN KEY (Sigla_Disciplina) REFERENCES Disciplina(Sigla) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES Professor(NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Sala_Codigo) REFERENCES Sala(Codigo) ON DELETE RESTRICT ON UPDATE CASCADE 
);

CREATE TABLE RealizarMatricula (
    NomeAluno VARCHAR(100) NOT NULL,
    SobrenomeAluno VARCHAR(100) NOT NULL,
    TelefoneAluno VARCHAR(15) NOT NULL,
    Sigla_Disciplina VARCHAR(10) NOT NULL,
    Periodo_Oferecimento INTEGER NOT NULL,
    Ano_Oferecimento INTEGER NOT NULL,
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    DataMatricula DATE NOT NULL,
    Status VARCHAR(50) NOT NULL,
    PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor),
    FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno) REFERENCES Aluno(NomeAluno, SobrenomeAluno, TelefoneAluno) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES Oferecimento(Sigla_Disciplina, Periodo, Ano, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Avaliacao (
    -- A chave primária é a mesma da matrícula para garantir que um aluno só possa avaliar uma turma que cursou uma vez.
    NomeAluno VARCHAR(100) NOT NULL,
    SobrenomeAluno VARCHAR(100) NOT NULL,
    TelefoneAluno VARCHAR(15) NOT NULL,
    Sigla_Disciplina VARCHAR(10) NOT NULL,
    Periodo_Oferecimento INTEGER NOT NULL,
    Ano_Oferecimento INTEGER NOT NULL,
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    Comentario TEXT,
    Class_Didatica INTEGER CHECK (Class_Didatica BETWEEN 1 AND 5),
    Class_Material INTEGER CHECK (Class_Material BETWEEN 1 AND 5),
    Class_Relevancia INTEGER CHECK (Class_Relevancia BETWEEN 1 AND 5),
    Class_Infra INTEGER CHECK (Class_Infra BETWEEN 1 AND 5),
    PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor),
    FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES RealizarMatricula(NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE CASCADE ON UPDATE CASCADE
);


-- Tabela para o atributo multivalorado 'Notas' da matrícula.
CREATE TABLE Matricula_Nota (
    NomeAluno VARCHAR(100) NOT NULL,
    SobrenomeAluno VARCHAR(100) NOT NULL,
    TelefoneAluno VARCHAR(15) NOT NULL,
    Sigla_Disciplina VARCHAR(10) NOT NULL,
    Periodo_Oferecimento INTEGER NOT NULL,
    Ano_Oferecimento INTEGER NOT NULL,
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    Descricao_Avaliacao VARCHAR(100) NOT NULL, -- Ex: "P1", "Trabalho Final", "Nota Final"
    Nota NUMERIC(4, 2) NOT NULL,
    PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, Descricao_Avaliacao),
    FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES RealizarMatricula(NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Demais tabelas para atributos multivalorados, conforme o modelo.
CREATE TABLE CursoRequisitoDisciplina (
    ID_CursoAlvo VARCHAR(10) NOT NULL,
    SiglaRequisito VARCHAR(10) NOT NULL,
    PRIMARY KEY (ID_CursoAlvo, SiglaRequisito),
    FOREIGN KEY (ID_CursoAlvo) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SiglaRequisito) REFERENCES Disciplina(Sigla) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CursoRequisitoCurso (
    ID_CursoAlvo VARCHAR(10) NOT NULL,
    ID_CursoRequisito VARCHAR(10) NOT NULL,
    PRIMARY KEY (ID_CursoAlvo, ID_CursoRequisito),
    FOREIGN KEY (ID_CursoAlvo) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_CursoRequisito) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Matricula_Bolsa (
    NomeAluno VARCHAR(100) NOT NULL,
    SobrenomeAluno VARCHAR(100) NOT NULL,
    TelefoneAluno VARCHAR(15) NOT NULL,
    Sigla_Disciplina VARCHAR(10) NOT NULL,
    Periodo_Oferecimento INTEGER NOT NULL,
    Ano_Oferecimento INTEGER NOT NULL,
    NomeProfessor VARCHAR(100) NOT NULL,
    SobrenomeProfessor VARCHAR(100) NOT NULL,
    TelefoneProfessor VARCHAR(15) NOT NULL,
    TipoBolsa VARCHAR(100) NOT NULL,
    PRIMARY KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, TipoBolsa),
    FOREIGN KEY (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) REFERENCES RealizarMatricula(NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Curso_Infraestrutura (
    ID_Curso VARCHAR(10) NOT NULL,
    Necessidade_Infraestrutura VARCHAR(255) NOT NULL,
    PRIMARY KEY (ID_Curso, Necessidade_Infraestrutura),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE RegrasGeral (
    ID_Curso VARCHAR(10) NOT NULL,
    Tipo VARCHAR(100) NOT NULL,
    Descricao TEXT NOT NULL,
    PRIMARY KEY (ID_Curso, Tipo),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela de Mensagens
CREATE TABLE Mensagem (
    ID_Mensagem SERIAL PRIMARY KEY,
    Timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Conteudo TEXT NOT NULL,
    NomeAutor VARCHAR(100) NOT NULL,
    SobrenomeAutor VARCHAR(100) NOT NULL,
    TelefoneAutor VARCHAR(15) NOT NULL,
    FOREIGN KEY (NomeAutor, SobrenomeAutor, TelefoneAutor)
        REFERENCES Usuario(NomeUsuario, SobrenomeUsuario, Telefone) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela RecebeMsg (Usuários que recebem mensagens)
CREATE TABLE RecebeMsg (
    ID_Mensagem INTEGER NOT NULL,
    NomeDestinatario VARCHAR(100) NOT NULL,
    SobrenomeDestinatario VARCHAR(100) NOT NULL,
    TelefoneDestinatario VARCHAR(15) NOT NULL,
    PRIMARY KEY (ID_Mensagem, NomeDestinatario, SobrenomeDestinatario, TelefoneDestinatario),
    FOREIGN KEY (ID_Mensagem) REFERENCES Mensagem(ID_Mensagem) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (NomeDestinatario, SobrenomeDestinatario, TelefoneDestinatario)
        REFERENCES Usuario(NomeUsuario, SobrenomeUsuario, Telefone) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabela de Critérios de Aprovação por Curso
CREATE TABLE CriterioAprovacao (
    ID_Curso VARCHAR(10) PRIMARY KEY,
    FrequenciaMinima NUMERIC(5,2) CHECK (FrequenciaMinima BETWEEN 0 AND 100),
    NotaMinima NUMERIC(4,2) CHECK (NotaMinima BETWEEN 0 AND 10),
    FOREIGN KEY (ID_Curso) REFERENCES Curso(ID_Curso) ON DELETE CASCADE ON UPDATE CASCADE
);