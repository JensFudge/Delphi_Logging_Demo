unit uCountry;

interface

uses
  uArcher;

Type
  TCountry = class(TObject)
    private
    fCountryID: TGUID;
    fCountryName: string;
    fCountryAbbreviation: string;
    public
    property CountryName : string read fCountryName write fCountryName;
    property CountryAbbreviation : string read fCountryAbbreviation write fCountryAbbreviation;
    property CountryID : TGUID read fCountryID write fCountryID;
  end;

  TCountryArchersDTO = class
  private
    FCountry: TCountry;
    FArchers: TArchers;
  public
    property Country: TCountry read FCountry write FCountry;
    property Archers: TArchers read FArchers write FArchers;
  end;

implementation

end.
