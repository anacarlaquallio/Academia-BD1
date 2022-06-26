-- Encontre o nome da secretária que realizou o fluxo caixa da mensalidade de código 0622.
SELECT F.nome FROM FUNCIONARIO F, FUNCIONARIO_SECRETARIA S, FLUXO_CAIXA FC
WHERE F.cpf = S.cpfSecretaria AND FC.cpfSecretaria = S.cpfSecretaria 
AND FC.id IN (SELECT M.idFluxoCaixa FROM MENSALIDADE M WHERE M.cod = 0622);

-- Encontre as datas de início, termino e o nome do personal do plano de treino feito com base na avaliação física de código 8.
SELECT PT.dataIni, PT.dataFim, F.nome FROM PLANO_TREINO PT, AVALIACAO_FISICA AF, FUNCIONARIO F
WHERE  PT.cpfCliente = AF.cpfCliente AND AF.cod = 8 AND PT.cpfPersonal = F.cpf;

-- Compute o salário médio do cargo de secretária da academia por capacitação.
SELECT AVG(FS.salario) AS Salario_Medio, FS.capacitacao AS Capacitacao FROM FUNCIONARIO_SECRETARIA FS, FUNCIONARIO F 
WHERE F.cpf = FS.cpfSecretaria GROUP BY FS.capacitacao;

-- Selecione o horário de funcionamento do equipamento que é utilizado no exercício "Supino reto".
SELECT EE.horario FROM EXERCICIOS_EQUIPAMENTOS EE WHERE EE.codExercicio IN
(SELECT E.cod FROM EXERCICIOS E WHERE E.nome LIKE "Supino reto");

-- Selecione a data de contratacao e quantas avaliacoes físicas o personal de cpf = "11365492770" fez.
SELECT F.dataContratacao, COUNT (A.cod) AS Qtde_Avaliacoes FROM FUNCIONARIO F, AVALIACAO_FISICA A
WHERE F.cpf = "11365492770" AND F.cpf = A.cpfPersonal;

-- Selecione a data de entrada no caixa da mensalidade paga pelo cliente chamado "Diego Franzon Quallio".
SELECT FC.dataEntrada FROM FLUXO_CAIXA FC, MENSALIDADE M, PLANO_TREINO PT, CLIENTE C
WHERE C.nome = "Diego Franzon Quallio" AND C.cpf = PT.cpfCliente AND PT.codMensalidade = M.cod AND M.idFluxoCaixa = FC.id;

-- Selecione os endereços que não possuem compelemento dos clientes da academia. 
SELECT E.cep, E.rua, E.logradouro FROM ENDERECO E, CLIENTE C WHERE C.cpf = E.cpfCliente AND (E.complemento IS NULL OR E.complemento LIKE "");

-- Encontre os nomes dos profissionais para os quais a quantidade de treinos que eles gerenciam é menor do que 3.
SELECT DISTINCT F.nome FROM FUNCIONARIO F, FUNCIONARIO_PERSONAL FP WHERE F.cpf = FP.cpfPersonal AND 3 > 
(SELECT COUNT (PT.cod) FROM PLANO_TREINO PT WHERE PT.cpfPersonal = F.cpf);
