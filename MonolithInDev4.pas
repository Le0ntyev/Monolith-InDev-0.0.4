uses graphABC;

const
  dlin: integer = 30;

const
  dvig: integer = 650;

const
  vist: integer = 20;
  
const
  vdvig: integer = 400;
  
const
  yam: integer = 2;
  
const
  drev: integer = 3;

var
  a: array [1..dlin] of array[1..vist]of integer;
  
var
  inv_name: array [1..30] of integer;
  
var
  inv_number: array [1..30] of integer;

var
  tch: array [1..8] of integer;
  {
  tch[1] tch[2] tch[3]
  tch[4] person tch[5]
  tch[6] tch[7] tch[8]
  }

var
  map, you, air, tree, wood, dert, dertz, stone: picture;

var
  x, y, xold, gutx, guty, down, up, left, right, gm, otl, otll, gmm: integer;


procedure KeyDown(Key: integer);
begin
  case Key of
    VK_Left: left := 1;
    VK_Right: right := 1;
    VK_Up: up := 1;
    VK_Down: down := 1;
    VK_A: left := 1;
    VK_D: right := 1;
    VK_W: up := 1;
    VK_S: down := 1;
    VK_O: otll:=1;
    VK_P: gmm:=1;
  end;
end;

procedure MouseDown(mmx,mmy,mb: integer);
begin
  if ((mmx+x) div 100 > x-2) and ((mmx+x) div 100 < x+2) and ((mmy+y) div 100 > y-2) and ((mmy+y) div 100 < y+2) and (mb=1) then
    a[(mmx+x) div 100][(mmy+y) div 100]:=0;
end;

procedure block(xb: integer; yb: integer);{прогрузка одного блока}
begin
  if a[xb][yb] = 0 then
    air.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig);
  if a[xb][yb] = -1 then
    tree.draw(((xb - 1 - 1) * 100) + dvig - x, ((yb - 3) * 100) - y + vdvig);
  if a[xb][yb] = 2 then
    wood.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig);
  if a[xb][yb] = 3 then
    stone.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig);
  if a[xb][yb] = 4 then
  begin
    if yb > 1 then
    begin
      if a[xb][yb - 1] = 0 then
        dertz.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig)
      else
        dert.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig);
    end
    else
     begin
      dert.draw(((xb - 1) * 100) + dvig - x, ((yb - 1) * 100) - y + vdvig);
     end;
  end;
end;

procedure fall;
begin
  if (gutx < 2) or (gutx > dlin - 1) or (guty < 2) or (guty > vist - 1)  then
  begin
    tch[1] := 1;
    tch[2] := 0;
    tch[3] := 1;
    tch[4] := 0;
    tch[5] := 0;
    tch[6] := 1;
    tch[7] := 0;
    tch[8] := 1;
  end
  else
  begin
    if a[gutx - 1][guty - 1] > 0 then
    begin
      tch[1] := 1;
    end
    else
    begin
      tch[1] := 0;
    end;
    
    if a[gutx][guty - 1] > 0 then
    begin
      tch[2] := 1;
    end
    else
    begin
      tch[2] := 0;
    end;
    
    if a[gutx + 1][guty - 1] > 0 then
    begin
      tch[3] := 1;
    end
    else
    begin
      tch[3] := 0;
    end;
    if a[gutx - 1][guty] > 0 then
    begin
      tch[4] := 1;
    end
    else
    begin
      tch[4] := 0;
    end;
    
    if a[gutx + 1][guty] > 0 then
    begin
      tch[5] := 1;
    end
    else
    begin
      tch[5] := 0;
    end;
    
    if a[gutx - 1][guty + 1] > 0 then
    begin
      tch[6] := 1;
    end
    else
    begin
      tch[6] := 0;
    end;
    
    if a[gutx][guty + 1] > 0 then
    begin
      tch[7] := 1;
    end
    else
    begin
      tch[7] := 0;
    end;
    
    if a[gutx + 1][guty + 1] > 0 then
    begin
      tch[8] := 1;
    end
    else
    begin
      tch[8] := 0;
    end;
    
  end;
  if tch[1] + tch[2] + tch[3] + tch[4] + tch[5] + tch[6] + tch[7] + tch[8] = 0 then
  begin
    y += 100;
  end;
end;

procedure downn;
begin
  if tch[7] = 0 then
  begin
    y := y + 100;
    sleep(300);
  end;
  down := 0;
end;

procedure upp;
begin
  if tch[2] = 0 then
  begin
    y := y - 100;
    sleep(300);
  end;
  up := 0;
end;

procedure allbigblock();
begin
  var i: integer;
  var j: integer;
  i := 1;
  j := 1;
  while i <= dlin do {прогрузка блоков больше 100x100}
  begin
    while j <= vist do
    begin
      if a[i][j] = -1 then
        tree.draw(((i - 1 - 1) * 100) + dvig - x, ((j - 3) * 100) - y + vdvig);
      j += 1;
    end;
    j := 1;
    i += 1;
  end;
end;

procedure exp;{расстановка блоков}
begin
  a[1][1] := 4;
end;

procedure derten;
begin
  var i: integer;
  var j: integer;
  i := 1;
  j := 1;
  while i <= dlin do {генерация земли}
  begin
    while j <= vist - 5 do
    begin
      a[i][j + 5] := 4;
      j += 1;
    end;
    j := 1;
    i += 1;
  end;
  i := 1;
  j := 1;
  while i <= dlin do {верхний слой земли}
  begin
    if random(yam) = 1 then
      begin
      a[i][6] := 0;
      end;
    i += 1;
  end;
  i := 3;
  j := 1;
  while i <= dlin-3 do {деревья}
  begin
    if {(random(drev) = 0) and }(a[i][6]=4) and not (a[i-2][5]=-1) and not (a[i-1][5]=-1) and not (a[i+2][5]=-1) and not (a[i+1][5]=-1) then
      begin
      a[i][5] := -1;
      end;
    i += 1;
  end;
  i := 1;
  j := 1;
  while i <= dlin do {верхний слой камня}
  begin
    if random(2) = 1 then
      begin
      a[i][9] := 3;
      end;
    i += 1;
  end;
  i := 1;
  j := 1;
  while i <= dlin do {генерация камня}
  begin
    while j <= vist - 9 do
    begin
      a[i][j + 9] := 3;
      j += 1;
    end;
    j := 1;
    i += 1;
  end;
end;

procedure leftt;
begin
  if tch[4] = 0 then
  begin
    x := x - 100;
    sleep(300);
  end;
  left := 0;
end;

procedure rightt;
begin
  if tch[5] = 0 then
  begin
    x := x + 100;
    sleep(300);
  end;
  right := 0;
end;

procedure all_block;
begin
  var i: integer;
  var j: integer;
  i := 1;
  j := 1;
  while i <= dlin do {прогрузка блоков}
  begin
    while j <= vist do
    begin
      block(i, j);
      j += 1;
    end;
    j := 1;
    i += 1;
  end;
  allbigblock;
end;

procedure start;{объявление переменных}
begin
  OnKeyDown := KeyDown;
  OnMouseDown := MouseDown;
  MaximizeWindow;
  map := Picture.Create('t.jpg');
  you := Picture.Create('Pers.bmp');
  air := Picture.Create('block/air.bmp');
  tree := Picture.Create('block/tree3x3.bmp');
  wood := Picture.Create('block/wood.bmp');
  stone := Picture.Create('block/stone.bmp');
  dert := Picture.Create('block/dert.bmp');
  dertz := Picture.Create('block/dertz.bmp');
  SetWindowTitle('Monolith vInDev | By PLT studios');
  y := 400;
  x := (dlin div 2) * 100;
  gutx := (x div 100) + 1;
  guty := (y div 100) + 1;
end;

procedure otld;{f3}
begin
  textout(10, 10, x); {икс удобный для карты}
  textout(10, 50, gutx); {наш икс}
  textout(10, 100, y); {игрек удобный для карты}
  textout(10, 150, guty); {наш игрек}
  textout(300, 100, tch[1]);
  textout(330, 100, tch[2]);
  textout(360, 100, tch[3]);
  textout(300, 130, tch[4]);
  textout(360, 130, tch[5]);
  textout(300, 160, tch[6]);
  textout(330, 160, tch[7]);
  textout(360, 160, tch[8]);
end;


begin
  start;
  derten;
  exp;
  map.Draw(1,1);
  sleep(2000);
  map := Picture.Create('Map.jpg');
  while(true) do
  begin
    if gutx < 2 then
    begin
      x := 100;
    end;
    if gutx > dlin-2 then
    begin
      x := (dlin - 2) * 100;
    end;
    if guty < 2 then
    begin
      y := 100;
    end;
    if guty > vist-2 then
    begin
      y := (vist - 2) * 100;
    end;
    map.Draw(1, 1, 2000, 800);
    all_block;
    if xold < x then
    begin
      you := Picture.Create('Pers.bmp');
    end
    else
    begin
      you := Picture.Create('PersR.bmp');
    end;
    you.Draw(dvig, vdvig);
    if otl = 1 then
      begin
      otld;
      end;
    xold := x;
    while(true) do
    begin
      sleep(100);
      if left = 1 then
        begin
        leftt;
        break;
        end;
      if right = 1 then
        begin
        rightt;
        break;
        end;
      if up = 1 then
        begin
        upp;
        break;
        end;
      if down = 1 then
        begin
        downn;
        break;
        end;
      if otll = 1 then
        begin
        if otl=0 then
          otl := 1
        else
          otl := 0;
        otll := 0;
        break;
        end;
      if gmm = 1 then
        begin
        if gm=0 then
          gm := 1
        else
          gm := 0;
        gmm := 0;
        break;
        end;
    end;
    gutx := (x div 100) + 1;
    guty := (y div 100) + 1;
    if gm = 0 then
      begin
      fall;
      end
    else
      begin
        tch[1] := 1;
        tch[2] := 0;
        tch[3] := 1;
        tch[4] := 0;
        tch[5] := 0;
        tch[6] := 1;
        tch[7] := 0;
        tch[8] := 1;
      end;
  end;
end.