unit uModel.Repository.DataManagerFactory;

interface

uses
  uModel.Abstraction, uModel.FireDac;

type
  TDataManagerFactory = class
  public
    class function GetDataManager(): IDataManager;
  end;

implementation

{ TDataManagerFactory }

class function TDataManagerFactory.GetDataManager(): IDataManager;
begin
  Result:= TModelFireDAC.Create();
end;

end.


