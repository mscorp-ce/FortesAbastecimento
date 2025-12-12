unit uModel.Repository.DataManager;

interface

uses
  uModel.Abstraction, FireDAC.Comp.Client;

var
  DataManager: IDataManager<TFDConnection>;

implementation

uses
  uModel.Design.Factory.DataManagerFactory;

initialization
  DataManager:= TDataManagerFactory.GetDataManager();

finalization
  DataManager.Connection.Close();
end.

