-- Arquivo: 5.insercao_dados_artificiais.sql
-- Descrição: Script para popular as tabelas Oferecimento e RealizarMatricula com grande volume de dados.
-- Este script assume que o script '4.criacao_tabelas.sql' e '4.insercao_dados.sql' já foram executados.

-- *************************************************************************
-- 1. Geração de Dados Base Adicionais
--    Vamos adicionar mais professores e alunos para termos mais combinações
--    e mais disciplinas para o oferecimento.
-- *************************************************************************

-- Adiciona mais 30 usuários do tipo 'Aluno' (total de 50)
INSERT INTO Usuario (NomeUsuario, SobrenomeUsuario, Telefone, Papel, DataNascimento, Endereco_Rua, Endereco_Nro, Endereco_Bairro, Sexo, Email, Senha, ID_Unidade, NomeBloco)
SELECT
    'Aluno_' || LPAD(s.id::text, 2, '0'),
    'Sobrenome_' || LPAD(s.id::text, 2, '0'),
    '169910000' || LPAD(s.id::text, 3, '0'),
    'Aluno',
    (CURRENT_DATE - (INTERVAL '18 years' + (s.id || ' days')::interval)),
    'Rua Ficticia ' || s.id,
    (s.id * 10)::text,
    'Bairro Ficticio',
    CASE WHEN s.id % 2 = 0 THEN 'Feminino' ELSE 'Masculino' END,
    'aluno_' || LPAD(s.id::text, 2, '0') || '@email.com',
    'senha_aluno_' || s.id,
    1 + (s.id % 2), -- Alterna entre Unidade 1 e 2
    (SELECT NomeBloco FROM Bloco WHERE ID_Unidade = (1 + (s.id % 2)) ORDER BY RANDOM() LIMIT 1)
FROM GENERATE_SERIES(21, 50) AS s(id)
ON CONFLICT (NomeUsuario, SobrenomeUsuario, Telefone) DO NOTHING; -- Evita erro se já existir

-- Insere os novos alunos na tabela de especialização
INSERT INTO Aluno (NomeAluno, SobrenomeAluno, TelefoneAluno)
SELECT NomeUsuario, SobrenomeUsuario, Telefone FROM Usuario WHERE Papel = 'Aluno' AND NomeUsuario LIKE 'Aluno_%'
ON CONFLICT (NomeAluno, SobrenomeAluno, TelefoneAluno) DO NOTHING;

-- Adiciona mais 30 usuários do tipo 'Professor' (total de 50)
INSERT INTO Usuario (NomeUsuario, SobrenomeUsuario, Telefone, Papel, DataNascimento, Endereco_Rua, Endereco_Nro, Endereco_Bairro, Sexo, Email, Senha, ID_Unidade)
SELECT
    'Professor_' || LPAD(s.id::text, 2, '0'),
    'SobrenomeProf_' || LPAD(s.id::text, 2, '0'),
    '169920000' || LPAD(s.id::text, 3, '0'),
    'Professor',
    (CURRENT_DATE - (INTERVAL '30 years' + (s.id || ' days')::interval)),
    'Avenida Professor ' || s.id,
    (s.id * 5)::text,
    'Jardim Docente',
    CASE WHEN s.id % 2 = 0 THEN 'Feminino' ELSE 'Masculino' END,
    'professor_' || LPAD(s.id::text, 2, '0') || '@email.com',
    'senha_prof_' || s.id,
    1 + (s.id % 2) -- Alterna entre Unidade 1 e 2
FROM GENERATE_SERIES(21, 50) AS s(id)
ON CONFLICT (NomeUsuario, SobrenomeUsuario, Telefone) DO NOTHING;

-- Insere os novos professores na tabela de especialização
INSERT INTO Professor (NomeProfessor, SobrenomeProfessor, TelefoneProfessor, Titulacao)
SELECT NomeUsuario, SobrenomeUsuario, Telefone,
    CASE WHEN s.id % 2 = 0 THEN 'Doutorado' ELSE 'Mestrado' END
FROM Usuario u
JOIN GENERATE_SERIES(21, 50) AS s(id) ON u.NomeUsuario = 'Professor_' || LPAD(s.id::text, 2, '0')
WHERE u.Papel = 'Professor'
ON CONFLICT (NomeProfessor, SobrenomeProfessor, TelefoneProfessor) DO NOTHING;


-- Adiciona mais 194 disciplinas (total de 200)
INSERT INTO Disciplina (Sigla, Nome_Disciplina, Quantidade_AulasSemanais, Material_Didatico, ID_Unidade, NomeBloco)
SELECT
    'DISC' || LPAD(s.id::text, 3, '0'),
    'Disciplina Artificial ' || LPAD(s.id::text, 3, '0'),
    4,
    'Material Didatico da Disciplina ' || LPAD(s.id::text, 3, '0'),
    1 + (s.id % 2), -- Alterna entre Unidade 1 e 2
    (SELECT NomeBloco FROM Bloco WHERE ID_Unidade = (1 + (s.id % 2)) ORDER BY RANDOM() LIMIT 1)
FROM GENERATE_SERIES(7, 200) AS s(id)
ON CONFLICT (Sigla) DO NOTHING;

-- *************************************************************************
-- 2. Inserção de 100.000 tuplas na tabela Oferecimento
--    Combinando Disciplinas, Professores, Períodos e Anos.
-- *************************************************************************

-- Adiciona 100.000 ofertas de disciplinas
INSERT INTO Oferecimento (Sigla_Disciplina, Periodo, Ano, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, CapacidadeMaxTurma, Sala_Codigo)
SELECT
    d.Sigla,
    p.periodo_val,
    a.ano_val,
    prof.NomeProfessor,
    prof.SobrenomeProfessor,
    prof.TelefoneProfessor,
    FLOOR(RANDOM() * 50) + 30 AS CapacidadeMaxTurma, -- Capacidade entre 30 e 80
    (SELECT Codigo FROM Sala ORDER BY RANDOM() LIMIT 1) -- Sala aleatória
FROM
    (SELECT Sigla FROM Disciplina ORDER BY Sigla) AS d,
    (SELECT NomeProfessor, SobrenomeProfessor, TelefoneProfessor FROM Professor ORDER BY NomeProfessor) AS prof,
    (SELECT generate_series(1, 2) AS periodo_val) AS p,
    (SELECT generate_series(2020, 2024) AS ano_val) AS a
ORDER BY RANDOM()
LIMIT 100000; -- Limita a 100.000 tuplas

-- *************************************************************************
-- 3. Inserção de 100.000 tuplas na tabela RealizarMatricula
--    Combinando Alunos com Ofertas de Disciplinas existentes.
-- *************************************************************************

-- Adiciona 100.000 matrículas
INSERT INTO RealizarMatricula (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, DataMatricula, Status)
SELECT
    aluno.NomeAluno,
    aluno.SobrenomeAluno,
    aluno.TelefoneAluno,
    o.Sigla_Disciplina,
    o.Periodo,
    o.Ano,
    o.NomeProfessor,
    o.SobrenomeProfessor,
    o.TelefoneProfessor,
    (CURRENT_DATE - (FLOOR(RANDOM() * 365 * 5) || ' days')::interval)::date AS DataMatricula, -- Data aleatória nos últimos 5 anos
    CASE FLOOR(RANDOM() * 4)
        WHEN 0 THEN 'Ativa'
        WHEN 1 THEN 'Concluída'
        WHEN 2 THEN 'Trancada'
        WHEN 3 THEN 'Reprovada'
    END AS Status
FROM
    (SELECT NomeAluno, SobrenomeAluno, TelefoneAluno FROM Aluno ORDER BY NomeAluno) AS aluno,
    (SELECT Sigla_Disciplina, Periodo, Ano, NomeProfessor, SobrenomeProfessor, TelefoneProfessor FROM Oferecimento ORDER BY RANDOM() LIMIT 100000) AS o -- Seleciona 100.000 ofertas aleatoriamente
ORDER BY RANDOM()
LIMIT 100000 -- Garante 100.000 matrículas, combinando alunos com ofertas
ON CONFLICT (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor) DO NOTHING;


-- Reabilita triggers
ALTER TABLE Usuario ENABLE TRIGGER ALL;
ALTER TABLE Aluno ENABLE TRIGGER ALL;
ALTER TABLE Professor ENABLE TRIGGER ALL;
ALTER TABLE Oferecimento ENABLE TRIGGER ALL;
ALTER TABLE RealizarMatricula ENABLE TRIGGER ALL;

-- Exibe contagens para verificar as inserções
SELECT 'Total de Usuários: ' || COUNT(*) FROM Usuario;
SELECT 'Total de Alunos: ' || COUNT(*) FROM Aluno;
SELECT 'Total de Professores: ' || COUNT(*) FROM Professor;
SELECT 'Total de Disciplinas: ' || COUNT(*) FROM Disciplina;
SELECT 'Total de Oferecimentos: ' || COUNT(*) FROM Oferecimento;
SELECT 'Total de Matrículas: ' || COUNT(*) FROM RealizarMatricula;
