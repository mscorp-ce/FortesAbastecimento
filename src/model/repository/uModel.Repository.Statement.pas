unit uModel.Repository.Statement;

interface

uses
  FireDAC.Comp.Client, FireDAC.DApt, Data.DB, uModel.Abstraction;

type
  TStatement = class(TInterfacedObject, IStatement)
  private
    FQuery: TFDQuery;
  public
    constructor Create(DataManager: IDataManager);
    destructor Destroy; override;

    function GetQuery: TFDQuery;
    function SQL(const Value: String): IStatement;
    function Open: IStatement;
    property Query: TFDQuery read GetQuery;
  end;

implementation

uses
  System.SysUtils, FireDAC.Stan.Param;

{ TStatement }

constructor TStatement.Create(DataManager: IDataManager);
begin
  inherited Create;

  FQuery:= TFDQuery.Create(nil);

  FQuery.Connection:= TFDConnection(DataManager.Connection);
end;

destructor TStatement.Destroy;
begin
  FreeAndNil(FQuery);

  inherited;
end;

function TStatement.GetQuery: TFDQuery;
begin
  Result:= FQuery;
end;

function TStatement.Open: IStatement;
begin
  FQuery.Active := True;
  Result:= Self;
end;

function TStatement.SQL(const Value: String): IStatement;
begin
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
  Result:= Self;
end;

end.



