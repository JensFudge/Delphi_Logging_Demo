object dmArchery: TdmArchery
  Height = 480
  Width = 640
  object fdConArchery: TFDConnection
    Params.Strings = (
      
        'Database=C:\Data\Demo projects\Delphi_Logging_Demo\ArcheryApp\AR' +
        'CHERYSYSTEM.GDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'MonitorBy=Remote'
      'DriverID=IB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    Tracing = True
    Left = 384
    Top = 128
  end
end
