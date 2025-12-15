unit uController.DataConverter.Abastecimento;

interface

uses
  System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.Abastecimento;

type
  TDataConverterAbastecimento = class(TInterfacedObject, IDataConverter<TAbastecimento>)
  public
    procedure Populate(Source: TObjectList<TAbastecimento>; Target: TDataSet);
    procedure PopulateReport(Source: TObjectList<TAbastecimento>; Target: TDataSet);

    destructor Destroy(); override;
  end;

implementation

{ TDataConverterAbastecimento }

destructor TDataConverterAbastecimento.Destroy();
begin
  inherited Destroy();
end;

procedure TDataConverterAbastecimento.Populate(Source: TObjectList<TAbastecimento>;
  Target: TDataSet);
var
  i: Integer;
begin
  Target.FieldByName('ID_ABASTECIMENTO').ReadOnly := False;

  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('ID_ABASTECIMENTO').AsInteger:= Source.Items[i].Id;
      Target.FieldByName('ID_BOMBA').AsInteger:= Source.Items[i].Bomba.Id;
      Target.FieldByName('NOME_BOMBA').AsString:= Source.Items[i].Bomba.Descricao;
      Target.FieldByName('DATA_HORA').AsDateTime:= Source.Items[i].DataHora;
      Target.FieldByName('QUANTIDADE_LITROS').AsCurrency:= Source.Items[i].QuantidadeLitros;
      Target.FieldByName('PRECO_LITRO').AsCurrency:= Source.Items[i].PrecoLitro;
      Target.FieldByName('VALOR_TOTAL').AsCurrency:= Source.Items[i].ValorTotal;
      Target.FieldByName('IMPOSTO').AsCurrency:= Source.Items[i].Imposto;
      Target.Post;
    end;
  Target.FieldByName('ID_ABASTECIMENTO').ReadOnly := True;
end;

procedure TDataConverterAbastecimento.PopulateReport(Source: TObjectList<TAbastecimento>;
  Target: TDataSet);
var
  i: Integer;
begin
  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('DIA').AsDateTime:= Source.Items[i].DataHora;
      Target.FieldByName('TANQUE').AsString:= Source.Items[i].Bomba.Tanque.Descricao;
      Target.FieldByName('NUMERO_BOMBA').AsInteger:= Source.Items[i].Bomba.Numero;
      Target.FieldByName('VALOR').AsCurrency:= Source.Items[i].ValorTotal;
      Target.Post;
    end;
end;

end.
