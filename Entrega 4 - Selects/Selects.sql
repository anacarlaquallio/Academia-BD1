-- Encontre o nome da secretária que realizou o fluxo caixa da mensalidade de código 0622.
SELECT F.nome FROM FUNCIONARIO F, FUNCIONARIO_SECRETARIA S, FLUXO_CAIXA FC
WHERE F.cpf = S.cpfSecretaria AND FC.cpfSecretaria = S.cpfSecretaria 
AND FC.id IN (SELECT M.idFluxoCaixa FROM MENSALIDADE M WHERE M.cod = 0622);

-- Encontre as datas de início, termino e o nome do personal do plano de treino feito com base na avaliação física de código 8.
SELECT PT.dataIni, PT.dataFim, F.nome FROM PLANO_TREINO PT, AVALIACAO_FISICA AF, FUNCIONARIO F
WHERE  PT.cpfCliente = AF.cpfCliente AND AF.cod = 8 AND PT.cpfPersonal = F.cpf;

-- Compute o salário médio do cargo de secretária da academia por capacitação
SELECT AVG(FS.salario) AS Salario_Medio, FS.capacitacao AS Capacitacao FROM FUNCIONARIO_SECRETARIA FS, FUNCIONARIO F 
WHERE F.cpf = FS.cpfSecretaria GROUP BY FS.capacitacao;

-- Selecione o horário de funcionamento do equipamento que é utilizado no exercício "Supino reto"
SELECT EE.horario FROM EXERCICIOS_EQUIPAMENTOS EE WHERE EE.codExercicio IN
(SELECT E.cod FROM EXERCICIOS E WHERE E.nome LIKE "Supino reto");
