/*
--- CONSULTA 1: Listar Alunos Matriculados em uma Disciplina Específica ---
  Objetivo: Obter uma lista com o nome completo de todos os alunos matriculados na
            disciplina 'Bases de Dados' (SCC0240) no primeiro semestre de 2025.
  Tabelas Envolvidas: Usuario, RealizarMatricula.
*/
SELECT
    u.NomeUsuario,
    u.SobrenomeUsuario,
    u.Email
FROM
    Usuario u
JOIN
    RealizarMatricula rm ON u.NomeUsuario = rm.NomeAluno
                       AND u.SobrenomeUsuario = rm.SobrenomeAluno
                       AND u.Telefone = rm.TelefoneAluno
WHERE
    rm.Sigla_Disciplina = 'SCC0240'
    AND rm.Ano_Oferecimento = 2025
    AND rm.Periodo_Oferecimento = 1
ORDER BY
    u.NomeUsuario;

/*
--- CONSULTA 2: Calcular a Média Final de um Aluno Específico ---
  Objetivo: Calcular e exibir a média geral das notas finais de um aluno específico
            (neste caso, 'Lucas Pereira'). A consulta considera apenas as notas descritas
            como 'Nota Final'.
  Tabelas Envolvidas: Matricula_Nota.
*/
SELECT
    mn.NomeAluno,
    mn.SobrenomeAluno,
    AVG(mn.Nota) AS Media_Final_Geral
FROM
    Matricula_Nota mn
WHERE
    mn.NomeAluno = 'Lucas'
    AND mn.SobrenomeAluno = 'Pereira'
    AND mn.Descricao_Avaliacao = 'Nota Final'
GROUP BY
    mn.NomeAluno, mn.SobrenomeAluno;

/*
--- CONSULTA 3: Listar Professores de um Departamento e Suas Disciplinas ---
  Objetivo: Exibir o nome de todos os professores do departamento de 'Ciência da Computação'
            (SCC) e as disciplinas que cada um está ministrando no período atual (2025/1).
  Tabelas Envolvidas: Professor, Oferecimento, Disciplina, DiscipCompoeCurso, Curso.
*/
SELECT DISTINCT
    prof.NomeProfessor,
    prof.SobrenomeProfessor,
    d.Nome_Disciplina
FROM
    Professor prof
JOIN
    Oferecimento o ON prof.NomeProfessor = o.NomeProfessor
                  AND prof.SobrenomeProfessor = o.SobrenomeProfessor
                  AND prof.TelefoneProfessor = o.TelefoneProfessor
JOIN
    Disciplina d ON o.Sigla_Disciplina = d.Sigla
JOIN
    DiscipCompoeCurso dcc ON d.Sigla = dcc.Sigla
JOIN
    Curso c ON dcc.ID_Curso = c.ID_Curso
WHERE
    c.Departamento_Codigo = 'SCC'
    AND o.Ano = 2025
    AND o.Periodo = 1
ORDER BY
    prof.NomeProfessor, d.Nome_Disciplina;

/*
--- CONSULTA 4: Encontrar Cursos Sem Alunos Matriculados no Período Atual ---
  Objetivo: Identificar e listar os cursos que não tiveram nenhum aluno matriculado em
            disciplinas oferecidas no primeiro semestre de 2025. Útil para análise de demanda.
  Tabelas Envolvidas: Curso, RealizarMatricula, DiscipCompoeCurso.
*/
SELECT
    c.ID_Curso,
    c.NomeCurso
FROM
    Curso c
WHERE
    c.ID_Curso NOT IN (
        SELECT DISTINCT
            dcc.ID_Curso
        FROM
            RealizarMatricula rm
        JOIN
            DiscipCompoeCurso dcc ON rm.Sigla_Disciplina = dcc.Sigla
        WHERE
            rm.Ano_Oferecimento = 2025
            AND rm.Periodo_Oferecimento = 1
    );

/*
--- CONSULTA 5: Média de Avaliação por Professor ---
  Objetivo: Calcular a média das notas de avaliação (didática, material, relevância) para
            cada professor, com base nas avaliações feitas pelos alunos.
  Tabelas Envolvidas: Avaliacao.
*/
SELECT
    av.NomeProfessor,
    av.SobrenomeProfessor,
    AVG(av.Class_Didatica) AS Media_Didatica,
    AVG(av.Class_Material) AS Media_Material,
    AVG(av.Class_Relevancia) AS Media_Relevancia
FROM
    Avaliacao av
GROUP BY
    av.NomeProfessor, av.SobrenomeProfessor
ORDER BY
    Media_Didatica DESC;

/*
--- CONSULTA 6: Ocupação e Capacidade das Salas de Aula ---
  Objetivo: Gerar um relatório que mostra, para cada oferecimento de disciplina, a sala utilizada,
            sua capacidade máxima e o número de alunos matriculados, calculando a taxa de ocupação.
  Tabelas Envolvidas: Oferecimento, Sala, RealizarMatricula.
*/
SELECT
    o.Sigla_Disciplina,
    o.Sala_Codigo,
    s.CapacidadeMaxSala,
    COUNT(rm.NomeAluno) AS Alunos_Matriculados,
    (COUNT(rm.NomeAluno) * 100.0 / s.CapacidadeMaxSala) AS Taxa_Ocupacao_Percentual
FROM
    Oferecimento o
JOIN
    Sala s ON o.Sala_Codigo = s.Codigo
LEFT JOIN -- Usamos LEFT JOIN para garantir que turmas sem alunos apareçam na lista.
    RealizarMatricula rm ON o.Sigla_Disciplina = rm.Sigla_Disciplina
                        AND o.Ano = rm.Ano_Oferecimento
                        AND o.Periodo = rm.Periodo_Oferecimento
                        AND o.NomeProfessor = rm.NomeProfessor
                        AND o.SobrenomeProfessor = rm.SobrenomeProfessor
                        AND o.TelefoneProfessor = rm.TelefoneProfessor
GROUP BY
    o.Sigla_Disciplina, o.Sala_Codigo, s.CapacidadeMaxSala
ORDER BY
    Taxa_Ocupacao_Percentual DESC;

/*
--- CONSULTA 7: Listar Alunos e o Chefe do Departamento de Seu Curso ---
  Objetivo: Para cada aluno, listar seu nome, o curso em que está matriculado e o nome do
            professor que chefia o departamento daquele curso.
  Tabelas Envolvidas: Usuario, RealizarMatricula, DiscipCompoeCurso, Curso, Departamento.
*/
WITH AlunoCurso AS (
    -- Etapa 1: Descobrir o curso principal de cada aluno (baseado na primeira matrícula encontrada).
    SELECT DISTINCT ON (rm.NomeAluno, rm.SobrenomeAluno, rm.TelefoneAluno)
        rm.NomeAluno,
        rm.SobrenomeAluno,
        rm.TelefoneAluno,
        dcc.ID_Curso
    FROM
        RealizarMatricula rm
    JOIN
        DiscipCompoeCurso dcc ON rm.Sigla_Disciplina = dcc.Sigla
)
-- Etapa 2: Juntar as informações para obter o resultado final.
SELECT
    ac.NomeAluno,
    ac.SobrenomeAluno,
    c.NomeCurso,
    dep.Nome AS Nome_Departamento,
    dep.ProfessorChefe_Nome || ' ' || dep.ProfessorChefe_Sobrenome AS Nome_Chefe_Departamento
FROM
    AlunoCurso ac
JOIN
    Curso c ON ac.ID_Curso = c.ID_Curso
JOIN
    Departamento dep ON c.Departamento_Codigo = dep.Codigo
ORDER BY
    c.NomeCurso, ac.NomeAluno;
