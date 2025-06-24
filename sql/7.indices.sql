-- Arquivo: 7.indices.sql
-- Descrição: Script para demonstrar o impacto dos índices no desempenho das consultas.
-- Este script assume que o script '4.criacao_tabelas.sql' e '7.carga_adicional.sql' já foram executados.

-- *************************************************************************
-- PARTE 1: Criação dos Índices Novos para Teste
-- *************************************************************************

-- Índice para Oferecimento na capacidade máxima da turma
CREATE INDEX idx_oferecimento_capacidade_turma ON Oferecimento (CapacidadeMaxTurma);

-- Índice para RealizarMatricula no status
CREATE INDEX idx_realizarmatricula_status ON RealizarMatricula (Status);

-- Índice para Oferecimento no código da sala
CREATE INDEX idx_oferecimento_sala_codigo ON Oferecimento (Sala_Codigo);

-- Índice para RealizarMatricula na data da matrícula
CREATE INDEX idx_realizarmatricula_datamatricula ON RealizarMatricula (DataMatricula);


-- *************************************************************************
-- PARTE 2: Consultas com Índices Ativos (EXPLAIN ANALYZE)
-- *************************************************************************

-- Consulta 1: Utilizando idx_oferecimento_capacidade_turma
EXPLAIN ANALYZE
SELECT *
FROM Oferecimento
WHERE CapacidadeMaxTurma = 50;

-- Consulta 2: Utilizando idx_realizarmatricula_status
EXPLAIN ANALYZE
SELECT *
FROM RealizarMatricula
WHERE Status = 'Concluída';

-- Consulta 3: Utilizando idx_oferecimento_sala_codigo
EXPLAIN ANALYZE
SELECT *
FROM Oferecimento
WHERE Sala_Codigo = 'B5-101';

-- Consulta 4: Utilizando idx_realizarmatricula_datamatricula
EXPLAIN ANALYZE
SELECT *
FROM RealizarMatricula
WHERE DataMatricula = '2023-01-15'; -- Ajuste a data conforme os dados existentes


-- *************************************************************************
-- PARTE 3: Exclusão dos Índices
-- *************************************************************************

DROP INDEX idx_oferecimento_capacidade_turma;
DROP INDEX idx_realizarmatricula_status;
DROP INDEX idx_oferecimento_sala_codigo; 
DROP INDEX idx_realizarmatricula_datamatricula; 

-- *************************************************************************
-- PARTE 4: Consultas sem Índices (EXPLAIN ANALYZE)
-- As mesmas consultas serão executadas novamente para comparação.
-- *************************************************************************

-- Consulta 1: Buscando oferecimentos com capacidade máxima de 50 (sem índice)...
EXPLAIN ANALYZE
SELECT *
FROM Oferecimento
WHERE CapacidadeMaxTurma = 50;

-- Consulta 2: Buscando matrículas com status "Concluída" (sem índice)...
EXPLAIN ANALYZE
SELECT *
FROM RealizarMatricula
WHERE Status = 'Concluída';

-- Consulta 3: Buscando oferecimentos na sala B5-101 (sem índice)...
EXPLAIN ANALYZE
SELECT *
FROM Oferecimento
WHERE Sala_Codigo = 'B5-101';

-- Consulta 4: Buscando matrículas na data '2023-01-15' (sem índice)...
EXPLAIN ANALYZE
SELECT *
FROM RealizarMatricula
WHERE DataMatricula = '2023-01-15'; 
