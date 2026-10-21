unit udmArchery;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.DApt,

  uArcher, FireDAC.Moni.Base, FireDAC.Moni.RemoteClient, FireDAC.Moni.Custom,

  TMSLogging,
  TMSLoggingCore,
  TMSLoggingTextOutputHandler
  ;

type
  TdmArchery = class(TDataModule)
    fdConArchery: TFDConnection;
    FDMoniCustomClientLink1: TFDMoniCustomClientLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure FDMoniCustomClientLink1Output(ASender: TFDMoniClientLinkBase;
      const AClassName, AObjName, AMessage: string);
  private
    { Private declarations }
    function GetCountryID (aCountryAbbreviation : string) : string;
    procedure BeforeOpen (aDataset : TDataset);
    procedure BeforeClose(aDataset : TDataset);
    procedure AfterOpen(aDataset : TDataset);
    procedure AfterClose(aDataset : TDataset);

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

procedure TdmArchery.AfterClose(aDataset: TDataset);
begin
  TMSLogger.Info('The dataset was closed');
end;

procedure TdmArchery.AfterOpen(aDataset: TDataset);
begin
  TMSLogger.Info('The dataset was opened');
end;

procedure TdmArchery.BeforeClose(aDataset: TDataset);
begin
  TMSLogger.Info('The dataset will close');
end;

procedure TdmArchery.BeforeOpen(aDataset: TDataset);
begin
  TMSLogger.Info('The dataset will open');
end;

procedure TdmArchery.DataModuleCreate(Sender: TObject);
begin
  TMSLogger.RegisterOutputHandlerClass(
  TTMSLoggerTextOutputHandler,
  ['DemoApp.log']
   );

  TMSLogger.Info('Application Started');

end;

procedure TdmArchery.FDMoniCustomClientLink1Output(
  ASender: TFDMoniClientLinkBase; const AClassName, AObjName, AMessage: string);
begin
  TMSLogger.Debug(Format('FireDAC [%s.%s] %s', [AClassName, AObjName, AMessage] ));
end;

function TdmArchery.GetArchers(aCountryAbbreviation: string): TArchers ;
begin
  var lQry := TFDQuery.Create(nil);
  result := TArchers.Create;
  try
    lQry.BeforeOpen := BeforeOpen;
    lQry.AfterOpen := AfterOpen;
    lQry.BeforeClose := BeforeClose;
    lQry.AfterClose := AfterClose;
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
    TMSLogger.Info(format('There are %d records for country %s', [lQry.RecordCount, aCountryAbbreviation]) );
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
    lQry.Close;
  finally
    lQry.Free;
  end;
end;

function TdmArchery.GetCountryID(aCountryAbbreviation: string): string;
begin
  TMSLogger.Info(Format('GetCountryID called with %s',[aCountryAbbreviation]));
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
