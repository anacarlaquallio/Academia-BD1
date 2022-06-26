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

-- Selecione o nome dos clientes que não pagaram a mensalidade no dia 01/05/2022.
SELECT C.nome FROM  CLIENTE C, PLANO_TREINO PT WHERE PT.cpfCliente = C.cpf AND NOT EXISTS 
(SELECT * FROM FLUXO_CAIXA FC, MENSALIDADE M
WHERE M.idFluxoCaixa = FC.id AND PT.codMensalidade = M.cod AND FC.dataEntrada LIKE "01/05/2022");

-- Selecione os nomes dos personais fizeram o plano de treino para apenas um cliente. Mostre também o nome desse cliente correspondente 
SELECT F.nome AS Nome_Personal, C.nome as Nome_Cliente 
FROM CLIENTE C, PLANO_TREINO PT, FUNCIONARIO F, FUNCIONARIO_PERSONAL FP WHERE 
PT.cpfCliente = C.cpf AND F.cpf = FP.cpfPersonal AND PT.cpfPersonal = FP.cpfPersonal GROUP BY F.nome HAVING COUNT (*) = 1;

-- Compute a diferença entre valor gasto mensalmente com a folha de pagamento das secretarias que possuem especialização com as que não tem.
SELECT (x-y) FROM (SELECT SUM(FS.salario) AS x FROM FUNCIONARIO_SECRETARIA FS, FUNCIONARIO F WHERE FS.cpfSecretaria = F.cpf
AND FS.capacitacao = "Especialização em Administração"), (SELECT SUM(FS.salario) AS y FROM FUNCIONARIO_SECRETARIA FS, FUNCIONARIO F WHERE FS.cpfSecretaria = F.cpf
AND FS.capacitacao = "Graduação em Administração");
