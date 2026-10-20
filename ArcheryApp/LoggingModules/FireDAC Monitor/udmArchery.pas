unit udmArchery;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.DApt,

  uArcher, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient
  ;

type
  TdmArchery = class(TDataModule)
    fdConArchery: TFDConnection;
    FDMoniRemoteClientLink1: TFDMoniRemoteClientLink;
  private
    { Private declarations }
    function GetCountryID (aCountryAbbreviation : string) : string;
  public
    { Public declarations }
    function GetArchers (aCountryAbbreviation : string = '') : TArchers;

  end;

var
  dmArchery: TdmArchery;

implementation

uses
  uBowType;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

function TdmArchery.GetArchers(aCountryAbbreviation: string): TArchers ;
begin
  var lQry := TFDQuery.Create(nil);
  result := TArchers.Create;
  try

    lQry.Connection := fdConArchery;
    lQry.SQL.Add('SELECT * FROM ARCHER A');
    if aCountryAbbreviation <> '' then
    begin
      var lCountryID := GetCountryID( aCountryAbbreviation);
      lQry.SQL.Add('LEFT JOIN COUNTRY C ON C.COUNTRYID = A.COUNTRYID');
      lQry.SQL.Add('WHERE');
      lQry.SQL.Add('C.COUNTRYID = :countryID');
      lQry.ParamByName('countryID').asString := lCountryID;
    end;
    lQry.Open;
    while not lQry.eof  do
    begin
      var lArcher := TArcher.Create;
      lArcher.ArcherID := StringToGuid( lQry.FieldByName('ARCHERID').AsString);
      lArcher.ArcherName := lQry.FieldByName('ARCHERNAME').AsString;
      lArcher.BowType := TBowType(lQry.FieldByName('BOWTYPE').AsInteger);
      if not lQry.FieldByName('COUNTRYID').IsNull then
      begin
        lArcher.CountryID.Value := StringToGuid(lQry.FieldByName('COUNTRYID').asString);
        lArcher.CountryName.Value := lQry.FieldByName('COUNTRYNAME').asString;
        lArcher.CountryAbbreviation.Value := lQry.FieldByName('COUNTRYABBREVIATION').asString;
      end;
      result.Add(lArcher);
      lQry.next;
    end;
  finally
    lQry.Free;
  end;
end;

function TdmArchery.GetCountryID(aCountryAbbreviation: string): string;
begin
  var lQry := TFDQuery.Create(nil);
  try
    lQry.Connection := fdConArchery;
    lQry.SQL.Add('SELECT * FROM COUNTRY');
    lQry.SQL.Add('WHERE');
    lQry.SQL.Add('COUNTRYABBREVIATION = :countryAbb');
    lQry.ParamByName('countryAbb').AsString :=  aCountryAbbreviation;
    lQry.Open;
    if not lQry.IsEmpty then
      result := lQry.FieldByName('COUNTRYID').AsString;
  finally
    lQry.Free;
  end;
end;

end.
