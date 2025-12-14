unit uModel.Repository.ConstsStatement.Bomba;

interface

const
  QUERY_BOMBA =
    'SELECT BOM.ID_BOMBA, ' + sLineBreak +
    '       BOM.ID_TANQUE, ' + sLineBreak +
    '       BOM.NUMERO_BOMBA, ' + sLineBreak +
    '       BOM.DESCRICAO, ' + sLineBreak +
    '       BOM.PRECO_LITRO ' + sLineBreak +
    '  FROM BOMBAS BOM ';

  QUERY_CLASE_WHERE_BY_ID = ' WHERE ID_BOMBA = :ID_BOMBA ';

  QUERY_BOMBA_BY_ID =
    QUERY_BOMBA + QUERY_CLASE_WHERE_BY_ID;

implementation

end.
