unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnGetArchers: TButton;
    lvArchers: TListView;
    Edit1: TEdit;
    procedure btnGetArchersClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  udmArchery;

{$R *.dfm}



procedure TForm1.btnGetArchersClick(Sender: TObject);
begin
 var lArchers :=   dmArchery.GetArchers(Edit1.Text);
 try
   lvArchers.Clear;
   for var lArcher in lArchers do
     begin
       var lItem := lvArchers.Items.Add;
       lItem.Caption := lArcher.ArcherName;
       lItem.SubItems.Add(lArcher.CountryName.ValueOrDefault);
     end;
 finally
   lArchers.Free;
 end;
end;

end.
