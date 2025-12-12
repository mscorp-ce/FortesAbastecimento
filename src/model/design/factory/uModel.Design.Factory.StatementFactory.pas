unit uModel.Design.Factory.StatementFactory;

interface

uses
  uModel.Abstraction, uModel.Repository.Statement, FireDAC.Comp.Client;

type
  TStatementFactory = class
  public
    class function GetStatement(DataManager: IDataManager<TFDConnection>): IStatement;
  end;

implementation

{ TStatementFactory }

class function TStatementFactory.GetStatement(DataManager: IDataManager<TFDConnection>): IStatement;
begin
  Result:= TStatement.Create(DataManager);
end;

end.

