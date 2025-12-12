unit uView.FormConsult;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, Datasnap.DBClient;

type
  TfrmConsult = class(TForm)
    pnlControl: TPanel;
    sbpFilter: TSpeedButton;
    spbAll: TSpeedButton;
    spbInclude: TSpeedButton;
    spbAlter: TSpeedButton;
    spbDelete: TSpeedButton;
    spbExit: TSpeedButton;
    grdConsult: TDBGrid;
    dsConsult: TDataSource;
    cdsConsult: TClientDataSet;
    procedure sbpFilterClick(Sender: TObject);
    procedure spbAllClick(Sender: TObject);
    procedure spbIncludeClick(Sender: TObject);
    procedure spbAlterClick(Sender: TObject);
    procedure spbDeleteClick(Sender: TObject);
    procedure spbExitClick(Sender: TObject);
  private
    { Private declarations }
  protected
    { Protected declarations }
    procedure Filter(); virtual; abstract;
    procedure All(); virtual; abstract;
    procedure Include(); virtual; abstract;
    procedure Alter(); virtual; abstract;
    procedure Delete(); virtual; abstract;
    procedure Consult(); virtual; abstract;
  public
    { Public declarations }
  end;

var
  frmConsult: TfrmConsult;

implementation

{$R *.dfm}

procedure TfrmConsult.sbpFilterClick(Sender: TObject);
begin
  Filter();
end;

procedure TfrmConsult.spbAlterClick(Sender: TObject);
begin
  Alter();
end;

procedure TfrmConsult.spbDeleteClick(Sender: TObject);
begin
  Delete();
end;

procedure TfrmConsult.spbIncludeClick(Sender: TObject);
begin
  Include();
end;

procedure TfrmConsult.spbExitClick(Sender: TObject);
begin
  Close();
end;

procedure TfrmConsult.spbAllClick(Sender: TObject);
begin
  All();
end;

end.
