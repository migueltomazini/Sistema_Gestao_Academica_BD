-- Arquivo: 4.insercao_dados.sql
-- Descrição: Script para popular as tabelas do banco de dados com dados realistas.

-- Sem normalização ainda

-- Inserindo 2 Unidades da Escola
INSERT INTO Unidade_Escola (ID_Unidade, Cidade, Estado, Pais) VALUES
(1, 'São Carlos', 'SP', 'Brasil'),
(2, 'São Paulo', 'SP', 'Brasil');

INSERT INTO Bloco (ID_Unidade, NomeBloco) VALUES
(1, 'ICMC'),
(1, 'EESC'),
(1, 'IFSC'),
(1, 'IQSC'),
(1, 'IAU'),
(2, 'IME'),
(2, 'FAU'),
(2, 'EACH');

-- Inserindo Usuários (20 Alunos com nomes comuns)
INSERT INTO Usuario (NomeUsuario, SobrenomeUsuario, Telefone, Papel, DataNascimento, Endereco_Rua, Endereco_Nro, Endereco_Bairro, Sexo, Email, Senha, ID_Unidade, NomeBloco) VALUES
('João', 'Silva', '16991000001', 'Aluno', '2004-05-15', 'Rua Bento Carlos', '101', 'Centro', 'Masculino', 'joao.silva@email.com', 'senha123', 1, 'ICMC'),
('Maria', 'Oliveira', '16991000002', 'Aluno', '2003-08-20', 'Avenida São Carlos', '202', 'Centro', 'Feminino', 'maria.oliveira@email.com', 'senha123', 1, 'IAU'),
('Pedro', 'Santos', '16991000003', 'Aluno', '2004-02-10', 'Rua Episcopal', '303', 'Jardim Lutfalla', 'Masculino', 'pedro.santos@email.com', 'senha123', 1, 'EESC'),
('Ana', 'Souza', '16991000004', 'Aluno', '2003-11-25', 'Rua Conde do Pinhal', '404', 'Vila Monteiro', 'Feminino', 'ana.souza@email.com', 'senha123', 1, 'ICMC'),
('Lucas', 'Pereira', '16991000005', 'Aluno', '2004-07-30', 'Rua Geminiano Costa', '505', 'Jardim Paraíso', 'Masculino', 'lucas.pereira@email.com', 'senha123', 1, 'EESC'),
('Beatriz', 'Ferreira', '16991000006', 'Aluno', '2003-01-12', 'Rua Major José Inácio', '606', 'Centro', 'Feminino', 'beatriz.ferreira@email.com', 'senha123', 1, 'IFSC'),
('Gabriel', 'Alves', '16991000007', 'Aluno', '2004-09-05', 'Avenida Doutor Carlos Botelho', '707', 'Parque Arnold Schimidt', 'Masculino', 'gabriel.alves@email.com', 'senha123', 1, NULL),
('Laura', 'Costa', '16991000008', 'Aluno', '2003-03-18', 'Rua Sete de Setembro', '808', 'Vila Nery', 'Feminino', 'laura.costa@email.com', 'senha123', 1, NULL),
('Matheus', 'Gomes', '16991000009', 'Aluno', '2002-10-10', 'Rua Dona Alexandrina', '909', 'Centro', 'Masculino', 'matheus.gomes@email.com', 'senha123', 1, NULL),
('Julia', 'Ribeiro', '16991000010', 'Aluno', '2004-12-01', 'Rua Jesuíno de Arruda', '1010', 'Jardim Bethânia', 'Feminino', 'julia.ribeiro@email.com', 'senha123', 1, NULL),
('Guilherme', 'Martins', '11981000011', 'Aluno', '2003-06-22', 'Rua da Consolação', '1111', 'Consolação', 'Masculino', 'guilherme.martins@email.com', 'senha123', 2, 'IME'),
('Isabela', 'Carvalho', '11981000012', 'Aluno', '2001-04-14', 'Avenida Paulista', '1212', 'Bela Vista', 'Feminino', 'isabela.carvalho@email.com', 'senha123', 2, 'IME'),
('Rafael', 'Almeida', '11981000013', 'Aluno', '2004-08-11', 'Rua Augusta', '1313', 'Cerqueira César', 'Masculino', 'rafael.almeida@email.com', 'senha123', 2, 'IME'),
('Sofia', 'Lopes', '11981000014', 'Aluno', '2003-02-09', 'Rua Oscar Freire', '1414', 'Jardins', 'Feminino', 'sofia.lopes@email.com', 'senha123', 2, 'IME'),
('Felipe', 'Dias', '11981000015', 'Aluno', '2004-10-03', 'Avenida Brigadeiro Faria Lima', '1515', 'Itaim Bibi', 'Masculino', 'felipe.dias@email.com', 'senha123', 2, NULL),
('Luiza', 'Cruz', '11981000016', 'Aluno', '2003-05-19', 'Rua Teodoro Sampaio', '1616', 'Pinheiros', 'Feminino', 'luiza.cruz@email.com', 'senha123', 2, NULL),
('Enzo', 'Barbosa', '11981000017', 'Aluno', '2004-11-28', 'Rua Voluntários da Pátria', '1717', 'Santana', 'Masculino', 'enzo.barbosa@email.com', 'senha123', 2, NULL),
('Mariana', 'Rocha', '11981000018', 'Aluno', '2003-07-15', 'Avenida Ibirapuera', '1818', 'Moema', 'Feminino', 'mariana.rocha@email.com', 'senha123', 2, NULL),
('Bruno', 'Nunes', '11981000019', 'Aluno', '2000-09-08', 'Rua 25 de Março', '1919', 'Centro', 'Masculino', 'bruno.nunes@email.com', 'senha123', 2, NULL),
('Livia', 'Mendes', '11981000020', 'Aluno', '2004-01-23', 'Avenida Celso Garcia', '2020', 'Brás', 'Feminino', 'livia.mendes@email.com', 'senha123', 2, NULL);

-- Inserindo Usuários (20 Professores com nomes comuns)
INSERT INTO Usuario (NomeUsuario, SobrenomeUsuario, Telefone, Papel, DataNascimento, Endereco_Rua, Endereco_Nro, Endereco_Bairro, Sexo, Email, Senha, ID_Unidade) VALUES
('Carlos', 'Rodrigues', '16992000001', 'Professor', '1980-01-01', 'Avenida Trabalhador São-carlense', '10', 'Parque Arnold Schimidt', 'Masculino', 'carlos.rodrigues@email.com', 'prof_senha', 1),
('José', 'Teixeira', '16992000002', 'Professor', '1975-03-12', 'Rua Miguel Petroni', '20', 'Jardim Acapulco', 'Masculino', 'jose.teixeira@email.com', 'prof_senha', 1),
('Adriana', 'Correia', '16992000003', 'Professor', '1982-06-25', 'Rua Larga', '30', 'Vila Industrial', 'Feminino', 'adriana.correia@email.com', 'prof_senha', 1),
('Marcos', 'Azevedo', '16992000004', 'Professor', '1978-09-15', 'Rua Campos Salles', '40', 'Vila Brasília', 'Masculino', 'marcos.azevedo@email.com', 'prof_senha', 1),
('Fernanda', 'Fogaça', '16992000005', 'Professor', '1985-11-30', 'Rua Cândido de Arruda Botelho', '50', 'Jardim Santa Paula', 'Feminino', 'fernanda.fogaca@email.com', 'prof_senha', 1),
('Paulo', 'Sampaio', '16992000006', 'Professor', '1970-02-20', 'Avenida Getúlio Vargas', '60', 'Jardim Macarengo', 'Masculino', 'paulo.sampaio@email.com', 'prof_senha', 1),
('Sandra', 'Pacheco', '16992000007', 'Professor', '1983-07-10', 'Rua Padre Teixeira', '70', 'Centro', 'Feminino', 'sandra.pacheco@email.com', 'prof_senha', 1),
('Ricardo', 'Tavares', '16992000008', 'Professor', '1979-04-05', 'Rua 15 de Novembro', '80', 'Vila Nery', 'Masculino', 'ricardo.tavares@email.com', 'prof_senha', 1),
('Camila', 'Campos', '16992000009', 'Professor', '1988-12-18', 'Rua 9 de Julho', '90', 'Centro', 'Feminino', 'camila.campos@email.com', 'prof_senha', 1),
('Marcelo', 'Barros', '16992000010', 'Professor', '1976-08-22', 'Rua Ray Wesley Herrick', '100', 'Polo Tecnológico', 'Masculino', 'marcelo.barros@email.com', 'prof_senha', 1),
('Luciana', 'Moreira', '11982000011', 'Professor', '1981-05-14', 'Avenida 23 de Maio', '110', 'Paraíso', 'Feminino', 'luciana.moreira@email.com', 'prof_senha', 2),
('Roberto', 'Cardoso', '11982000012', 'Professor', '1977-10-09', 'Avenida do Estado', '120', 'Mooca', 'Masculino', 'roberto.cardoso@email.com', 'prof_senha', 2),
('Eduardo', 'Pinto', '11982000013', 'Professor', '1984-01-28', 'Rua Vergueiro', '130', 'Liberdade', 'Masculino', 'eduardo.pinto@email.com', 'prof_senha', 2),
('Patrícia', 'Wolff', '11982000014', 'Professor', '1986-03-03', 'Avenida Rebouças', '140', 'Jardim América', 'Feminino', 'patricia.wolff@email.com', 'prof_senha', 2),
('Fernando', 'Fernandes', '11982000015', 'Professor', '1973-09-01', 'Rua Frei Caneca', '150', 'Consolação', 'Masculino', 'fernando.fernandes@email.com', 'prof_senha', 2),
('Sérgio', 'Vargas', '11982000016', 'Professor', '1980-11-11', 'Avenida Morumbi', '160', 'Morumbi', 'Masculino', 'sergio.vargas@email.com', 'prof_senha', 2),
('Daniel', 'Monteiro', '11982000017', 'Professor', '1979-07-07', 'Rua Bela Cintra', '170', 'Jardins', 'Masculino', 'daniel.monteiro@email.com', 'prof_senha', 2),
('Cláudia', 'Castro', '11982000018', 'Professor', '1987-04-20', 'Avenida Brigadeiro Luís Antônio', '180', 'Bela Vista', 'Feminino', 'claudia.castro@email.com', 'prof_senha', 2),
('Jorge', 'Araujo', '11982000019', 'Professor', '1989-08-18', 'Rua Maria Antônia', '190', 'Vila Buarque', 'Masculino', 'jorge.araujo@email.com', 'prof_senha', 2),
('Alexandre', 'Freitas', '11982000020', 'Professor', '1974-06-30', 'Avenida Ipiranga', '200', 'República', 'Masculino', 'alexandre.freitas@email.com', 'prof_senha', 2);

-- Inserindo Usuários (5 Funcionários Administrativos)
INSERT INTO Usuario (NomeUsuario, SobrenomeUsuario, Telefone, Papel, DataNascimento, Endereco_Rua, Endereco_Nro, Endereco_Bairro, Sexo, Email, Senha, ID_Unidade) VALUES
('Roberto', 'Moraes', '1633731111', 'Funcionario', '1990-02-15', 'Rua da Administração', '1', 'Centro', 'Masculino', 'roberto.moraes@email.com', 'func_senha1', 1),
('Sandra', 'Ramalho', '1633732222', 'Funcionario', '1992-07-21', 'Avenida da Secretaria', '2', 'Vila Administrativa', 'Feminino', 'sandra.ramalho@email.com', 'func_senha2', 1),
('Leonardo', 'Neves', '1633733333', 'Funcionario', '1995-09-03', 'Rua do Protocolo', '3', 'Centro', 'Masculino', 'leonardo.neves@email.com', 'func_senha3', 1),
('Juliana', 'Andrade', '1126484444', 'Funcionario', '1993-11-12', 'Rua da Diretoria', '4', 'Zona Leste', 'Feminino', 'juliana.andrade@email.com', 'func_senha4', 2),
('Fernando', 'Bezerra', '1126485555', 'Funcionario', '1988-04-29', 'Avenida dos Arquivos', '5', 'Tatuapé', 'Masculino', 'fernando.bezerra@email.com', 'func_senha5', 2);

-- Populando as tabelas de especialização (Aluno, Professor, Funcionario)
INSERT INTO Aluno (NomeAluno, SobrenomeAluno, TelefoneAluno)
SELECT NomeUsuario, SobrenomeUsuario, Telefone FROM Usuario WHERE Papel = 'Aluno';

-- Uso de forma artificial para popular dados de titulação como doutorado ou mestrado
INSERT INTO Professor (NomeProfessor, SobrenomeProfessor, TelefoneProfessor, Titulacao)
SELECT NomeUsuario, SobrenomeUsuario, Telefone,
    CASE
        WHEN CAST(SUBSTRING(Telefone, 8, 4) AS INT) % 2 = 0 THEN 'Doutorado'
        ELSE 'Mestrado'
    END
FROM Usuario WHERE Papel = 'Professor';

INSERT INTO Funcionario (NomeFuncionario, SobrenomeFuncionario, TelefoneFuncionario)
SELECT NomeUsuario, SobrenomeUsuario, Telefone FROM Usuario WHERE Papel = 'Funcionario';


-- Inserindo áreas de especialização para os professores
INSERT INTO Professor_AreaEspecializacao (Professor_Nome, Professor_Sobrenome, Professor_Telefone, AreaEspecializacao) VALUES
('Carlos', 'Rodrigues', '16992000001', 'Bases de Dados'),
('Carlos', 'Rodrigues', '16992000001', 'Recuperação de Informação'),
('José', 'Teixeira', '16992000002', 'Engenharia de Software'),
('José', 'Teixeira', '16992000002', 'Teste de Software'),
('Adriana', 'Correia', '16992000003', 'Inteligência Artificial'),
('Marcos', 'Azevedo', '16992000004', 'Processamento de Imagens'),
('Eduardo', 'Pinto', '11982000013', 'Sistemas de Informação'),
('Fernando', 'Fernandes', '11982000015', 'Marketing Digital');

-- Inserindo Departamentos e seus chefes
INSERT INTO Departamento (Codigo, Nome, ProfessorChefe_Nome, ProfessorChefe_Sobrenome, ProfessorChefe_Telefone) VALUES
('SCC', 'Ciência da Computação', 'José', 'Teixeira', '16992000002'),
('SME', 'Matemática e Estatística', 'Ricardo', 'Tavares', '16992000008'),
('EACH-SI', 'Sistemas de Informação', 'Eduardo', 'Pinto', '11982000013'),
('EACH-MKT', 'Marketing', 'Fernando', 'Fernandes', '11982000015');

-- Inserindo Cursos
INSERT INTO Curso (ID_Curso, NomeCurso, CargaHoraria, NumeroVagas, Nivel_de_Ensino, Departamento_Codigo, ID_Unidade, NomeBloco) VALUES
('BCC', 'Bacharelado em Ciência da Computação', 3200, 50, 'Graduação', 'SCC', 1, 'ICMC'),
('SI', 'Bacharelado em Sistemas de Informação', 3000, 60, 'Graduação', 'EACH-SI', 2, 'EACH'),
('MKT', 'Bacharelado em Marketing', 2800, 70, 'Graduação', 'EACH-MKT', 2, 'EACH'),
('Estat', 'Bacharelado em Estatística', 3100, 40, 'Graduação', 'SME', 1,'ICMC');

-- Inserindo Disciplinas
INSERT INTO Disciplina (Sigla, Nome_Disciplina, Quantidade_AulasSemanais, Material_Didatico, ID_Unidade, NomeBloco) VALUES
('SCC0240', 'Bases de Dados', 4, 'Livro: Sistemas de Banco de Dados, Elmasri & Navathe', 1, 'ICMC'),
('SCC0241', 'Engenharia de Software I', 4, 'Livro: Engenharia de Software, Sommerville', 1, 'ICMC'), 
('SME0340', 'Cálculo I', 6, 'Livro: Cálculo, Stewart', 1, 'ICMC'),
('EACH0111', 'Algoritmos e Estruturas de Dados', 4, 'Livro: Introduction to Algorithms, CLRS', 2, 'EACH'),
('EACH0132', 'Marketing Digital', 4, 'Artigos e cases de mercado', 2, 'EACH'),
('EACH0121', 'Gestão de Políticas Públicas', 4, 'Textos e legislação específica', 2, 'EACH');

-- Associando Disciplinas aos Cursos
INSERT INTO DiscipCompoeCurso (ID_Curso, Sigla, Semestre) VALUES
('BCC', 'SCC0240', 3),
('BCC', 'SCC0241', 4),
('BCC', 'SME0340', 1),
('Estat', 'SME0340', 1),
('SI', 'EACH0111', 2),
('SI', 'SCC0240', 4),
('MKT', 'EACH0132', 3);

-- Inserindo Salas
INSERT INTO Sala (Codigo, CapacidadeMaxSala) VALUES
('B5-101', 60),
('B5-102', 50),
('PRD-201', 70),
('PRD-202', 80);

-- Inserindo Ofertas de Disciplinas (Turmas) para o período letivo de 2025/1
INSERT INTO Oferecimento (Sigla_Disciplina, Periodo, Ano, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, CapacidadeMaxTurma, Sala_Codigo) VALUES
('SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 60, 'B5-101'), 
('SCC0241', 1, 2025, 'José', 'Teixeira', '16992000002', 55, 'B5-102'), 
('SME0340', 1, 2025, 'Ricardo', 'Tavares', '16992000008', 90, 'PRD-201'), 
('EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', 70, 'PRD-202'), 
('EACH0132', 1, 2025, 'Fernando', 'Fernandes', '11982000015', 75, 'B5-101'); 

-- Inserindo Matrículas de Alunos em Disciplinas
INSERT INTO RealizarMatricula (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, DataMatricula, Status) VALUES
('João', 'Silva', '16991000001', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-15', 'Ativa'),
('Maria', 'Oliveira', '16991000002', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-15', 'Ativa'),
('Pedro', 'Santos', '16991000003', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-16', 'Ativa'),
('Ana', 'Souza', '16991000004', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-16', 'Ativa'),
('Lucas', 'Pereira', '16991000005', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-17', 'Concluída'),
('Beatriz', 'Ferreira', '16991000006', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', '2025-02-17', 'Reprovada'),
('João', 'Silva', '16991000001', 'SME0340', 1, 2025, 'Ricardo', 'Tavares', '16992000008', '2025-02-15', 'Ativa'),
('Maria', 'Oliveira', '16991000002', 'SME0340', 1, 2025, 'Ricardo', 'Tavares', '16992000008', '2025-02-15', 'Concluída'),
('Pedro', 'Santos', '16991000003', 'SCC0241', 1, 2025, 'José', 'Teixeira', '16992000002', '2025-02-16', 'Ativa'),
('Ana', 'Souza', '16991000004', 'SCC0241', 1, 2025, 'José', 'Teixeira', '16992000002', '2025-02-16', 'Trancada'),
('Guilherme', 'Martins', '11981000011', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', '2025-02-18', 'Ativa'),
('Isabela', 'Carvalho', '11981000012', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', '2025-02-18', 'Ativa'),
('Rafael', 'Almeida', '11981000013', 'EACH0132', 1, 2025, 'Fernando', 'Fernandes', '11982000015', '2025-02-19', 'Ativa'),
('Sofia', 'Lopes', '11981000014', 'EACH0132', 1, 2025, 'Fernando', 'Fernandes', '11982000015', '2025-02-19', 'Ativa'),
('Bruno', 'Nunes', '11981000019', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', '2025-02-19', 'Concluída');

-- Inserindo avaliações de alunos
INSERT INTO Avaliacao (
    NomeAluno, SobrenomeAluno, TelefoneAluno,
    Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento,
    NomeProfessor, SobrenomeProfessor, TelefoneProfessor,
    Comentario, Class_Didatica, Class_Material, Class_Relevancia, Class_Infra
) VALUES
-- Avaliação de João na disciplina SCC0240 com Carlos Rodrigues
('João', 'Silva', '16991000001', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001',
 'Aulas bem explicadas, conteúdo interessante.', 5, 4, 5, 4),

-- Avaliação de Maria na disciplina SME0340 com Ricardo Tavares
('Maria', 'Oliveira', '16991000002', 'SME0340', 1, 2025, 'Ricardo', 'Tavares', '16992000008',
 'Bom uso de materiais complementares, mas faltou organização.', 4, 5, 3, 4),

-- Avaliação de Lucas na disciplina SCC0240 com Carlos Rodrigues
('Lucas', 'Pereira', '16991000005', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001',
 'Professor muito didático, recomendo.', 5, 5, 5, 5),

-- Avaliação de Guilherme na disciplina EACH0111 com Eduardo Pinto
('Guilherme', 'Martins', '11981000011', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013',
 'Infraestrutura da sala poderia melhorar.', 4, 4, 4, 2),

-- Avaliação de Bruno na disciplina EACH0111 com Eduardo Pinto
('Bruno', 'Nunes', '11981000019', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013',
 'Gostei da abordagem prática.', 5, 5, 4, 4);


-- Inserindo Notas (Exemplo de atributo multivalorado em tabela separada)
INSERT INTO Matricula_Nota (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, Descricao_Avaliacao, Nota) VALUES
('Lucas', 'Pereira', '16991000005', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 'Nota Final', 8.5),
('Beatriz', 'Ferreira', '16991000006', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 'Nota Final', 4.0),
('Maria', 'Oliveira', '16991000002', 'SME0340', 1, 2025, 'Ricardo', 'Tavares', '16992000008', 'Nota Final', 9.0),
('Bruno', 'Nunes', '11981000019', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', 'Nota Final', 9.5);

-- Atualizando Cursos com SalaPadrao
UPDATE Curso SET SalaPadrao = 'B5-101' WHERE ID_Curso = 'BCC';
UPDATE Curso SET SalaPadrao = 'PRD-201' WHERE ID_Curso = 'SI';
UPDATE Curso SET SalaPadrao = 'PRD-202' WHERE ID_Curso = 'MKT';
UPDATE Curso SET SalaPadrao = 'B5-102' WHERE ID_Curso = 'Estat';

-- Inserindo Curso_Infraestrutura
INSERT INTO Curso_Infraestrutura (ID_Curso, Necessidade_Infraestrutura) VALUES
('BCC', 'Laboratório de Informática'),
('BCC', 'Acesso à internet banda larga'),
('SI', 'Laboratório de Redes'),
('MKT', 'Sala multimídia para apresentações'),
('Estat', 'Laboratório de Estatística');

-- Inserindo RegrasGeral
INSERT INTO RegrasGeral (ID_Curso, Tipo, Descricao) VALUES
('BCC', 'Frequência', 'Frequência mínima de 75% nas aulas presenciais.'),
('BCC', 'Avaliação', 'Média mínima 6.0 para aprovação nas disciplinas.'),
('SI', 'Frequência', 'Frequência mínima de 75% nas aulas.'),
('SI', 'Avaliação', 'Nota mínima 6.0 para aprovação.'),
('MKT', 'Frequência', 'Frequência mínima de 80%.'),
('MKT', 'Avaliação', 'Média mínima 7.0 para aprovação.'),
('Estat', 'Frequência', 'Frequência mínima de 75%.'),
('Estat', 'Avaliação', 'Nota mínima 6.5 para aprovação.');

-- Inserindo Mensagens
INSERT INTO Mensagem (ID_Mensagem, Timestamp, Conteudo, NomeAutor, SobrenomeAutor, TelefoneAutor) VALUES
(1, '2025-02-14 10:23:00', 'Professor, gostaria de esclarecer uma dúvida sobre a matéria.', 'João', 'Silva', '16991000001'),
(2, '2025-02-14 14:05:00', 'Solicito revisão da nota da última avaliação.', 'Maria', 'Oliveira', '16991000002'),
(3, '2025-02-14 16:40:00', 'Reunião marcada para amanhã às 10h.', 'Eduardo', 'Pinto', '11982000013'),
(4, '2025-02-14 17:15:00', 'Precisamos discutir o projeto de marketing digital.', 'Fernando', 'Fernandes', '11982000015');

-- Inserindo RecebeMsg (destinatários das mensagens)
INSERT INTO RecebeMsg (ID_Mensagem, NomeDestinatario, SobrenomeDestinatario, TelefoneDestinatario) VALUES
(1, 'Carlos', 'Rodrigues', '16992000001'),
(2, 'José', 'Teixeira', '16992000002'),
(3, 'Fernanda', 'Fogaça', '16992000005'),
(4, 'Patrícia', 'Wolff', '11982000014'),
(4, 'Carlos', 'Rodrigues', '16992000001');

-- Inserindo CriterioAprovacao
INSERT INTO CriterioAprovacao (ID_Curso, FrequenciaMinima, NotaMinima) VALUES
('BCC', 75.00, 6.00),
('SI', 75.00, 6.00),
('MKT', 80.00, 7.00),
('Estat', 75.00, 6.50);

-- Inserindo dados na tabela CursoRequisitoDisciplina
INSERT INTO CursoRequisitoDisciplina (ID_CursoAlvo, SiglaRequisito) VALUES
('BCC', 'SCC0240'), -- BCC requer Bases de Dados
('SI', 'SME0340'),  -- SI requer Cálculo I
('MKT', 'EACH0111'); -- Marketing requer Algoritmos e Estruturas de Dados

-- Inserindo dados na tabela CursoRequisitoCurso
INSERT INTO CursoRequisitoCurso (ID_CursoAlvo, ID_CursoRequisito) VALUES
('SI', 'BCC'),   -- Sistemas de Informação tem Bacharelado em Ciência da Computação como pré-requisito
('Estat', 'SI'); -- Estatística tem Sistemas de Informação como pré-requisito

-- Inserindo dados na tabela Matricula_Bolsa
INSERT INTO Matricula_Bolsa (NomeAluno, SobrenomeAluno, TelefoneAluno, Sigla_Disciplina, Periodo_Oferecimento, Ano_Oferecimento, NomeProfessor, SobrenomeProfessor, TelefoneProfessor, TipoBolsa) VALUES
('João', 'Silva', '16991000001', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 'Bolsa Mérito Acadêmico'),
('Maria', 'Oliveira', '16991000002', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 'Bolsa Assistência Estudantil'),
('Guilherme', 'Martins', '11981000011', 'EACH0111', 1, 2025, 'Eduardo', 'Pinto', '11982000013', 'Bolsa IC'),
('Rafael', 'Almeida', '11981000013', 'EACH0132', 1, 2025, 'Fernando', 'Fernandes', '11982000015', 'Bolsa FAPESP'),
('Lucas', 'Pereira', '16991000005', 'SCC0240', 1, 2025, 'Carlos', 'Rodrigues', '16992000001', 'Bolsa Mérito Acadêmico');