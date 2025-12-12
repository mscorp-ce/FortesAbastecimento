unit uView.FormBaseRegistration;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmBaseRegistration = class(TForm)
    pnlControl: TPanel;
    spbRestore: TSpeedButton;
    spbOK: TSpeedButton;
    spbExit: TSpeedButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure spbExitClick(Sender: TObject);
    procedure spbOKClick(Sender: TObject);
    procedure spbRestoreClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure GetProperty(); virtual; abstract;
    procedure SetProperty(); virtual; abstract;
    function Save(): Boolean; virtual; abstract;
    procedure AfterSave(); virtual; abstract;
    procedure AddFocus(); virtual; abstract;

    procedure Restore(); virtual; abstract;
    procedure DoShow(); override;
  public
    { Public declarations }
  end;

var
  frmBaseRegistration: TfrmBaseRegistration;

implementation

{$R *.dfm}

procedure TfrmBaseRegistration.DoShow();
begin
  inherited;
end;

procedure TfrmBaseRegistration.FormKeyPress(Sender: TObject; var Key: Char);
const
  ESC = #27;
  ENTER = #13;
begin
  case Key of
    ESC: Close;
    ENTER:
      begin
        Key := #0;
        Perform(WM_NEXTDLGCTL, 0, 0);
      end;
  end;
end;

procedure TfrmBaseRegistration.spbOKClick(Sender: TObject);
begin
  Save();
end;

procedure TfrmBaseRegistration.spbRestoreClick(Sender: TObject);
begin
  Restore();
end;

procedure TfrmBaseRegistration.spbExitClick(Sender: TObject);
begin
  Close();
end;

end.
