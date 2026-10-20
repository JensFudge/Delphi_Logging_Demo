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
      'DriverID=IB')
    LoginPrompt = False
    Left = 304
    Top = 224
  end
  object FDMoniCustomClientLink1: TFDMoniCustomClientLink
    Left = 288
    Top = 120
  end
end
