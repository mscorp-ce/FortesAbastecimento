unit uModel.Entities.Bomba;

interface

uses
  uModel.Entities.Tanque;

type
  TBomba = class
  private
    FId: Integer;
    FNumero: Integer;
    FDescricao: string;
    FTanque: TTanque;
  public
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Numero: Integer read FNumero write FNumero;
    property Descricao: string read FDescricao write FDescricao;
    property Tanque: TTanque read FTanque write FTanque;
  end;

implementation

{ TBomba }

destructor TBomba.Destroy;
begin
  FTanque.Free;

  inherited;
end;

end.
