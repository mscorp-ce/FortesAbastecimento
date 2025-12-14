unit uModel.Repository.Abastecimento;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, uModel.Abstraction,
  uModel.Entities.Abastecimento;

type
  TAbastecimentoRepository = class(TInterfacedObject, IRepository<TAbastecimento>)
  public
    function Fields(): TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TAbastecimento);
    procedure SetProperty(Statement: IStatement; Entity: TAbastecimento);
    function Save(Entity: TAbastecimento): Boolean;
    function Update(Entity: TAbastecimento): Boolean; overload;
    function DeleteById(Entity: TAbastecimento): Boolean;
    function FindById(Id: Integer): TAbastecimento;
    function FindExists(CommadSQL: String; Parameter: String;
      ParameterType: TFieldType; Value: Variant): IStatement; overload;
    procedure PopulateListEntitie(var List: TObjectList<TAbastecimento>; const Statement: IStatement);
    function CommandSQL(): string;
    function Find(): Integer;
    function FindAll(): TObjectList<TAbastecimento>; overload;
    function FindAll(CommadSQL: String): TObjectList<TAbastecimento>; overload;
    function FindAll(CommadSQL: String; Entity: TAbastecimento): TObjectList<TAbastecimento>; overload;
    function FindAll(Id: Integer): TObjectList<TAbastecimento>; overload;

    destructor Destroy(); override;
  end;

const
  ROWS_AFFECTED = 1;

implementation

{ TAbastecimentoRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Repository.StatementFactory, uModel.Design.Factory.DataManagerFactory,
  uModel.Repository.DataManager, uModel.FireDACEngineException, FireDAC.Stan.Param,
  uModel.Repository.ConstsStatement.Abastecimento;

function TAbastecimentoRepository.CommandSQL(): string;
begin
  Result := QUERY_ABASTECIMENTO;
end;

function TAbastecimentoRepository.DeleteById(Entity: TAbastecimento): Boolean;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_DELETE_ABASTECIMENTO_ID);
    Statement.Query.Params.ParamByName('ID_ABASTECIMENTO').AsInteger:= Entity.Id;
    Statement.Query.ExecSQL;

    Result:=  Statement.Query.RowsAffected = ROWS_AFFECTED;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

destructor TAbastecimentoRepository.Destroy();
begin
  inherited Destroy;
end;

function TAbastecimentoRepository.Fields(): TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('ABASTECIMENTOS').GetFieldNames;

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.FindAll(CommadSQL: String): TObjectList<TAbastecimento>;
var
  Statement: IStatement;
  List: TObjectList<TAbastecimento>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TAbastecimento>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(CommadSQL).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.FindAll(): TObjectList<TAbastecimento>;
var
  Statement: IStatement;
  List: TObjectList<TAbastecimento>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TAbastecimento>.Create;

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_MOVIMENTO_ABASTECIMENTO).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.FindById(Id: Integer): TAbastecimento;
var
  Statement: IStatement;
  LAbastecimento: TAbastecimento;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_ABASTECIMENTOS_BY_ID);
    Statement.Query.Params.ParamByName('ID_ABASTECIMENTO').AsInteger:= Id;
    Statement.Query.Open;

    LAbastecimento:= TAbastecimento.Create;

    SetProperty(Statement, LAbastecimento);

    Result:= LAbastecimento;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.FindExists(CommadSQL: String; Parameter: String;
  ParameterType: TFieldType; Value: Variant): IStatement;
var
  Statement: IStatement;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(CommadSQL);
    case ParameterType of
      ftString: Statement.Query.Params.ParamByName(Parameter).AsString:= Value;
      ftInteger: Statement.Query.Params.ParamByName(Parameter).AsInteger:= Value;
      ftDate: Statement.Query.Params.ParamByName(Parameter).AsDate:= Value;
      ftDateTime: Statement.Query.Params.ParamByName(Parameter).AsDateTime:= Value;
      ftTimeStamp: Statement.Query.Params.ParamByName(Parameter).AsDateTime:= Value;
      ftTime: Statement.Query.Params.ParamByName(Parameter).AsTime:= Value;
      ftFloat: Statement.Query.Params.ParamByName(Parameter).AsFloat:= Value;
    end;

    Statement.Query.Open;

    Result:= Statement;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TAbastecimentoRepository.PopulateListEntitie(var List: TObjectList<TAbastecimento>;
  const Statement: IStatement);
var
  Abastecimento: TAbastecimento;
begin
  Statement.Query.First();

  while not Statement.Query.Eof do
    begin
      Abastecimento:= TAbastecimento.Create();

      SetProperty(Statement, Abastecimento);

      List.Add(Abastecimento);
      Statement.Query.Next();
    end;
end;

function TAbastecimentoRepository.Save(Entity: TAbastecimento): Boolean;
var
  Statement: IStatement;
  LRowsAffected: Boolean;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_INSERT_ABASTECIMENTO);
    SetStatement(Statement, Entity);
    Statement.Query.Open;

    LRowsAffected := Statement.Query.RowsAffected = ROWS_AFFECTED;

    Entity.Id := Statement.Query.FieldByName('ID_ABASTECIMENTO').AsInteger;

    DataManager.Commit;

    Result:= LRowsAffected;

  except
    on Error: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TAbastecimentoRepository.SetProperty(Statement: IStatement;
  Entity: TAbastecimento);
begin
  try
    Entity.Id := Statement.Query.FieldByName('ID_ABASTECIMENTO').AsInteger;
    Entity.DataHora := Statement.Query.FieldByName('DATA_HORA').AsDateTime;
    Entity.Bomba.Id := Statement.Query.FieldByName('ID_BOMBA').AsInteger;
    Entity.Bomba.Descricao := Statement.Query.FieldByName('NOME_BOMBA').AsString;
    Entity.QuantidadeLitros := Statement.Query.FieldByName('QUANTIDADE_LITROS').AsCurrency;
    Entity.PrecoLitro := Statement.Query.FieldByName('PRECO_LITRO').AsCurrency;
    Entity.ValorTotal := Statement.Query.FieldByName('VALOR_TOTAL').AsCurrency;
    Entity.Imposto := Statement.Query.FieldByName('IMPOSTO').AsCurrency;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TAbastecimentoRepository.SetStatement(Statement: IStatement;
  Entity: TAbastecimento);
begin
  try
    Statement.Query.Params.ParamByName('DATA_HORA').AsDateTime := Entity.DataHora;
    Statement.Query.Params.ParamByName('ID_BOMBA').AsInteger := Entity.Bomba.Id;
    Statement.Query.Params.ParamByName('QUANTIDADE_LITROS').AsCurrency := Entity.QuantidadeLitros;
    Statement.Query.Params.ParamByName('PRECO_LITRO').AsCurrency := Entity.PrecoLitro;
    Statement.Query.Params.ParamByName('VALOR_TOTAL').AsCurrency := Entity.ValorTotal;
    Statement.Query.Params.ParamByName('IMPOSTO').AsCurrency := Entity.Imposto;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TAbastecimentoRepository.Update(Entity: TAbastecimento): Boolean;
var
  Statement: IStatement;
begin
  DataManager.StartTransaction;
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_UPDATE_ABASTECIMENTO_BY_ID);
    Statement.Query.Params.ParamByName('ID_ABASTECIMENTO').AsInteger:= Entity.Id;
    SetStatement(Statement, Entity);
    Statement.Query.ExecSQL;
    DataManager.Commit;

    Result:= Statement.Query.RowsAffected = ROWS_AFFECTED;

  except
    on Error: EFDDBEngineException do
      begin
        DataManager.Rollback;
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.FindAll(CommadSQL: String;
  Entity: TAbastecimento): TObjectList<TAbastecimento>;
var
  Statement: IStatement;
  List: TObjectList<TAbastecimento>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TAbastecimento>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(CommadSQL);
    Statement.Query.Params.ParamByName('ID_ABASTECIMENTO').AsInteger:= Entity.Id;
    Statement.Query.Open;

    PopulateListEntitie(List, Statement);

    Result:= List;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TAbastecimentoRepository.Find: Integer;
begin
  Result := 0;
end;

function TAbastecimentoRepository.FindAll(Id: Integer): TObjectList<TAbastecimento>;
begin
  Result := nil;
end;

end.
