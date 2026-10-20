object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'My Archery App'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object btnGetArchers: TButton
    Left = 24
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Get Archers'
    TabOrder = 0
    OnClick = btnGetArchersClick
  end
  object lvArchers: TListView
    Left = 24
    Top = 88
    Width = 513
    Height = 241
    Columns = <
      item
        Caption = 'Name'
      end
      item
        Caption = 'Country'
      end>
    TabOrder = 1
    ViewStyle = vsReport
  end
  object Edit1: TEdit
    Left = 120
    Top = 33
    Width = 121
    Height = 23
    TabOrder = 2
    Text = 'DEN'
    TextHint = 'Country Abbreviation'
  end
end
