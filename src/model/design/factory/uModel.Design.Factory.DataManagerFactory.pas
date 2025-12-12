unit uModel.Design.Factory.DataManagerFactory;

interface

uses
  uModel.Abstraction, uModel.FireDac, FireDAC.Comp.Client;

type
  TDataManagerFactory = class
  public
    class function GetDataManager(): IDataManager<TFDConnection>;
  end;

implementation

{ TDataManagerFactory }

class function TDataManagerFactory.GetDataManager(): IDataManager<TFDConnection>;
begin
  Result:= TModelFireDAC.Create();
end;

end.


