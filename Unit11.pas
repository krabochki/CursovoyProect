unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, JPEG, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TAliensPuzzle = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N221: TMenuItem;
    N441: TMenuItem;
    N881: TMenuItem;
    N1611: TMenuItem;
    Timer1: TTimer;
    N5: TMenuItem;
    N551: TMenuItem;
    Button1: TButton;
    procedure N3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N221Click(Sender: TObject);
    procedure N441Click(Sender: TObject);
    procedure N881Click(Sender: TObject);
    procedure N1611Click(Sender: TObject);
    procedure N32321Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N551Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  alienspuzzle: Talienspuzzle;
  open:TJPEGImage;
  Pazl:array[1..1024] of Tbitmap;
  kopia,pole:array[0..31,0..31] of integer;
  path:string;
  razmer,xx,yy,aktiv,score:Integer;
  buf,original:TBitmap;
  rez:tmodalresult;

  procedure pazlgo;

  procedure setka(cellx,celly,mx,my,razmerx,razmery,tolshina:integer;setkacolor:tcolor;buf:tbitmap);
 //game:BOOlean;\
  implementation

{$R *.dfm}

uses Unit3, Unit9, Unit8, Unit10, Unit16;

procedure TAliensPuzzle.FormActivate(Sender: TObject);
begin
if unit16.number=1 then open.LoadFromFile('????????????\?????\1c.jpg');
if unit16.number=2 then open.LoadFromFile('????????????\?????\2c.jpg');
if unit16.number=3 then open.LoadFromFile('????????????\?????\3c.jpg');
if unit16.number=4 then open.LoadFromFile('????????????\?????\4c.jpg');
if unit16.number=5 then open.LoadFromFile('????????????\?????\5c.jpg');
if unit16.number=6 then open.LoadFromFile('????????????\?????\6c.jpg');
original.Canvas.StretchDraw(Rect(0,0,800,800),open);
pazlgo;
Timer1.Enabled:=true;
end;

procedure TAliensPuzzle.FormCreate(Sender: TObject);
var i,j:integer;
begin
score:=0;
alienspuzzle.Cursor:=1;
Screen.MenuFont.Name := 'Fifaks 1.0 dev1'; //????????? ?????? ? ???? ?????
Screen.MenuFont.size := 12; //????????? ??????? ?????? ? ???? ?????
path:=ExtractFileDir(Application.ExeName);
buf:=Tbitmap.Create;
buf.Width:=1600;
buf.Height:=1600;
open:=tjpegimage.Create;
open.LoadFromFile(path+'\puzzles\bender.jpg');
original:=tbitmap.Create;
original.Width:=800;
original.Height:=800;
original.Canvas.StretchDraw(Rect(0,0,800,800),open);
for i:=0 to 31 do
for j:=0 to 31 do
begin
kopia[i,j]:=0;
pole[i,j]:=0;
end;
razmer:=4;
aktiv:=0;
pazlgo;
end;

procedure TAliensPuzzle.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var uzhe:Boolean; i,j:Integer;
begin

if (Button=mbright) and (aktiv>0) then
     begin
       uzhe:=false;
       for i:=0 to razmer-1 do
         for j:=0 to razmer-1 do
           if (uzhe=False) and (kopia[i,j]=0) then
             begin
               uzhe:=true;
               kopia[i,j]:=aktiv;
               aktiv:=0;
             end;
     end
  else
  begin
  uzhe:=False;
    if   (x>=800) and (x<=1600) and (y>=0) and (y<=800) then
    begin
      if (kopia[(x-800) div xx,y div yy]>0) and(aktiv=0) then
      begin
        aktiv:=kopia[(x-800) div xx,y div yy];
      kopia[(x-800) div xx,y div yy]:=0;

    uzhe:=true;
      end;
     if (kopia[(x-800) div xx,y div yy]=0) and(aktiv>0) and (uzhe=False) then
      begin

      kopia[(x-800) div xx,y div yy]:=aktiv;
      aktiv:=0;
      end;
    end;

         //sleva
    if   (x>=0) and (x<=800) and (y>=0) and (y<=800) then
    begin
      if (pole[x div xx,y div yy]>0) and(aktiv=0) then
      begin
      aktiv:=pole[x div xx,y div yy];
      pole[x div xx,y div yy]:=0;

    uzhe:=true;
      end;
     if (pole[x div xx,y div yy]=0) and(aktiv>0) and (uzhe=False) then
      begin

      pole[x div xx,y div yy]:=aktiv;
      aktiv:=0;
      end;
    end;
   end;


end;

procedure TAliensPuzzle.N1611Click(Sender: TObject);
begin
razmer:=10;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.N221Click(Sender: TObject);
begin
razmer:=2;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.N2Click(Sender: TObject);
begin
alienspuzzle.Close;
puzzleopen.Close;

end;

procedure TAliensPuzzle.N32321Click(Sender: TObject);
begin
razmer:=32;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.N3Click(Sender: TObject);
begin
AliensPuzzle.Close;
end;

procedure TAliensPuzzle.N441Click(Sender: TObject);
begin
razmer:=4;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.N551Click(Sender: TObject);
begin
razmer:=5;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.N5Click(Sender: TObject);
begin
form3.show;
alienspuzzle.Close;
puzzleopen.close;
aliens.hide;
planets.hide;
theories.hide;


end;

procedure TAliensPuzzle.N881Click(Sender: TObject);
begin
razmer:=8;
pazlgo;
Timer1.enabled:=True;
end;

procedure TAliensPuzzle.Timer1Timer(Sender: TObject);
var i,j,n,tolshina,mx,my:Integer;
setkacolor:tcolor;    vin:Boolean;
begin

vin:=true;
n:=1;
for i:=0 to razmer-1 do
for j:=0 to razmer-1 do
begin
  if pole [i,j]<>n then vin:=False;
  n:=n+1;
  end;
  if vin=true then begin
  score:=score+1;
  Timer1.Enabled:=false;

   ShowMessage('??????????! ?? ?????? ?????! ???? ????: '+inttostr(score));
   alienspuzzle.Close;

   end;


  buf.Canvas.Brush.color:=$00BC589E;
  buf.Canvas.Rectangle(0,0,1600,1600);
for i:=0 to razmer-1 do
for j:=0 to razmer-1 do    begin
if pole[i,j]>0 then buf.Canvas.draw(i*xx,j*yy,pazl[pole[i,j]]);
if kopia[i,j]>0 then buf.Canvas.draw(i*XX+800,j*YY,pazl[kopia[i,j]]);
end;
tolshina:=1;
setkacolor:=clBlack;
my:=0;
mx:=0;
setka(xx,yy,mx,my,razmer,razmer,tolshina,setkacolor,buf);
mx:=800;
setka(xx,yy,mx,my,razmer,razmer,tolshina,setkacolor,buf);

if aktiv>0 then buf.Canvas.Draw(Mouse.CursorPos.X-alienspuzzle.left-(xx div 2),Mouse.CursorPos.Y-alienspuzzle.top-25-(yy div 2),pazl[aktiv]);
alienspuzzle.Canvas.Draw(0,0,buf);
end;


procedure pazlgo;
var i,n,j:Integer;
begin
for i:=0 to 31 do
for j:=0 to 31 do
begin
kopia[i,j]:=0;
pole[i,j]:=0;
//for i:=1 to 1600 d0
//Pazl[i]:=
end;
case razmer of
2:  begin xx:=400; yy:=400; end;
4:  begin xx:=200; yy:=200;  end;
5:  begin xx:=160; yy:=160;  end;
8:  begin xx:=100;  yy:=100;  end;
10: begin xx:=80; yy:=80;    end;
end;
n:=1;
for i:=0 to razmer-1 do
for j:=0 to razmer-1 do
begin   Pazl[n]:=tbitmap.create;
  Pazl[n].width:=xx;
  pazl[n].Height:=yy;
  Pazl[n].canvas.copyrect(rect(0,0,xx,yy),original.Canvas,rect(i*xx,j*yy,i*xx+xx-i,j*yy+yy-1))  ;
n:=n+1;
  end;
  n:=1;
  randomize;
  while(n<=razmer*razmer) do
  begin
    i:=Random(razmer);
    j:=Random(razmer);
    if kopia[i,j]=0 then
    begin
      kopia[i,j]:=n;
      n:=n+1;
      end;
    end;
  end;
   procedure setka(cellx,celly,mx,my,razmerx,razmery,tolshina:integer;setkacolor:tcolor;buf:tbitmap);
   var i:integer;
   begin
     buf.canvas.pen.color:=setkacolor;
     buf.canvas.pen.width:=tolshina;
     for i:=0 to razmery do
     begin
       buf.canvas.moveto(0+mx,i*celly+my);
       buf.canvas.lineto(razmerx*cellx+mx,i*celly+my);
     end;
     for i:=0 to razmerx  do
      begin
       buf.canvas.moveto(i*cellx+mx,0+my);
       buf.canvas.lineto(i*cellx+mx,razmery*celly+my);
     end;
   end;

end.
