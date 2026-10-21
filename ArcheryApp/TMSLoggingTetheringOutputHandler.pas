unit TMSLoggingTetheringOutputHandler;


interface

uses
  TMSLoggingCore, TMSLoggingUtils,
  System.Tether.AppProfile,
  System.Tether.Manager
  ;

type
  TTMSLoggingTetheringOutputHandler = class(TTMSLoggerBaseOutputHandler)
  private
   class var FProfile: TTetheringAppProfile;
  protected
   procedure LogOutput(const AOutputInformation: TTMSLoggerOutputInformation); override;
  public
    constructor Create;  override;
    class property Profile : TTetheringAppProfile read FProfile write FProfile;
  end;

implementation

uses
  Classes;

{ TTMSLoggerTextOutputHandler }

constructor TTMSLoggingTetheringOutputHandler.Create;
begin
  inherited Create;
  StripHtml := True;
end;


procedure TTMSLoggingTetheringOutputHandler.LogOutput(
  const AOutputInformation: TTMSLoggerOutputInformation);
begin
  inherited;
  if not Assigned(FProfile) then
    Exit;

  var LMessage := TTMSLoggerUtils.GetConcatenatedLogMessage(
    AOutputInformation);

  for var LProfile in FProfile.ConnectedProfiles do
    FProfile.SendString(LProfile, 'log', LMessage);
end;

initialization
  RegisterClasses([TTMSLoggingTetheringOutputHandler]);

end.
