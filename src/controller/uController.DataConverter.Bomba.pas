unit uController.DataConverter.Bomba;

interface

uses
  System.Generics.Collections, Data.DB, uModel.Abstraction, uModel.Entities.Bomba;

type
  TDataConverterBomba = class(TInterfacedObject, IDataConverter<TBomba>)
  public
    procedure Populate(Source: TObjectList<TBomba>; Target: TDataSet);

    destructor Destroy(); override;
  end;

implementation

{ TDataConverterBomba }

destructor TDataConverterBomba.Destroy();
begin
  inherited Destroy();
end;

procedure TDataConverterBomba.Populate(Source: TObjectList<TBomba>;
  Target: TDataSet);
var
  i: Integer;
begin
  Target.FieldByName('ID_BOMBA').ReadOnly := False;

  for i:= 0 to Source.Count -1 do
    begin
      Target.Append;
      Target.FieldByName('ID_BOMBA').AsInteger:= Source.Items[i].Id;
      Target.FieldByName('ID_TANQUE').AsInteger:= Source.Items[i].Tanque.Id;
      Target.FieldByName('NUMERO_BOMBA').AsInteger:= Source.Items[i].Numero;
      Target.FieldByName('DESCRICAO').AsString:= Source.Items[i].Descricao;
      Target.FieldByName('PRECO_LITRO').AsCurrency:= Source.Items[i].PrecoLitro;
      Target.Post;
    end;
  Target.FieldByName('ID_BOMBA').ReadOnly := True;
end;

end.
