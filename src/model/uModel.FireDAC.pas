unit uModel.FireDAC;

interface

uses
  uModel.Abstraction, System.Classes, System.SysUtils, FireDAC.Stan.Option, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.ODBCBase, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Moni.RemoteClient, FireDAC.Moni.FlatFile, FireDAC.Moni.Base, FireDAC.Moni.Custom;

type
  TModelFireDAC = class(TInterfacedObject, IDataManager<TFDConnection>)
    procedure onRecover(ASender, AInitiator: TObject;
      AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure onOutput(ASender: TFDMoniClientLinkBase;
      const AClassName, AObjName, AMessage: string);
  private
    FConnection : TFDConnection;

    FFBDriver: TFDPhysFBDriverLink;

    FMonitor: TFDMoniCustomClientLink;

    FMonitorRemote: TFDMoniRemoteClientLink;

    FMessages: TStrings;
    FEntitieName: String;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function GetStartTransaction(): IDataManager<TFDConnection>;
    function GetCommit(): IDataManager<TFDConnection>;
    function GetRollback(): IDataManager<TFDConnection>;
    function GetEntity(EntitieName: String): IDataManager<TFDConnection>;
    function GetFieldNames(): TStrings;

    function GetConnection(): TFDConnection;

    property Connection: TFDConnection read GetConnection;
    property StartTransaction: IDataManager<TFDConnection> read GetStartTransaction;
    property Commit: IDataManager<TFDConnection> read GetCommit;
    property Rollback: IDataManager<TFDConnection> read GetRollback;
  end;

implementation

uses
  uInfra.Libary, Vcl.Dialogs, Vcl.Controls, System.UITypes, FireDAC.Stan.Intf, FireDAC.Stan.Error, uModel.FireDACEngineException;

{ TModelFireDAC }

constructor TModelFireDAC.Create();
begin
   inherited Create;
  try
    FConnection := TFDConnection.Create(nil);
    FConnection.DriverName                := TLibary.GetINI('DATA_FB', 'DriverName');
    FConnection.Params.Values['Server']   := TLibary.GetINI('DATA_FB', 'Server');
    FConnection.Params.Values['Port']     := TLibary.GetINI('DATA_FB', 'Port');
    FConnection.Params.Values['Database'] := TLibary.GetINI('DATA_FB', 'Database');
    FConnection.Params.Values['User_Name']:= TLibary.GetINI('DATA_FB', 'User_Name');
    FConnection.Params.Values['Password'] := TLibary.GetINI('DATA_FB', 'Password');

    FFBDriver := TFDPhysFBDriverLink.Create(nil);

    FFBDriver.VendorHome := TLibary.GetINI('DATA_FB', 'Data_Home');
    FFBDriver.VendorLib := TLibary.GetINI('DATA_FB', 'Data_Libary');

    if not FileExists(FFBDriver.VendorHome + '\'+ FFBDriver.VendorLib) then
      raise Exception.Create('Não foi possível carregar o fbclient.dll');

    FMonitor:= TFDMoniCustomClientLink.Create(nil);
    FMonitor.Tracing:= false;

    FMonitorRemote:= TFDMoniRemoteClientLink.Create(nil);
    FMonitorRemote.Host:= '127.0.0.1';
    FMonitorRemote.Port:= 8050;
    FMonitorRemote.Timeout:= 3000;
    FMonitorRemote.Tracing:= False;

    FConnection.Params.MonitorBy:= mbRemote;

    FMessages:= TStringList.Create;

    FConnection.OnRecover:= onRecover;
    FConnection.Open;

  except
    on Error: EFDDBEngineException do
      ShowMessage( TFireDACEngineException.GetMessage(Error) );
  end;
end;

destructor TModelFireDAC.Destroy();
begin
  FreeAndNil( FConnection );
  FreeAndNil( FFBDriver );
  FreeAndNil( FMonitor );
  FMessages.Clear();
  FreeAndNil( FMessages );
  FreeAndNil( FMonitorRemote );
  inherited Destroy();
end;

function TModelFireDAC.GetEntity(EntitieName: String): IDataManager<TFDConnection>;
begin
  fEntitieName:= EntitieName;
  Result:= Self;
end;

function TModelFireDAC.GetCommit(): IDataManager<TFDConnection>;
begin
  FConnection.Commit();
  Result:= Self;
end;

function TModelFireDAC.GetConnection(): TFDConnection;
begin
  Result:= FConnection;
end;

function TModelFireDAC.GetFieldNames(): TStrings;
var
  Items: TStrings;
begin
  Items:= TStringList.Create();
  try
    FConnection.GetFieldNames('', '', fEntitieName, '', Items);

    Result:= Items;
 except
    on Error: EFDDBEngineException do
      begin
        raise Exception.Create(TFireDACEngineException.GetMessage(Error));
      end;
  end;
end;

function TModelFireDAC.GetRollback(): IDataManager<TFDConnection>;
begin
  FConnection.Rollback();
  Result:= Self;
end;

function TModelFireDAC.GetStartTransaction(): IDataManager<TFDConnection>;
begin
  FConnection.StartTransaction();
  Result:= Self;
end;

procedure TModelFireDAC.onOutput(ASender: TFDMoniClientLinkBase;
  const AClassName, AObjName, AMessage: string);
begin
  FMessages.Add(AMessage);
end;

procedure TModelFireDAC.onRecover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
var
  Res: Integer;
begin
  Res:= MessageDlg('Conexão perdida, escolha o que você deseja fazer: YES - OffLine, Reconectar - OK, Falha - Cancel',
                   mtConfirmation, [mbYes, mbOK, mbCancel], 0
                   );

  case Res of
    mrYes: AAction:= faOfflineAbort;
    mrOK: AAction:= faRetry;
    mrCancel: AAction:= faFail;
  end;
end;

end.



