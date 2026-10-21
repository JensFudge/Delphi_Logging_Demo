unit ufrmMainLogViewer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, IPPeerServer,
  System.Tether.Manager, System.Tether.AppProfile, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    TetheringManager1: TTetheringManager;
    TetheringAppProfile1: TTetheringAppProfile;
    btnConnect: TButton;
    mmoLog: TMemo;
    procedure btnConnectClick(Sender: TObject);
    procedure TetheringManager1EndManagersDiscovery(const Sender: TObject;
      const ARemoteManagers: TTetheringManagerInfoList);
    procedure TetheringManager1PairedToRemote(const Sender: TObject;
      const AManagerInfo: TTetheringManagerInfo);
    procedure TetheringManager1EndProfilesDiscovery(const Sender: TObject;
      const ARemoteProfiles: TTetheringProfileInfoList);
    procedure TetheringAppProfile1ResourceReceived(const Sender: TObject;
      const AResource: TRemoteResource);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnConnectClick(Sender: TObject);
begin
  TetheringManager1.DiscoverManagers()
end;

procedure TForm2.TetheringAppProfile1ResourceReceived(const Sender: TObject;
  const AResource: TRemoteResource);
begin
  mmoLog.Lines.Add(AResource.Value.AsString);
end;

procedure TForm2.TetheringManager1EndManagersDiscovery(const Sender: TObject;
  const ARemoteManagers: TTetheringManagerInfoList);
begin
   for var lManager in ARemoteManagers do
     begin
       if lManager.ManagerText = 'ArcheryAppTetheringManager' then
       begin
         TetheringManager1.PairManager(lManager);
         Break;
       end;
       //Memo1.Lines.Add(lManager.ManagerText);
     end;
end;

procedure TForm2.TetheringManager1EndProfilesDiscovery(const Sender: TObject;
  const ARemoteProfiles: TTetheringProfileInfoList);
begin
  for var LProfile in ARemoteProfiles do
  begin
    if LProfile.ProfileText = 'ArcheryAppProfile' then
    begin
      if TetheringAppProfile1.Connect(LProfile) then
        self.Caption := format('%s - %s',[self.Caption, LProfile.ProfileText])
      else
        Showmessage('not connected')  ;
      Break;
    end;
  end;
end;

procedure TForm2.TetheringManager1PairedToRemote(const Sender: TObject;
  const AManagerInfo: TTetheringManagerInfo);
begin
   self.Caption := format('LogViewer - %s',[AManagerInfo.ManagerText]);
   TetheringManager1.DiscoverProfiles(aManagerInfo);


end;



end.
