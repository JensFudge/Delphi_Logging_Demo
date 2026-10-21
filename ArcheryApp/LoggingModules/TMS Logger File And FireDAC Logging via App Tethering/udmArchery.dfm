object dmArchery: TdmArchery
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object fdConArchery: TFDConnection
    Params.Strings = (
      
        'Database=C:\Data\Demo projects\Delphi_Logging_Demo\ArcheryApp\AR' +
        'CHERYSYSTEM.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'MonitorBy=Custom'
      'DriverID=IB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    OnOutput = FDMoniCustomClientLink1Output
    Tracing = True
    Left = 288
    Top = 120
  end
  object TetheringAppProfile1: TTetheringAppProfile
    Manager = TetheringManager1
    Text = 'ArcheryAppProfile'
    OnAfterConnectProfile = TetheringAppProfile1AfterConnectProfile
    Actions = <>
    Resources = <>
    Left = 472
    Top = 144
  end
  object TetheringManager1: TTetheringManager
    Text = 'ArcheryAppTetheringManager'
    AllowedAdapters = 'Network'
    Left = 472
    Top = 224
  end
end
