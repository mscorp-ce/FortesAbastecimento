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
    FPrecoLitro: Currency;
  public
    constructor Create();
    destructor Destroy; override;
    property Id: Integer read FId write FId;
    property Numero: Integer read FNumero write FNumero;
    property Descricao: string read FDescricao write FDescricao;
    property Tanque: TTanque read FTanque write FTanque;
    property PrecoLitro: Currency read FPrecoLitro write FPrecoLitro;
  end;

implementation

{ TBomba }

constructor TBomba.Create();
begin
  FTanque:= TTanque.Create();

  inherited Create();
end;

destructor TBomba.Destroy();
begin
  FTanque.Free();

  inherited Destroy();
end;

end.
