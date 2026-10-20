unit uArcher;

interface

uses
  uBowType, Bcl.Types.Nullable, system.Generics.Collections;

Type

  TArcher = class(TObject)
    private
    fCountryID: Nullable<TGUID>;
    fArcherName: string;
    fBowType: TBowType;
    fArcherID: TGUID;
    fCountryName: Nullable<String>;
    fCountryAbbreviation: Nullable<String>;
    public
    property ArcherID : TGUID read fArcherID write fArcherID;
    property ArcherName : string read fArcherName write fArcherName;
    property BowType : TBowType read fBowType write fBowType;
    property CountryID : Nullable<TGUID> read fCountryID write fCountryID;
    property CountryName : Nullable<String> read fCountryName write fCountryName;
    property CountryAbbreviation : Nullable<String> read fCountryAbbreviation write fCountryAbbreviation;

    procedure Assign(aSource : TArcher);
    function Clone : TArcher;

  end;

  TArchers = class(TObjectList<TArcher>)
    public
      procedure Assign(aSource : TArchers);
  end;

  TUpdateArcherDTO = class(TObject)
    ArcherName : string;
    BowType : TBowType;
    CountryAbbreviation : Nullable<string>;
  end;

implementation

{ TArcher }

procedure TArcher.Assign(aSource: TArcher);
begin
  self.ArcherID := aSource.ArcherID;
  self.ArcherName := aSource.ArcherName;
  self.BowType := aSource.BowType;
  self.CountryID := aSource.CountryID;
  self.CountryName := aSource.CountryName;
  self.CountryAbbreviation := aSource.CountryAbbreviation;
end;

function TArcher.Clone: TArcher;
begin
  Result := TArcher.Create;
  Result.Assign(self);
end;

{ TArchers }

procedure TArchers.Assign(aSource: TArchers);
begin
  self.Clear;
  for var lArcher in aSource do
    Add(lArcher.Clone);
end;

end.
