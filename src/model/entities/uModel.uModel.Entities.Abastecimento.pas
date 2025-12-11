unit uModel.uModel.Entities.Abastecimento;

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
    FValorTotal: Currency;
    function GetImposto: Currency;
  public
    constructor Create(AValorTotal: Currency);
    property Id: Integer read FId write FId;
    property Bomba: TBomba read FBomba write FBomba;
    property DataHora: TDateTime read FDataHora write FDataHora;
    property QuantidadeLitros: Double read FQuantidadeLitros write FQuantidadeLitros;
    property ValorTotal: Currency read FValorTotal write FValorTotal;
    property Imposto: Currency read GetImposto;
  end;

implementation

{ TAbastecimento }

uses
  System.Math;

constructor TAbastecimento.Create(AValorTotal: Currency);
begin
  inherited Create;
  if AValorTotal <= 0 then
    raise Exception.Create('Valor total deve ser maior que zero.');
  FValorTotal := AValorTotal;
end;

function TAbastecimento.GetImposto: Currency;
begin
  Result := RoundTo(FValorTotal * 0.13, -2);
end;

end.
