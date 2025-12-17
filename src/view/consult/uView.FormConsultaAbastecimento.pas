unit uView.FormConsultaAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormConsult, Data.DB,
  Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls,
  System.Generics.Collections, uModel.Abstraction, uModel.Entities.Abastecimento;

type
  TfrmConsultaAbastecimento = class(TfrmConsult)
    cdsConsultID_ABASTECIMENTO: TIntegerField;
    cdsConsultID_BOMBA: TIntegerField;
    cdsConsultNOME_BOMBA: TStringField;
    cdsConsultDATA_HORA: TDateTimeField;
    cdsConsultQUANTIDADE_LITROS: TCurrencyField;
    cdsConsultPRECO_LITRO: TCurrencyField;
    cdsConsultVALOR_TOTAL: TCurrencyField;
    cdsConsultIMPOSTO: TCurrencyField;
    procedure grdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdConsultDblClick(Sender: TObject);
  private
    { Private declarations }
    ControllerAbastecimento: IController<TAbastecimento>;

    procedure Search(const CommandSQL: String);
    procedure ExecuteFrom(const Id: Integer = 0);
  protected
    procedure DoShow(); override;
    procedure Filter(); override;
    procedure All(); override;
    procedure Include(); override;
    procedure Alter(); override;
    procedure Delete(); override;
    procedure Consult(); override;
  public
    { Public declarations }
  end;

var
  frmConsultaAbastecimento: TfrmConsultaAbastecimento;

implementation

{$R *.dfm}

uses
  System.UITypes, uModel.Repository.ConstsStatement.Abastecimento, uController.RootAbastecimento,
  uController.Abastecimento, uController.DataConverter.Abastecimento, uView.Abastecimento,
  uView.CustomFormFilterAbastecimento;

{ TfrmConsultaAbastecimento }

procedure TfrmConsultaAbastecimento.All();
begin
  inherited;
  Search('');
end;

procedure TfrmConsultaAbastecimento.Alter();
begin
  inherited;

  if cdsConsult.IsEmpty then
    begin
      ShowMessage('Não há registros a serem alterdos.');
      Exit();
    end;

  State:= dsEdit;

  ExecuteFrom(cdsConsult.FieldByName('ID_ABASTECIMENTO').AsInteger);

  All();
end;

procedure TfrmConsultaAbastecimento.Consult();
begin
  inherited;

  State:= dsBrowse;

  ExecuteFrom();
end;

procedure TfrmConsultaAbastecimento.Delete();
const
  Msg = 'Deseja mesmo excluir o registro selecionado?';
var
  LAbastecimento: TAbastecimento;
begin
  inherited;

  if cdsConsult.IsEmpty then
    begin
      ShowMessage('Não há registros a serem excluídos.');
      Exit();
    end;

  if MessageDlg(Msg, mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
    begin
      LAbastecimento := TAbastecimento.Create();
      try
        LAbastecimento.Id:= cdsConsult.FieldByName('ID_ABASTECIMENTO').AsInteger;
        if ControllerAbastecimento.DeleteById(LAbastecimento) then
          begin
            All();
          end;
      finally
        FreeAndNil(LAbastecimento);
      end;
    end;
end;

procedure TfrmConsultaAbastecimento.DoShow();
begin
  inherited;
  ControllerAbastecimento := TControllerAbastecimento.Create();

  All();
  State:= dsBrowse;
end;

procedure TfrmConsultaAbastecimento.Filter();
var
  LCustomFormFilter: TCustomFormFilterAbastecimento;
begin
  inherited;

  LCustomFormFilter:= TCustomFormFilterAbastecimento.Create();
  try
    LCustomFormFilter.ShowModal;
    var SQL:= QUERY_MOVIMENTO_ABASTECIMENTO;
    SQL:= SQL + LCustomFormFilter.Confirm('ABA');

    if SQL.IsEmpty() then
      begin
        ShowMessage('No filter informed.');
        Exit();
      end;

    Search(SQL);

  finally
    FreeAndNil(LCustomFormFilter);
  end;
end;

procedure TfrmConsultaAbastecimento.grdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
const
  DELETE = 46;
  CANCEL_ACTION_OF_DELETE = 0;
begin
  inherited;
  if (Shift = [ssCtrl]) and (Key = DELETE) then
    Key := CANCEL_ACTION_OF_DELETE;
end;

procedure TfrmConsultaAbastecimento.grdConsultDblClick(Sender: TObject);
begin
  inherited;
  Alter();
end;

procedure TfrmConsultaAbastecimento.ExecuteFrom(const Id: Integer);
var
  LFromAbastecimento: TfrmAbastecimento;
begin
  LFromAbastecimento:= TfrmAbastecimento.Create(Self);
  try
    LFromAbastecimento.Id:= Id;

    if State = dsInsert then
      LFromAbastecimento.dtpDataHora.Date := Now;

    LFromAbastecimento.ShowModal();
  finally
    FreeAndNil(LFromAbastecimento);
  end;
end;

procedure TfrmConsultaAbastecimento.Include();
begin
  inherited;
  State:= dsInsert;

  ExecuteFrom();

  All();
end;

procedure TfrmConsultaAbastecimento.Search(const CommandSQL: String);
var
  LControllerRootAbastecimento: IRootController<TAbastecimento>;
  LDataConverter: IDataConverter<TAbastecimento>;
  LAbastecimentos: TObjectList<TAbastecimento>;
begin
  LControllerRootAbastecimento:= TControllerRootAbastecimento.Create();
  cdsConsult.Close();

  cdsConsult.CreateDataSet();

  LAbastecimentos := LControllerRootAbastecimento.FindAll();
  try
    LDataConverter:= TDataConverterAbastecimento.Create();
    LDataConverter.Populate(LAbastecimentos, cdsConsult);

    cdsConsult.Open();

  finally
    FreeAndNil(LAbastecimentos);
  end;
end;

end.
