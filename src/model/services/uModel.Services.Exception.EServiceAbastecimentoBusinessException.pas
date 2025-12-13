unit uModel.Services.Exception.EServiceAbastecimentoBusinessException;

interface

uses
  System.SysUtils;

type
  EServiceAbastecimentoBusinessException = class(Exception)
  public
    constructor Create(const Msg: string); reintroduce;
  end;

implementation

{ EServiceAbastecimentoBusinessException }

constructor EServiceAbastecimentoBusinessException.Create(const Msg: string);
begin
  inherited Create('EServiceAbastecimentoBusinessException: ' + Msg);
end;

end.
