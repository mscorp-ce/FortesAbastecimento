unit uView.Abastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uView.FormBaseRegistration,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.DBCtrls, Vcl.WinXCalendars, uModel.Abstraction, uModel.Entities.Abastecimento;

type
  TfrmAbastecimento = class(TfrmBaseRegistration)
    lblAbastecimento: TLabel;
    edtAbastecimento: TEdit;
    lblDataHora: TLabel;
    lkpBomba: TDBLookupComboBox;
    lblBomba: TLabel;
    dsBomba: TDataSource;
    dtpDataHora: TDateTimePicker;
    lblQtdeLitros: TLabel;
    lblPrecoLitro: TLabel;
    lblValorTotal: TLabel;
    lblImposto: TLabel;
    edtQtdeLitros: TEdit;
    edtPrecoLitro: TEdit;
    edtValorTotal: TEdit;
    edtImposto: TEdit;
    cdsBomba: TClientDataSet;
    cdsBombaID_BOMBA: TIntegerField;
    cdsBombaID_TANQUE: TIntegerField;
    cdsBombaNUMERO_BOMBA: TIntegerField;
    cdsBombaDESCRICAO: TStringField;
    cdsBombaPRECO_LITRO: TCurrencyField;
    procedure edtQtdeLitrosKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoLitroKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTotalKeyPress(Sender: TObject; var Key: Char);
    procedure edtImpostoKeyPress(Sender: TObject; var Key: Char);
    procedure edtQtdeLitrosChange(Sender: TObject);
    procedure edtPrecoLitroChange(Sender: TObject);
    procedure lkpBombaExit(Sender: TObject);
    procedure edtValorTotalChange(Sender: TObject);
  private
    { Private declarations }
    ControllerAbastecimento: IController<TAbastecimento>;
    Abastecimento: TAbastecimento;
    FId: Integer;
    procedure SetId(const Value: Integer);
    procedure EnableControls();
    procedure OnKeyPress(Control: TEdit; Sender: TObject; var Key: Char);
    procedure LoadingLookupBomba();
    procedure CalcularValorTotal();
    procedure CalcularImposto();
  protected
    { Protected declarations }
    procedure DoShow(); override;
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
  uController.DataConverter.Abastecimento, uController.Abastecimento,
  uModel.Entities.Bomba, uController.RootBomba,
  uController.DataConverter.Bomba;

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
  Abastecimento.QuantidadeLitros:= StrToFloatDef(edtQtdeLitros.Text, 0);
  Abastecimento.PrecoLitro:= StrToFloatDef(edtPrecoLitro.Text, 0);
  Abastecimento.ValorTotal:= StrToFloatDef(edtValorTotal.Text, 0);
  Abastecimento.Imposto:= StrToFloatDef(edtImposto.Text, 0);
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

procedure TfrmAbastecimento.CalcularImposto();
const
  INCIDE_IMPOSTO = 0.13;
var
  LValorTotal, LImposto: Currency;
begin
  LValorTotal := StrToFloatDef(edtValorTotal.Text, 0);
  LImposto := LValorTotal * INCIDE_IMPOSTO;
  edtImposto.Text := FormatFloat('0.000', LImposto);
end;

procedure TfrmAbastecimento.CalcularValorTotal();
begin
  edtValorTotal.Text := FloatToStr(StrToFloatDef(edtQtdeLitros.Text, 0) * StrToFloatDef(edtPrecoLitro.Text, 0));
end;

destructor TfrmAbastecimento.Destroy();
begin
  FreeAndNil(Abastecimento);

  inherited Destroy;
end;

procedure TfrmAbastecimento.edtImpostoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  OnKeyPress(edtImposto, Sender, Key);
end;

procedure TfrmAbastecimento.edtPrecoLitroChange(Sender: TObject);
begin
  inherited;
  CalcularValorTotal();
end;

procedure TfrmAbastecimento.edtPrecoLitroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  OnKeyPress(edtPrecoLitro, Sender, Key);
end;

procedure TfrmAbastecimento.edtQtdeLitrosChange(Sender: TObject);
begin
  inherited;
  CalcularValorTotal();
end;

procedure TfrmAbastecimento.edtQtdeLitrosKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  OnKeyPress(edtQtdeLitros, Sender, Key);
end;

procedure TfrmAbastecimento.edtValorTotalChange(Sender: TObject);
begin
  inherited;
  if (StrToFloatDef(edtQtdeLitros.Text, 0) > 0) and (StrToFloatDef(edtPrecoLitro.Text, 0) > 0) then
    begin
      edtValorTotal.OnChange := nil;
      CalcularImposto();
    end;
  edtValorTotal.OnChange := edtValorTotalChange;
end;

procedure TfrmAbastecimento.edtValorTotalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  OnKeyPress(edtValorTotal, Sender, Key);
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

  LoadingLookupBomba();

  AddFocus();

  if id > 0 then
    begin
      Abastecimento:= ControllerAbastecimento.FindById(id);
      GetProperty();
    end
  else
    begin
      Abastecimento:= TAbastecimento.Create();
    end;
end;

procedure TfrmAbastecimento.GetProperty();
begin
  inherited;
  edtAbastecimento.Text := IntToStr(Abastecimento.Id);
  lkpBomba.KeyValue := Abastecimento.Bomba.Id;
  dtpDataHora.DateTime := Abastecimento.DataHora;
  edtQtdeLitros.Text := Abastecimento.QuantidadeLitros.ToString();
  edtPrecoLitro.Text:= Abastecimento.PrecoLitro.ToString();
  edtValorTotal.Text:= Abastecimento.ValorTotal.ToString();
  edtImposto.Text := Abastecimento.Imposto.ToString();
end;

procedure TfrmAbastecimento.lkpBombaExit(Sender: TObject);
begin
  inherited;
  edtPrecoLitro.Text := FloatToStr(cdsBomba.FieldByName('PRECO_LITRO').AsCurrency);
end;

procedure TfrmAbastecimento.LoadingLookupBomba();
var
  LControllerRootBomba: IRootController<TBomba>;
  LDataConverter: IDataConverter<TBomba>;
  LBombas: TObjectList<TBomba>;
begin
  LControllerRootBomba:= TControllerRootBomba.Create();
  cdsBomba.Close();

  cdsBomba.CreateDataSet();

  LBombas := LControllerRootBomba.FindAll();
  try
    LDataConverter:= TDataConverterBomba.Create();
    LDataConverter.Populate(LBombas, cdsBomba);

    cdsBomba.Open();

  finally
    FreeAndNil(LBombas);
  end;
end;

procedure TfrmAbastecimento.OnKeyPress(Control: TEdit; Sender: TObject; var Key: Char);
const
  BACKSPACE = #8;
  DEL = #127;
  PONTO = '.';
  VIRGULA = ',';
  LIMPAR = #0;
begin
  if CharInSet(Key, [BACKSPACE, DEL]) then
    Exit;

  if not CharInSet(Key, ['0'..'9', VIRGULA]) then
    Key := LIMPAR
  else if Key = VIRGULA then
    begin
      if Pos(',', Control.Text) > 0 then
        Key := LIMPAR;
    end;
end;

end.
