unit uModel.Entities.Tanque;

interface

type
  TTanque = class
  private
    FId: Integer;
    FDescricao: string;
    FTipoCombustivel: string;
  public
    property Id: Integer read FId write FId;
    property Descricao: string read FDescricao write FDescricao;
    property TipoCombustivel: string read FTipoCombustivel write FTipoCombustivel;
  end;

implementation

end.
