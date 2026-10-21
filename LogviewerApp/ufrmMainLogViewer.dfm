object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Log Viewer'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  DesignSize = (
    624
    441)
  TextHeight = 15
  object btnConnect: TButton
    Left = 40
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object mmoLog: TMemo
    Left = 40
    Top = 56
    Width = 529
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object TetheringManager1: TTetheringManager
    OnEndManagersDiscovery = TetheringManager1EndManagersDiscovery
    OnEndProfilesDiscovery = TetheringManager1EndProfilesDiscovery
    OnPairedToRemote = TetheringManager1PairedToRemote
    Text = 'LogViewerManager'
    AllowedAdapters = 'Network'
    Left = 384
    Top = 104
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'LogViewerProfile'
    Actions = <>
    Resources = <>
    OnResourceReceived = TetheringAppProfile1ResourceReceived
    Left = 248
    Top = 88
  end
end
