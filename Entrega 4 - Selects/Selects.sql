-- Encontre o nome da secretária que realizou o fluxo caixa da mensalidade de código 0622.
SELECT F.nome FROM FUNCIONARIO F, FUNCIONARIO_SECRETARIA S, FLUXO_CAIXA FC
WHERE F.cpf = S.cpfSecretaria AND FC.cpfSecretaria = S.cpfSecretaria 
AND FC.id IN (SELECT M.idFluxoCaixa FROM MENSALIDADE M WHERE M.cod = 0622);

