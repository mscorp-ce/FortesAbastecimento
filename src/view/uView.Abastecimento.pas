unit uView.Abastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormBaseRegistration,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Abastecimento,
  Vcl.Grids, Vcl.DBGrids, Vcl.Samples.Spin, Vcl.NumberBox;

type
  TfrmAbastecimento = class(TfrmBaseRegistration)
    lblAbastecimento: TLabel;
    edtAbastecimento: TEdit;
    lblDataHora: TLabel;
    lkpBomba: TDBLookupComboBox;
    lblBomba: TLabel;
    dsBomba: TDataSource;
    cdsBomba: TClientDataSet;
    cdsBombaid_bomba: TIntegerField;
    cdsBombadescricao: TStringField;
    dtpDataHora: TDateTimePicker;
    lblQtdeLitros: TLabel;
    lblPrecoLitro: TLabel;
    lblValorTotal: TLabel;
    lblImposto: TLabel;
    nubQtdeLitros: TNumberBox;
    nubPrecoLitro: TNumberBox;
    nubValorTotal: TNumberBox;
    nubImposto: TNumberBox;
  protected
    procedure DoShow; override;
  private
    { Private declarations }
    ControllerAbastecimento: IController<TAbastecimento>;
    Abastecimento: TAbastecimento;
    FId: Integer;
    procedure SetId(const Value: Integer);
    procedure EnableControls();
  protected
    { Protected declarations }
    procedure AddFocus(); override;
    procedure GetProperty(); override;
    procedure SetProperty(); override;
    function Save(): Boolean; override;
    procedure AfterSave(); override;

    procedure Restore(); override;
  public
    { Public declarations }
    property Id: Integer read FId write SetId;
    destructor Destroy(); override;
  end;

const
  UNKNOWN = -1;
  IN_PROGRESS = 0;
  PENDING = 1;
  COMPLETED = 2;

var
  frmAbastecimento: TfrmAbastecimento;

implementation

{$R *.dfm}

uses
  System.Generics.Collections, uController.RootAbastecimento,
  uController.DataConverter.Abastecimento, uController.Abastecimento;

function TfrmAbastecimento.Save(): Boolean;
begin
  inherited;
  SetProperty;
  case State of
    dsInsert:
      begin
        if ControllerAbastecimento.Save(Abastecimento) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Abastecimento gravado com sucesso.');
          end;
      end;

    dsEdit:
      begin
        if ControllerAbastecimento.Update(Abastecimento) then
          begin
            State:= dsBrowse;
            AfterSave;
            ShowMessage('Abastecimento alterado com sucesso.');
          end;
      end;
    dsBrowse: Close;
  end;

  EnableControls();

  Result:= True;
end;

procedure TfrmAbastecimento.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TfrmAbastecimento.SetProperty();
begin
  inherited;
  Abastecimento.Id:= StrToIntDef(edtAbastecimento.Text, 0);
  Abastecimento.Bomba.Id:= lkpBomba.KeyValue;
  Abastecimento.DataHora:= dtpDataHora.DateTime;
  Abastecimento.QuantidadeLitros:= nubQtdeLitros.Value;
  Abastecimento.PrecoLitro:= nubPrecoLitro.Value;
  Abastecimento.ValorTotal:= nubValorTotal.Value;
  Abastecimento.Imposto:= nubImposto.Value;
end;

procedure TfrmAbastecimento.AddFocus();
begin
  inherited;
  lkpBomba.SetFocus();
end;

procedure TfrmAbastecimento.Restore();
begin
  inherited;
  if State = dsEdit then
    begin
      Abastecimento:= ControllerAbastecimento.FindById(fId);
      GetProperty();
    end;

  EnableControls();
end;

procedure TfrmAbastecimento.AfterSave();
begin
  inherited;
  edtAbastecimento.Text:= IntToStr( Abastecimento.Id );
  State:= dsBrowse;
end;

destructor TfrmAbastecimento.Destroy();
begin
  FreeAndNil(Abastecimento);

  inherited Destroy;
end;

procedure TfrmAbastecimento.EnableControls();
begin
  spbRestore.Enabled:= State = dsEdit;
  spbRestore.Visible:= State = dsEdit;
end;

procedure TfrmAbastecimento.DoShow();
begin
  inherited;
  ControllerAbastecimento:= TControllerAbastecimento.Create();

  EnableControls();

  AddFocus();

  if id > 0 then
    begin
      Abastecimento:= ControllerAbastecimento.FindById(id);
      GetProperty();
    end
  else
    begin
      Abastecimento:= TAbastecimento.Create();
      //edtProjectCode.Text:= IntToStr( ControllerProject.GeneratedValue );
    end;
end;

procedure TfrmAbastecimento.GetProperty();
begin
  inherited;
  edtAbastecimento.Text := IntToStr(Abastecimento.Id);
  lkpBomba.KeyValue := Abastecimento.Bomba.Id;
  dtpDataHora.DateTime := Abastecimento.DataHora;
  nubQtdeLitros.Value := Abastecimento.QuantidadeLitros;
  nubPrecoLitro.Value := Abastecimento.PrecoLitro;
  nubValorTotal.Value := Abastecimento.ValorTotal;
  nubImposto.Value := Abastecimento.Imposto;
end;

end.
