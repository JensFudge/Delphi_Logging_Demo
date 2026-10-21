program ArcheryApp;

uses
  Vcl.Forms,
  ufrmMain in 'ufrmMain.pas' {Form1},
  udmArchery in 'udmArchery.pas' {dmArchery: TDataModule},
  uArcher in 'uArcher.pas',
  uBowtype in 'uBowtype.pas',
  uCountry in 'uCountry.pas',
  TMSLoggingTetheringOutputHandler in 'TMSLoggingTetheringOutputHandler.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmArchery, dmArchery);
  Application.Run;
end.
