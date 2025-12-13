unit uView.CustomFormFilterAbastecimento;

interface

uses
  System.Classes, uView.FormFilters, System.Generics.Collections, uModel.Abstraction,
  uController.RootAbastecimento, uModel.Entities.Abastecimento;
type
  TCustomFormFilterAbastecimento = class(TfrmFiltros)
  private
    ControllerRootAbastecimento: IRootController<TAbastecimento>;
  protected
    { Protected declarations }
    procedure DoShow; override;
  public
    constructor Create; reintroduce;
  end;

implementation

uses
  System.SysUtils;

{ TCustomFormFilterAbastecimento }

constructor TCustomFormFilterAbastecimento.Create;
begin
  inherited Create(nil);

  ControllerRootAbastecimento := TControllerRootAbastecimento.Create;
end;

procedure TCustomFormFilterAbastecimento.DoShow;
var
  Items: TStrings;
begin
  inherited;

  try
    Items:= ControllerRootAbastecimento.Fields;

    Self.cbxFields.Items.AddStrings( Items );

    Self.cbxOrder.Items.AddStrings( Items );
    Self.cbxOrder.ItemIndex:= 0;
  finally
    FreeAndNil(Items);
  end;
end;

end.
