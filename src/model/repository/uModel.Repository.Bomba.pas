unit uModel.Repository.Bomba;

interface

uses
  System.Classes, System.Generics.Collections, Data.DB, uModel.Abstraction,
  uModel.Entities.Bomba;

type
  TBombaRepository = class(TInterfacedObject, IRepository<TBomba>)
  public
    function Fields(): TStrings;
    procedure SetStatement(Statement: IStatement; Entity: TBomba);
    procedure SetProperty(Statement: IStatement; Entity: TBomba);
    function Save(Entity: TBomba): Boolean;
    function Update(Entity: TBomba): Boolean; overload;
    function DeleteById(Entity: TBomba): Boolean;
    function FindById(Id: Integer): TBomba;
    function FindExists(CommadSQL: String; Parameter: String;
      ParameterType: TFieldType; Value: Variant): IStatement; overload;
    procedure PopulateListEntitie(var List: TObjectList<TBomba>; const Statement: IStatement);
    function CommandSQL(): string;
    function Find(): Integer;
    function FindAll(): TObjectList<TBomba>; overload;
    function FindAll(CommadSQL: String): TObjectList<TBomba>; overload;
    function FindAll(CommadSQL: String; Entity: TBomba): TObjectList<TBomba>; overload;
    function FindAll(Id: Integer): TObjectList<TBomba>; overload;

    destructor Destroy(); override;
  end;

const
  ROWS_AFFECTED = 1;

implementation

{ TBombaRepository }

uses
  System.SysUtils, FireDAC.Stan.Error, uModel.Repository.StatementFactory, uModel.Design.Factory.DataManagerFactory,
  uModel.Repository.DataManager, uModel.FireDACEngineException, FireDAC.Stan.Param,
  uModel.Repository.ConstsStatement.Bomba;

function TBombaRepository.CommandSQL(): string;
begin
  Result := QUERY_BOMBA;
end;

function TBombaRepository.DeleteById(Entity: TBomba): Boolean;
begin
  Result := False;
end;

destructor TBombaRepository.Destroy();
begin
  inherited Destroy;
end;

function TBombaRepository.Fields(): TStrings;
var
  Items: TStrings;
begin
  try
    Items:= DataManager.GetEntity('Bombas').GetFieldNames;

    Result:= Items;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TBombaRepository.FindAll(CommadSQL: String): TObjectList<TBomba>;
var
  Statement: IStatement;
  List: TObjectList<TBomba>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TBomba>.Create();

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

function TBombaRepository.FindAll(): TObjectList<TBomba>;
var
  Statement: IStatement;
  List: TObjectList<TBomba>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TBomba>.Create;

    Statement.Query.SQL.Clear();
    Statement.SQL(QUERY_BOMBA).Open();

    PopulateListEntitie(List, Statement);

    Result:= List;
  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TBombaRepository.FindById(Id: Integer): TBomba;
var
  Statement: IStatement;
  LBomba: TBomba;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);

    Statement.Query.SQL.Clear();
    Statement.Query.SQL.Add(QUERY_BOMBA_BY_ID);
    Statement.Query.Params.ParamByName('ID_BOMBA').AsInteger:= Id;
    Statement.Query.Open;

    LBomba:= TBomba.Create;

    SetProperty(Statement, LBomba);

    Result:= LBomba;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TBombaRepository.FindExists(CommadSQL: String; Parameter: String;
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

procedure TBombaRepository.PopulateListEntitie(var List: TObjectList<TBomba>;
  const Statement: IStatement);
var
  Bomba: TBomba;
begin
  Statement.Query.First();

  while not Statement.Query.Eof do
    begin
      Bomba:= TBomba.Create();

      SetProperty(Statement, Bomba);

      List.Add(Bomba);
      Statement.Query.Next();
    end;
end;

function TBombaRepository.Save(Entity: TBomba): Boolean;
begin
  Result:= False;
end;

procedure TBombaRepository.SetProperty(Statement: IStatement;
  Entity: TBomba);
begin
  try
    Entity.Id := Statement.Query.FieldByName('ID_BOMBA').AsInteger;
    Entity.Tanque.Id := Statement.Query.FieldByName('ID_TANQUE').AsInteger;
    Entity.Numero := Statement.Query.FieldByName('NUMERO_BOMBA').AsInteger;
    Entity.Descricao := Statement.Query.FieldByName('DESCRICAO').AsString;

  except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

procedure TBombaRepository.SetStatement(Statement: IStatement;
  Entity: TBomba);
begin
  try
    Statement.Query.FieldByName('ID_BOMBA').AsInteger := Entity.Id;
    Statement.Query.FieldByName('ID_TANQUE').AsInteger := Entity.Tanque.Id;
    Statement.Query.FieldByName('NUMERO_BOMBA').AsInteger := Entity.Numero;
    Statement.Query.FieldByName('DESCRICAO').AsString := Entity.Descricao;

  except
    on Error: EFDDBEngineException do
      raise Exception.Create(TFireDACEngineException.GetMessage(Error));
  end;
end;

function TBombaRepository.Update(Entity: TBomba): Boolean;
begin
  Result:= False;
end;

function TBombaRepository.FindAll(CommadSQL: String;
  Entity: TBomba): TObjectList<TBomba>;
var
  Statement: IStatement;
  List: TObjectList<TBomba>;
begin
  try
    Statement:= TStatementFactory.GetStatement(DataManager);
    List:= TObjectList<TBomba>.Create();

    Statement.Query.SQL.Clear();
    Statement.SQL(CommadSQL);
    Statement.Query.Params.ParamByName('ID_BOMBA').AsInteger:= Entity.Id;
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

function TBombaRepository.Find: Integer;
begin
  Result := 0;
end;

function TBombaRepository.FindAll(Id: Integer): TObjectList<TBomba>;
begin
  Result := nil;
end;

end.
