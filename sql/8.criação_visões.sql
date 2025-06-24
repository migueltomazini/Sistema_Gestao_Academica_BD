-- Excluindo as views se elas já existirem, para permitir a recriação sem erros
DROP VIEW IF EXISTS v_ofertas_atuais;
DROP VIEW IF EXISTS v_notas_finais;
DROP VIEW IF EXISTS v_mensagens_com_recipientes;
DROP VIEW IF EXISTS v_curso_disciplinas;


-- 1. Grade de ofertas vigentes (ano e período atual)
CREATE VIEW v_ofertas_atuais AS
SELECT
  o.Sigla_Disciplina,
  o.Periodo,
  o.Ano,
  CONCAT(o.NomeProfessor, ' ', o.SobrenomeProfessor) AS Docente,
  o.CapacidadeMaxTurma,
  o.Sala_Codigo
FROM Oferecimento o
WHERE
  o.Ano = EXTRACT(YEAR FROM CURRENT_DATE)
  AND o.Periodo = CASE
                    WHEN EXTRACT(MONTH FROM CURRENT_DATE) BETWEEN 1 AND 6 THEN 1
                    ELSE 2
                  END;

-- Seleciona o conteúdo da visão v_ofertas_atuais para exibir no output
SELECT * FROM v_ofertas_atuais;

-- 2. Histórico de notas finais dos alunos (simplifica consulta de multivalorados)
CREATE VIEW v_notas_finais AS
SELECT rm.NomeAluno,
       rm.SobrenomeAluno,
       n.Nota                     AS NotaFinal,
       rm.Sigla_Disciplina,
       rm.Periodo_Oferecimento    AS Periodo,
       rm.Ano_Oferecimento        AS Ano
  FROM Matricula_Nota n
  JOIN RealizarMatricula rm
    ON   n.NomeAluno        = rm.NomeAluno
     AND n.SobrenomeAluno   = rm.SobrenomeAluno
     AND n.TelefoneAluno    = rm.TelefoneAluno
     AND n.Sigla_Disciplina = rm.Sigla_Disciplina
     AND n.Periodo_Oferecimento = rm.Periodo_Oferecimento
     AND n.Ano_Oferecimento     = rm.Ano_Oferecimento
     AND n.NomeProfessor        = rm.NomeProfessor
     AND n.SobrenomeProfessor   = rm.SobrenomeProfessor
     AND n.TelefoneProfessor    = rm.TelefoneProfessor
 WHERE n.Descricao_Avaliacao = 'Nota Final';

-- Seleciona o conteúdo da visão v_notas_finais para exibir no output
SELECT * FROM v_notas_finais;

 -- 3. Mensagens enviadas com lista de destinatários
CREATE VIEW v_mensagens_com_recipientes AS
SELECT m.ID_Mensagem,
       m.Timestamp,
       m.Conteudo,
       m.NomeAutor || ' ' || m.SobrenomeAutor AS Remetente,
       ARRAY_AGG(rm.NomeDestinatario || ' ' || rm.SobrenomeDestinatario) AS Destinatarios
  FROM Mensagem m
  JOIN RecebeMsg rm
    ON m.ID_Mensagem = rm.ID_Mensagem
 GROUP BY m.ID_Mensagem, m.Timestamp, m.Conteudo, m.NomeAutor, m.SobrenomeAutor;

-- Seleciona o conteúdo da visão v_mensagens_com_recipientes para exibir no output
SELECT * FROM v_mensagens_com_recipientes;

--4. Resumo de cursos e suas disciplinas
CREATE VIEW v_curso_disciplinas AS
SELECT
  c.ID_Curso,
  c.NomeCurso,
  d.Sigla        AS SiglaDisciplina,
  d.Nome_Disciplina
FROM Curso c
JOIN DiscipCompoeCurso dc
  ON c.ID_Curso = dc.ID_Curso
JOIN Disciplina d
  ON d.Sigla    = dc.Sigla;

-- Seleciona o conteúdo da visão v_curso_disciplinas para exibir no output
SELECT * FROM v_curso_disciplinas;