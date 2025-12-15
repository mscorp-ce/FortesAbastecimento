unit uModel.Entities.Abastecimento;

interface

uses
  System.SysUtils, System.Generics.Collections, uModel.Entities.Bomba;

type
  TAbastecimento = class
  private
    FId: Integer;
    FBomba: TBomba;
    FDataHora: TDateTime;
    FQuantidadeLitros: Double;
    FPrecoLitro: Currency;
    FValorTotal: Currency;
    FImposto: Currency;
  public
    constructor Create();
    destructor Destroy(); override;

    function GetImposto: Currency;

    property Id: Integer read FId write FId;
    property Bomba: TBomba read FBomba write FBomba;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property QuantidadeLitros: Double read FQuantidadeLitros write FQuantidadeLitros;
    property PrecoLitro: Currency read FPrecoLitro write FPrecoLitro;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property Imposto: Currency read GetImposto write FImposto;
  end;

implementation

{ TAbastecimento }

uses
  System.Math;

constructor TAbastecimento.Create();
begin
  inherited Create();

  FBomba := TBomba.Create();
end;

destructor TAbastecimento.Destroy();
begin
  FBomba.Free();

  inherited Destroy();
end;

function TAbastecimento.GetImposto: Currency;
begin
  Result := RoundTo(FValorTotal * 0.13, -2);
end;

end.
