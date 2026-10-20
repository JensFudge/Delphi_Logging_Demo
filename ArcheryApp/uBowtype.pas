unit uBowtype;

interface

Type

  TBowType = (btNone, btLongbow, btTraditional, btBarebow, btOlympicRecurve, btCompound);

  function BowTypeToString(aBowType : TBowType) : string;

implementation

function BowTypeToString(aBowType : TBowType) : string;
begin
  case aBowType of
    btNone: Result := 'None';
    btLongbow: Result := 'Longbow';
    btTraditional: Result := 'Traditional';
    btBarebow: Result := 'Barebow';
    btOlympicRecurve: Result := 'Olympic Recurve';
    btCompound: Result := 'Compound';
  end;
end;



end.
