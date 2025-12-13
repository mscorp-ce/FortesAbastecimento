unit uModel.Repository.ConstsStatement.Abastecimento;

interface

const
  QUERY_ABASTECIMENTO =
    '   SELECT CAST(ABA.DATA_HORA AS DATE) AS DIA, ' + sLineBreak +
    '          TAN.DESCRICAO AS TANQUE, ' + sLineBreak +
    '          BOM.NUMERO_BOMBA, ' + sLineBreak +
    '          SUM(ABA.VALOR_TOTAL) AS VALOR ' + sLineBreak +
    '     FROM ABASTECIMENTOS ABA ' + sLineBreak +
    '     JOIN BOMBAS BOM ON ABA.ID_BOMBA = BOM.ID_BOMBA ' + sLineBreak +
    '     JOIN TANQUES TAN ON BOM.ID_TANQUE = TAN.ID_TANQUE ' + sLineBreak +
    ' GROUP BY CAST(ABA.DATA_HORA AS DATE), ' + sLineBreak +
    '          TAN.DESCRICAO, ' + sLineBreak +
    '          BOM.NUMERO_BOMBA ' + sLineBreak +
    ' ORDER BY DIA, TANQUE, NUMERO_BOMBA; ';

  QUERY_ABASTECIMENTOS_BY_ID =
    'SELECT ABA.ID_ABASTECIMENTO, ' + sLineBreak +
    '       ABA.ID_BOMBA, ' + sLineBreak +
    '       ABA.DATA_HORA, ' + sLineBreak +
    '       ABA.QUANTIDADE_LITROS, ' + sLineBreak +
    '       ABA.VALOR_TOTAL, ' + sLineBreak +
    '       ABA.IMPOSTO ' + sLineBreak +
    '  FROM ABASTECIMENTOS ABA ' + sLineBreak +
    ' WHERE ABA.ID_ABASTECIMENTO = :ID_ABASTECIMENTO ';

  QUERY_INSERT_ABASTECIMENTO =
    'INSERT INTO ABASTECIMENTOS(ID_BOMBA, DATA_HORA, QUANTIDADE_LITROS, PRECO_LITRO, VALOR_TOTAL, IMPOSTO) ' + sLineBreak +
    'VALUES (:ID_BOMBA, :DATA_HORA, :QUANTIDADE_LITROS, :PRECO_LITRO, :VALOR_TOTAL, :IMPOSTO) ' + sLineBreak +
    'RETURNING ID_ABASTECIMENTO ';

  QUERY_CLASE_WHERE_BY_ID = ' WHERE ID_ABASTECIMENTO = :ID_ABASTECIMENTO ';

  QUERY_ABASTECIMENTO_BY_ID = QUERY_ABASTECIMENTO + sLineBreak + QUERY_CLASE_WHERE_BY_ID;

  QUERY_PROJECT_ALLOCATION_BY_TASK_COD = QUERY_ABASTECIMENTO + sLineBreak + QUERY_CLASE_WHERE_BY_ID;

  QUERY_UPDATE_ABASTECIMENTO_BY_ID =
    'UPDATE ABASTECIMENTOS'+ sLineBreak +
    '   SET ID_BOMBA = :ID_BOMBA, '+ sLineBreak +
    '       DATA_HORA = :DATA_HORA, = :DATA_HORA, '+ sLineBreak +
    '       QUANTIDADE_LITROS = :QUANTIDADE_LITROS, '+ sLineBreak +
    '       PRECO_LITRO = :PRECO_LITRO, '+ sLineBreak +
    '       VALOR_TOTAL = :VALOR_TOTAL, '+ sLineBreak +
    '       IMPOSTO = :IMPOSTO '+ sLineBreak +
    QUERY_CLASE_WHERE_BY_ID;

  QUERY_DELETE_ABASTECIMENTO_ID =
    'DELETE ' + sLineBreak +
    '  FROM ABASTECIMENTOS ' + sLineBreak +
    QUERY_CLASE_WHERE_BY_ID;

implementation

end.
