unit uView.FormFilters;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmFiltros = class(TForm)
    pnlControl: TPanel;
    grbFilters: TGroupBox;
    cbxFields: TComboBox;
    edtFilterValue: TEdit;
    cbxOrder: TComboBox;
    rdgAttributes: TRadioGroup;
    lblOrder: TLabel;
    lblFilterBy: TLabel;
    lblFilterValue: TLabel;
    cbxOperator: TComboBox;
    lblOperator: TLabel;
    spbConfirmar: TSpeedButton;
    procedure spbConfirmarClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FEntite: String;
    procedure SetEntite(const Value: String);
  public
    { Public declarations }
    function Confirm(Alias: String): String; virtual;

    property Entite: String read FEntite write SetEntite;
  end;

var
  frmFiltros: TfrmFiltros;

implementation

uses
  uInfra.Libary;

{$R *.dfm}

{ TfrmFiltros }

function TfrmFiltros.Confirm(Alias: String): String;
const
  ASCENDING = 0;
  DESCENDING = 1;

  EQUAL_A = 0;
  GREATER_THAN = 1;
  LESSER_THAN = 2;
  GREATER_OR_EQUAL = 3;
  LESSER_OR_EQUAL = 4;
  DIFFERENT = 5;
  START_WITH = 6;
  ENDS_WITH = 7;
  CONTAINS = 8;
var
  Attribute: String;
  Clause: String;
begin
  if cbxFields.ItemIndex < 0 then
    begin
      ShowMessage('Nenhum atributo foi inserido para ser filtrado.');
      Exit;
    end;

  if cbxOperator.ItemIndex < 0 then
    begin
      ShowMessage('Nenhum atributo foi fornecido para o operador.');
      Exit;
    end;

  Clause:= ' WHERE ' + Alias + '.'+  cbxFields.Text + ' ';

  case cbxOperator.ItemIndex of
    EQUAL_A: Clause:= Clause + ' = ' + QuotedStr(edtFilterValue.Text);
    GREATER_THAN: Clause:= Clause + ' > ' + edtFilterValue.Text;
    LESSER_THAN: Clause:= Clause + ' < ' +edtFilterValue.Text;
    GREATER_OR_EQUAL: Clause:= Clause + ' >= ' + edtFilterValue.Text;
    LESSER_OR_EQUAL: Clause:= Clause + ' <= ' + edtFilterValue.Text;
    DIFFERENT: Clause:= Clause + ' <> ' + edtFilterValue.Text;
    START_WITH: Clause:= Clause + ' LIKE '+ QuotedStr(edtFilterValue.Text +'%');
    ENDS_WITH: Clause:= Clause + ' LIKE  ' + QuotedStr('%'+ edtFilterValue.Text );
    CONTAINS: Clause:= Clause + ' LIKE  ' + QuotedStr('%'+ edtFilterValue.Text + '%');
  end;

  case rdgAttributes.ItemIndex of
    ASCENDING: Attribute:= ' ASC ';
    DESCENDING: Attribute:= ' DESC ';
  end;

  Clause:= Clause + ' ORDER BY ' + Alias + '.' + cbxOrder.Text + Attribute;

  Result:= TLibary.iif(((cbxFields.ItemIndex >=0) and (cbxOperator.ItemIndex >=0) and (Length(edtFilterValue.Text) >=1)),
            Clause, '');

  Close;
end;

procedure TfrmFiltros.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) or (Key = #13) then
    Close;
end;

procedure TfrmFiltros.SetEntite(const Value: String);
begin
  FEntite := Value;
end;

procedure TfrmFiltros.spbConfirmarClick(Sender: TObject);
begin
  Close;
end;

end.
