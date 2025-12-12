unit uModel.Repository.StatementFactory;

interface

uses
  uModel.Abstraction, uModel.Repository.Statement, FireDAC.Comp.Client;

type
  TStatementFactory = class
  public
    class function GetStatement(DataManager: IDataManager): IStatement;
  end;

implementation

{ TStatementFactory }

class function TStatementFactory.GetStatement(DataManager: IDataManager): IStatement;
begin
  Result:= TStatement.Create(DataManager);
end;

end.

