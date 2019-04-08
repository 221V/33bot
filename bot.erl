-module(bot).
-compile([export_all, nowarn_export_all]).

%% info notes

% ['#544368', '84,67,104'];// bg sheet
% ['#5C4973', '92,73,115']; // bg ceil
% ['#FFF913', '255,249,19'];// 1 -- border
% ['#76C3B5', '118,195,181'];// 2 -- border
% ['#EB5190', '235,81,144'];// 3 -- border
% ['#EB094F', '235,9,79'];// 3 -- fill
% ['#A8A9F4', '168,169,244'];// 6 -- border
% ['#7E7FF0', '126,127,240'];// 6 -- fill
% ['#5BC7EF', '91,199,239'];// 12 -- border
% ['#1C97FF', '28,151,255'];// 12 -- fill
% ['#994DF3', '153,77,243'];// border
% ['#7C34D1', '124,52,209'];// fill
% ['#FFD66B', '255,214,107'];// b
% ['#F9B404', '249,180,4'];// f
% ['#F26346', '242,99,70'];// b
% ['#DA4D30', '218,77,48'];// f
% ['#7BAE40', '123,174,64'];// b
% ['#95D350', '149,211,80'];// f
% ['#3DD9D1', '61,217,209'];// b
% ['#28B7B4', '40,183,180'];// f
% ['#6966D7', '105,102,215'];// b
% ['#4C4AE2', '76,74,226'];// f
% ['#EF5BB1', '239,91,177'];// b
% ['#D1348F', '209,52,143'];// f
% ['#BD94EE', '189,148,238'];// b
% ['#A164EE', '161,100,238'];// f


%% testing

% get pixel color
pix() ->
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(50),
    A2 = ?MODULE:fc(A1),
    io:format("~p ~n",[A2])
  end),
  
  %os:cmd("xdotool mousemove 230 270 && xdotool mousedown 1 && xdotool mouseup 1"),
  os:cmd("xdotool mousemove 2 185 && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% xdotool getmouselocation
% x:2 y:178 screen:0 window:16834288

% xdotool key Left
% xdotool key Right
% xdotool key Down


% search and make window active, click mouse and keydown arrows
win() ->
  %A1 = os:cmd("xdotool search --name '3+3 | GAMEE' getwindowname %'1'"),
  %io:format("~p ~n",[A1]),
  %A2 = os:cmd("xdotool search --name '3+3 | GAMEE'"),
  %io:format("~p ~n",[A2]),
  %A3 = os:cmd("xdotool windowactivate 29362581"),
  %io:format("~p ~n",[A3]),
  os:cmd("xdotool search --name '3+3 | GAMEE - Firefox Developer Edition' windowactivate"),
  os:cmd("xdotool mousemove 400 200 && xdotool mousedown 1 && xdotool mouseup 1"),
  os:cmd("xdotool key Down"),
  os:cmd("xdotool key Left"),
  os:cmd("xdotool key Left"),
  os:cmd("xdotool key Left"),
  os:cmd("xdotool key Down"),
  os:cmd("xdotool key Right"),
  ok.

% try find first Y coordinate pixel with black color
pix2() ->
  ?MODULE:win2(),
  ?MODULE:pix2(180).
pix2(Y) ->
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(30),
    A2 = ?MODULE:fc(A1),
    if A2 =:= "#000000" ->
%        io:format("~p ~n",[A2]),
%        io:format("canvas begins Y: ~p ~n",[Y]),
        %?MODULE:pix3(3, Y);
        ?MODULE:pix3(3, Y + 5);
      true ->
        ?MODULE:pix2(Y + 1)
    end
  end),
  os:cmd("xdotool mousemove 2 " ++ erlang:integer_to_list(Y) ++ " && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% try find first X non-black pixel
pix3(X, Y) ->
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(30),
    A2 = ?MODULE:fc(A1),
    if A2 =:= "#000000" ->
        ?MODULE:pix3(X + 1, Y);
      true ->
        %io:format("~p ~n",[A2]),
%        io:format("game canvas top left X Y: ~p ~p ~n",[X, Y]),
        %?MODULE:pix4(X, Y + 1, A2)
        ?MODULE:pix4(X + 3, Y + 1, A2)
    end
  end),
  os:cmd("xdotool mousemove " ++ erlang:integer_to_list(X) ++ " " ++ erlang:integer_to_list(Y) ++ " && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% try find next first Y other color pixel
pix4(X, Y, C) ->
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(30),
    A2 = ?MODULE:fc(A1),
    if A2 =:= C ->
        ?MODULE:pix4(X, Y + 1, C);
      true ->
        %io:format("~p ~n",[A2]),
%        io:format("game canvas bottom left X Y: ~p ~p ~n",[X, Y - 1]),
        %?MODULE:pix5(X + 1, Y - 1, C)
        ?MODULE:pix5(X + 1, Y - 3, C)
    end
  end),
  os:cmd("xdotool mousemove " ++ erlang:integer_to_list(X) ++ " " ++ erlang:integer_to_list(Y) ++ " && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% try find next first X other color pixel
pix5(X, Y, C) ->
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(30),
    A2 = ?MODULE:fc(A1),
    if A2 =:= C ->
        ?MODULE:pix5(X + 1, Y, C);
      true ->
        %io:format("~p ~n",[A2]),
%        io:format("game canvas bottom right X Y: ~p ~p ~n",[X - 1, Y])
        ok
    end
  end),
  os:cmd("xdotool mousemove " ++ erlang:integer_to_list(X) ++ " " ++ erlang:integer_to_list(Y) ++ " && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% test pixels
%game canvas top left X Y: 360 182 
%game canvas bottom left X Y: 360 742 
%game canvas bottom right X Y: 920 742
% erlang:list_to_integer(erlang:float_to_list( ((920 - 360)/4) ,[{decimals,0}]))
% 560 px -- game canvas width/ height
% 112 px -- game cell with borders -- calculated
% 127 px (25 * 5 + 2) -- game cell with all borders -- calc by screen

% 7 px -- cell border (colored) -- calc by screen
% 127 px (25 * 5 + 2)  -- cell width with border (colored) -- calc by screen

% 11 px -- game canvas left padding -- calc by screen
% 11 px -- game canvas top padding -- calc by screen
% 10 px -- game canvas right padding -- calc by screen
% 10 px -- game canvas bottom padding -- calc by screen

% 11px -- border vertical between cells
% 11px -- border horizontal between cells

% --

% 560 - 10 - 11 = 539 px -- 4 cells (with 3 cell borders - colored) + 3 borders between them
% 539 / 560 = 0.9625
% (127 * 4) / 560 = 508 / 560 = 0.907142857
% (560 - (10 + 11) - (127 * 4)) / 3 = (560 - 21 - 508) / 3 = 10.33333

% oh shit, easy way -- manual detect coordinates, not calc =)


% write to ets, read from ets
c0() ->
  %Table = ets:new(coords, [set, public, named_table]),
  ets:new(coords, [set, public, named_table]),
  
  %ets:insert_new(Table, {"1", "test77"}),
  %A1 = ets:match(Table, {"1", '$2'}),
  ets:insert_new(coords, {"1", "test77"}),
  A1 = ets:match(coords, {"1", '$2'}),
  io:format("~p~n",[A1]),% [["test77"]]
  
  %:ets:match(Table, {'$1', '$2'})
  %ets:delete(Table).
  ets:delete(coords).




%% real bot begins here

% filter color -- hex, list string
fc(A) ->
  string:sub_string(A,1,7).

% make window active
win2() ->
  os:cmd("xdotool search --name '3+3 | GAMEE - Firefox Developer Edition' windowactivate").

% create ets tables
ct() ->
  % canvas coordinates -- tl, tr, bl, br (top left, top right, bottom left, bottom right)
  %ets:new(coords_canvas, [set, public, named_table]),
  % ets:insert_new(coords_canvas, {"tl", {X,Y}}),
  
  % cells coordinates (for check) -- 11, 12, 13, 14, 21, 22, ..., 44 (from left to right, from bottom to top)
  ets:new(coords_cells, [set, public, named_table]),
  ets:insert_new(coords_cells, {"11", {244,900}}),
  ets:insert_new(coords_cells, {"12", {449,907}}),
  ets:insert_new(coords_cells, {"13", {654,906}}),
  ets:insert_new(coords_cells, {"14", {860,907}}),
  ets:insert_new(coords_cells, {"21", {243,702}}),
  ets:insert_new(coords_cells, {"22", {449,703}}),
  ets:insert_new(coords_cells, {"23", {654,705}}),
  ets:insert_new(coords_cells, {"24", {860,704}}),
  ets:insert_new(coords_cells, {"31", {244,496}}),
  ets:insert_new(coords_cells, {"32", {449,495}}),
  ets:insert_new(coords_cells, {"33", {654,498}}),
  ets:insert_new(coords_cells, {"34", {860,493}}),
  ets:insert_new(coords_cells, {"41", {244,284}}),
  ets:insert_new(coords_cells, {"42", {449,285}}),
  ets:insert_new(coords_cells, {"43", {655,289}}),
  ets:insert_new(coords_cells, {"44", {860,288}}),
  
  % values now (from pixel colors)
  ets:new(values_cells, [set, public, named_table]),
  ets:insert_new(values_cells, {"next", 0}),
  ets:insert_new(values_cells, {"11", 0}),
  ets:insert_new(values_cells, {"12", 0}),
  ets:insert_new(values_cells, {"13", 0}),
  ets:insert_new(values_cells, {"14", 0}),
  ets:insert_new(values_cells, {"21", 0}),
  ets:insert_new(values_cells, {"22", 0}),
  ets:insert_new(values_cells, {"23", 0}),
  ets:insert_new(values_cells, {"24", 0}),
  ets:insert_new(values_cells, {"31", 0}),
  ets:insert_new(values_cells, {"32", 0}),
  ets:insert_new(values_cells, {"33", 0}),
  ets:insert_new(values_cells, {"34", 0}),
  ets:insert_new(values_cells, {"41", 0}),
  ets:insert_new(values_cells, {"42", 0}),
  ets:insert_new(values_cells, {"43", 0}),
  ets:insert_new(values_cells, {"44", 0}),
  % ets:insert(values_cells, {"11", 55}),
  
  % calculated values after next move
  ets:new(calc_next_values_cells, [set, public, named_table]),
  ets:insert_new(calc_next_values_cells, {"11", 0}),
  ets:insert_new(calc_next_values_cells, {"12", 0}),
  ets:insert_new(calc_next_values_cells, {"13", 0}),
  ets:insert_new(calc_next_values_cells, {"14", 0}),
  ets:insert_new(calc_next_values_cells, {"21", 0}),
  ets:insert_new(calc_next_values_cells, {"22", 0}),
  ets:insert_new(calc_next_values_cells, {"23", 0}),
  ets:insert_new(calc_next_values_cells, {"24", 0}),
  ets:insert_new(calc_next_values_cells, {"31", 0}),
  ets:insert_new(calc_next_values_cells, {"32", 0}),
  ets:insert_new(calc_next_values_cells, {"33", 0}),
  ets:insert_new(calc_next_values_cells, {"34", 0}),
  ets:insert_new(calc_next_values_cells, {"41", 0}),
  ets:insert_new(calc_next_values_cells, {"42", 0}),
  ets:insert_new(calc_next_values_cells, {"43", 0}),
  ets:insert_new(calc_next_values_cells, {"44", 0}),
  % ets:insert(calc_next_values_cells, {"11", 55}),
  ok.


% cell by border color
cell_by_color("#fff913") -> 1;
cell_by_color("#76c3b5") -> 2;
cell_by_color("#eb5190") -> 3;
cell_by_color("#a8a9f4") -> 6;
cell_by_color("#5bc7ef") -> 12;
cell_by_color("#994df3") -> 24;
cell_by_color("#ffd66b") -> 48;
cell_by_color("#f26346") -> 96;
cell_by_color("#7bae40") -> 192;
cell_by_color("#3dd9d1") -> 384;
cell_by_color("#6966d7") -> 768;
cell_by_color("#ef5bb1") -> 1536;
cell_by_color("#bd94ee") -> 3072;
cell_by_color(_) -> 0.


% get cell value from ets, P -- list string -- "11"
cell_value(P) ->
  [[A2]] = ets:match(values_cells, {P, '$2'}),
  A2.

% upd cell value in ets, P -- list string, V -- integer -- "11",1
upd_cell_value(P,V) ->
  ets:insert(values_cells, {P, V}).

% get coords for check cell color, returns {X,Y}, P -- list string -- "11"
cell_coords(P) ->
  [[A]] = ets:match(coords_cells, {P, '$2'}),
  A.

% get calculated cell value from ets, P -- list string -- "11"
calc_cell_value(P) ->
  [[A2]] = ets:match(calc_next_values_cells, {P, '$2'}),
  A2.

% upd calculated cell value in ets, P -- list string, V -- integer -- "11",1
upd_calc_cell_value(P,V) ->
  ets:insert(calc_next_values_cells, {P, V}).

% io format for calculated for real cells now
io_real() ->
  io:format("~p~n",["now real"]),
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  V5 = ?MODULE:cell_value("21"),
  V6 = ?MODULE:cell_value("22"),
  V7 = ?MODULE:cell_value("23"),
  V8 = ?MODULE:cell_value("24"),
  V9 = ?MODULE:cell_value("31"),
  V10 = ?MODULE:cell_value("32"),
  V11 = ?MODULE:cell_value("33"),
  V12 = ?MODULE:cell_value("34"),
  V13 = ?MODULE:cell_value("41"),
  V14 = ?MODULE:cell_value("42"),
  V15 = ?MODULE:cell_value("43"),
  V16 = ?MODULE:cell_value("44"),
  io:format("~p,~p,~p,~p~n",[V13,V14,V15,V16]),
  io:format("~p,~p,~p,~p~n",[V9,V10,V11,V12]),
  io:format("~p,~p,~p,~p~n",[V5,V6,V7,V8]),
  io:format("~p,~p,~p,~p~n",[V1,V2,V3,V4]),
  ok.

% io format for calculated for next move cells and real cells 
io_calc_and_real() ->
  io:format("~p~n",["calculated"]),
  N1 = ?MODULE:calc_cell_value("11"),
  N2 = ?MODULE:calc_cell_value("12"),
  N3 = ?MODULE:calc_cell_value("13"),
  N4 = ?MODULE:calc_cell_value("14"),
  N5 = ?MODULE:calc_cell_value("21"),
  N6 = ?MODULE:calc_cell_value("22"),
  N7 = ?MODULE:calc_cell_value("23"),
  N8 = ?MODULE:calc_cell_value("24"),
  N9 = ?MODULE:calc_cell_value("31"),
  N10 = ?MODULE:calc_cell_value("32"),
  N11 = ?MODULE:calc_cell_value("33"),
  N12 = ?MODULE:calc_cell_value("34"),
  N13 = ?MODULE:calc_cell_value("41"),
  N14 = ?MODULE:calc_cell_value("42"),
  N15 = ?MODULE:calc_cell_value("43"),
  N16 = ?MODULE:calc_cell_value("44"),
  io:format("~p,~p,~p,~p~n",[N13,N14,N15,N16]),
  io:format("~p,~p,~p,~p~n",[N9,N10,N11,N12]),
  io:format("~p,~p,~p,~p~n",[N5,N6,N7,N8]),
  io:format("~p,~p,~p,~p~n",[N1,N2,N3,N4]),
  io:format("~p~n",["real"]),
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  V5 = ?MODULE:cell_value("21"),
  V6 = ?MODULE:cell_value("22"),
  V7 = ?MODULE:cell_value("23"),
  V8 = ?MODULE:cell_value("24"),
  V9 = ?MODULE:cell_value("31"),
  V10 = ?MODULE:cell_value("32"),
  V11 = ?MODULE:cell_value("33"),
  V12 = ?MODULE:cell_value("34"),
  V13 = ?MODULE:cell_value("41"),
  V14 = ?MODULE:cell_value("42"),
  V15 = ?MODULE:cell_value("43"),
  V16 = ?MODULE:cell_value("44"),
  io:format("~p,~p,~p,~p~n",[V13,V14,V15,V16]),
  io:format("~p,~p,~p,~p~n",[V9,V10,V11,V12]),
  io:format("~p,~p,~p,~p~n",[V5,V6,V7,V8]),
  io:format("~p,~p,~p,~p~n",[V1,V2,V3,V4]),
  ok.

% upd ets cell value by pixel color, P -- list string -- "11"
cell_by_pix(P) ->
  {X,Y} = ?MODULE:cell_coords(P),
  spawn(fun() ->
    A1 = os:cmd("grabc"),
    timer:sleep(50),
    A2 = ?MODULE:fc(A1),
    A3 = ?MODULE:cell_by_color(A2),
%    io:format("~p : ~p~n",[P, A3]),
    ?MODULE:upd_cell_value(P,A3)
  end),
  os:cmd("xdotool mousemove " ++ erlang:integer_to_list(X) ++ " " ++ erlang:integer_to_list(Y) ++ " && xdotool mousedown 1 && xdotool mouseup 1"),
  ok.

% get all cells by pixel colors
all_cells_from_pix() ->
  A = ["11", "12", "13", "14", "21", "22", "23", "24", "31", "32", "33", "34", "41", "42", "43", "44"],
  ?MODULE:all_cells_from_pix(A).
all_cells_from_pix([]) -> ok;
all_cells_from_pix([H|T]) ->
  spawn(fun() ->
    ?MODULE:cell_by_pix(H)
  end),
  timer:sleep(95),
  ?MODULE:all_cells_from_pix(T).

% moves
move_d() ->
  os:cmd("xdotool key Down"), ok.

move_l() ->
  os:cmd("xdotool key Left"), ok.

move_r() ->
  os:cmd("xdotool key Right"), ok.

% are empty cell in row?
empty_in_row(0,_,_,_) -> true;
empty_in_row(_,0,_,_) -> true;
empty_in_row(_,_,0,_) -> true;
empty_in_row(_,_,_,0) -> true;
empty_in_row(_,_,_,_) -> false.

% are empty for move to right cells in row?
empty4move_r_in_row(0,0,0,0) -> false;
empty4move_r_in_row(0,0,0,_) -> false;
empty4move_r_in_row(0,0,A,B) when A =/= 0, B =/= 0 -> false;
empty4move_r_in_row(0,A,B,C) when A =/= 0, B =/= 0, C =/= 0 -> false;
empty4move_r_in_row(A,B,C,D) when A =/= 0, B =/= 0, C =/= 0, D =/= 0 -> false;
empty4move_r_in_row(_,_,_,_) -> true.

% are empty for move to left cells in row?
empty4move_l_in_row(0,0,0,0) -> false;
empty4move_l_in_row(_,0,0,0) -> false;
empty4move_l_in_row(A,B,0,0) when A =/= 0, B =/= 0 -> false;
empty4move_l_in_row(A,B,C,0) when A =/= 0, B =/= 0, C =/= 0 -> false;
empty4move_l_in_row(A,B,C,D) when A =/= 0, B =/= 0, C =/= 0, D =/= 0 -> false;
empty4move_l_in_row(_,_,_,_) -> true.

% are the same near? 
same_near_in_row(A,A,_,_) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_near_in_row(_,A,A,_) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_near_in_row(_,_,A,A) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_near_in_row(A,B,_,_) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_near_in_row(_,A,B,_) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_near_in_row(_,_,A,B) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_near_in_row(_,_,_,_) -> false.

% are the same in column? -- "11", "21", "31", "41"
same_in_column(A,A,_,_) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_in_column(_,A,A,_) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_in_column(_,_,A,A) when A =/= 0, A =/= 1, A =/= 2 -> true;
same_in_column(A,B,_,_) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_in_column(_,A,B,_) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_in_column(_,_,A,B) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> true;
same_in_column(_,_,_,_) -> false.

% are empty for move down in column? -- "11", "21", "31", "41"
empty4move_d_in_col(0,A,B,C) when A =/= 0; B =/= 0, C =/= 0 -> true;
empty4move_d_in_col(_,0,A,B) when A =/= 0; B =/= 0 -> true;
empty4move_d_in_col(_,_,0,A) when A =/= 0 -> true;
empty4move_d_in_col(_,_,_,_) -> false.

% can total move down?
can_tmd() ->
  V1 = ?MODULE:cell_value("11"),
  V5 = ?MODULE:cell_value("21"),
  V9 = ?MODULE:cell_value("31"),
  V13 = ?MODULE:cell_value("41"),
  E1 = ?MODULE:empty4move_d_in_col(V1,V5,V9,V13),
  S1 = ?MODULE:same_in_column(V1,V5,V9,V13),
  
  V2 = ?MODULE:cell_value("12"),
  V6 = ?MODULE:cell_value("22"),
  V10 = ?MODULE:cell_value("32"),
  V14 = ?MODULE:cell_value("42"),
  E2 = ?MODULE:empty4move_d_in_col(V2,V6,V10,V14),
  S2 = ?MODULE:same_in_column(V2,V6,V10,V14),
  
  V3 = ?MODULE:cell_value("13"),
  V7 = ?MODULE:cell_value("23"),
  V11 = ?MODULE:cell_value("33"),
  V15 = ?MODULE:cell_value("43"),
  E3 = ?MODULE:empty4move_d_in_col(V3,V7,V11,V15),
  S3 = ?MODULE:same_in_column(V3,V7,V11,V15),
  
  V4 = ?MODULE:cell_value("14"),
  V8 = ?MODULE:cell_value("24"),
  V12 = ?MODULE:cell_value("34"),
  V16 = ?MODULE:cell_value("44"),
  E4 = ?MODULE:empty4move_d_in_col(V4,V8,V12,V16),
  S4 = ?MODULE:same_in_column(V4,V8,V12,V16),
  
%  io:format("down: 1:~p:~p 2:~p:~p 3:~p:~p 4:~p:~p",[E1,S1,E2,S2,E3,S3,E4,S4]),
  Result = ((E1 or S1) or (E2 or S2)) or ((E3 or S3) or (E4 or S4)),
  Result.

% can total move right?
can_tmr() ->
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  E1 = ?MODULE:empty4move_r_in_row(V1,V2,V3,V4),
  S1 = ?MODULE:same_near_in_row(V1,V2,V3,V4),
  
  V5 = ?MODULE:cell_value("21"),
  V6 = ?MODULE:cell_value("22"),
  V7 = ?MODULE:cell_value("23"),
  V8 = ?MODULE:cell_value("24"),
  E2 = ?MODULE:empty4move_r_in_row(V5,V6,V7,V8),
  S2 = ?MODULE:same_near_in_row(V5,V6,V7,V8),
  
  V9 = ?MODULE:cell_value("31"),
  V10 = ?MODULE:cell_value("32"),
  V11 = ?MODULE:cell_value("33"),
  V12 = ?MODULE:cell_value("34"),
  E3 = ?MODULE:empty4move_r_in_row(V9,V10,V11,V12),
  S3 = ?MODULE:same_near_in_row(V9,V10,V11,V12),
  
  V13 = ?MODULE:cell_value("41"),
  V14 = ?MODULE:cell_value("42"),
  V15 = ?MODULE:cell_value("43"),
  V16 = ?MODULE:cell_value("44"),
  E4 = ?MODULE:empty4move_r_in_row(V13,V14,V15,V16),
  S4 = ?MODULE:same_near_in_row(V13,V14,V15,V16),
  
%  io:format("right: 1:~p:~p 2:~p:~p 3:~p:~p 4:~p:~p",[E1,S1,E2,S2,E3,S3,E4,S4]),
  Result = ((E1 or S1) or (E2 or S2)) or ((E3 or S3) or (E4 or S4)),
  Result.


% can total move left?
can_tml() ->
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  E1 = ?MODULE:empty4move_l_in_row(V1,V2,V3,V4),
  S1 = ?MODULE:same_near_in_row(V1,V2,V3,V4),
  
  V5 = ?MODULE:cell_value("21"),
  V6 = ?MODULE:cell_value("22"),
  V7 = ?MODULE:cell_value("23"),
  V8 = ?MODULE:cell_value("24"),
  E2 = ?MODULE:empty4move_l_in_row(V5,V6,V7,V8),
  S2 = ?MODULE:same_near_in_row(V5,V6,V7,V8),
  
  V9 = ?MODULE:cell_value("31"),
  V10 = ?MODULE:cell_value("32"),
  V11 = ?MODULE:cell_value("33"),
  V12 = ?MODULE:cell_value("34"),
  E3 = ?MODULE:empty4move_l_in_row(V9,V10,V11,V12),
  S3 = ?MODULE:same_near_in_row(V9,V10,V11,V12),
  
  V13 = ?MODULE:cell_value("41"),
  V14 = ?MODULE:cell_value("42"),
  V15 = ?MODULE:cell_value("43"),
  V16 = ?MODULE:cell_value("44"),
  E4 = ?MODULE:empty4move_l_in_row(V13,V14,V15,V16),
  S4 = ?MODULE:same_near_in_row(V13,V14,V15,V16),
  
%  io:format("left: 1:~p:~p 2:~p:~p 3:~p:~p 4:~p:~p",[E1,S1,E2,S2,E3,S3,E4,S4]),
  Result = ((E1 or S1) or (E2 or S2)) or ((E3 or S3) or (E4 or S4)),
  Result.


% can move right 1 ?
can_mr1() ->
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  case ?MODULE:empty_in_row(V1,V2,V3,V4) of
    false ->
      % no empty, check next
      case ?MODULE:same_near_in_row(V1,V2,V3,V4) of
        true ->
          % the same found
          true;
        false ->
          % the same not found
          false
      end;
    true ->
      % empty found
      case ?MODULE:empty4move_r_in_row(V1,V2,V3,V4) of
        true -> true;
        false -> false
      end
  end.

% can move left 1 ? -- false if "14" move-off from corner
can_ml1() ->
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  case ?MODULE:empty_in_row(V1,V2,V3,V4) of
    false ->
      % no empty, check next
      case ?MODULE:same_near_in_row(V1,V2,V3,V4) of
        false ->
          true;
        true ->
          % the same found
          false
      end;
    true ->
      % empty found
      false
  end.

% calculate moving (add cells) and return new position -- down -- (positions "11","21","31","41") values - integers
add_4d({A,B,C,D}=Z0) ->
  E1 = ?MODULE:empty4move_d_in_col(A,B,C,D),
  S1 = ?MODULE:same_in_column(A,B,C,D),
  ?MODULE:add_4d2(E1,S1,Z0).
% helper
add_4d2(true,true,Z0) ->
  % column can move - empty + the same cells
  ?MODULE:add_4d33(Z0);
add_4d2(true,false,Z0) ->
  % column can move - empty + no the same cells
  ?MODULE:add_4d31(Z0);
add_4d2(false,true,Z0) ->
  % column can move - no empty + the same cells
  ?MODULE:add_4d32(Z0);
add_4d2(false,false,Z0) ->
  % can not move - no empty + no cells for join, so return the input column
  Z0.

% down move for not the same cells + empty
add_4d31({0,A,B,C}) -> {A,B,C,0};
add_4d31({A,0,B,C}) -> {A,B,C,0};
add_4d31({A,B,0,C}) -> {A,B,C,0}.

% down move for the same cells + no empty
add_4d32({A,A,A,A}) when A =/= 1, A =/= 2 -> {A + A, A + A, 0, 0};
add_4d32({A,B,A,B}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, A + B, 0, 0};
add_4d32({A,B,B,A}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, B + A, 0, 0};
add_4d32({A,B,C,C}) when A =:= 1, B =:= 2, C =/= 1, C =/= 2; A =:= 2, B =:= 1, C =/= 1, C =/= 2 -> {A + B, C + C, 0, 0};
add_4d32({C,C,A,B}) when C =/= 1, C =/= 2, A =:= 1, B =:= 2; C =/= 1, C =/= 2, A =:= 2, B =:= 1 -> {C + C, A + B, 0, 0};
add_4d32({C,C,A,B}) when C =/= 1, C =/= 2 -> {C + C, A, B, 0};
add_4d32({A,B,C,C}) when C =/= 1, C =/= 2 -> {A, B, C + C, 0};
add_4d32({A,A,A,B}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A, A, A + B, 0};
add_4d32({A,B,B,B}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, B, B, 0};
add_4d32({A,B,B,C}) -> {A, B + B, C, 0};
add_4d32({A,B,C,D}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, C, D, 0};
add_4d32({A,B,C,D}) when B =:= 1, C =:= 2; B =:= 2, C =:= 1 -> {A, B + C, D, 0};
add_4d32({A,B,C,D}) when C =:= 1, D =:= 2; C =:= 2, D =:= 1 -> {A, B, C + D, 0}.

% down move for the same cells + empty
add_4d33({0,A,B,C}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, C, 0, 0};
add_4d33({0,A,B,C}) when B =:= 2, C =:= 1; B =:= 1, C =:= 2 -> {A, B + C, 0, 0};
add_4d33({0,A,A,B}) -> {A + A, B, 0, 0};
add_4d33({0,A,B,B}) -> {A, B + B, 0, 0};
add_4d33({A,0,B,C}) when B =:= 1, C =:= 2; B =:= 2, C =:= 1 -> {A, B + C, 0, 0};
add_4d33({A,0,B,B}) -> {A, B + B, 0, 0};
add_4d33({A,0,B,C}) -> {A, B, C, 0};
add_4d33({A,B,0,C}) when A =:= 1, B =:= 2; A =:= 2, B =:= 1 -> {A + B, 0, C, 0};
add_4d33({A,B,0,C}) -> {A,B,C,0}.


% calculate next position -- after 1 move -- M -- "D", "L", "R" -- down,left,right
%calc_next_pos(M) ->
calc_next_pos("D") ->
  V1 = ?MODULE:cell_value("11"),
  V2 = ?MODULE:cell_value("12"),
  V3 = ?MODULE:cell_value("13"),
  V4 = ?MODULE:cell_value("14"),
  V5 = ?MODULE:cell_value("21"),
  V6 = ?MODULE:cell_value("22"),
  V7 = ?MODULE:cell_value("23"),
  V8 = ?MODULE:cell_value("24"),
  V9 = ?MODULE:cell_value("31"),
  V10 = ?MODULE:cell_value("32"),
  V11 = ?MODULE:cell_value("33"),
  V12 = ?MODULE:cell_value("34"),
  V13 = ?MODULE:cell_value("41"),
  V14 = ?MODULE:cell_value("42"),
  V15 = ?MODULE:cell_value("43"),
  V16 = ?MODULE:cell_value("44"),
  
  {N1,N5,N9,N13} = ?MODULE:add_4d({V1,V5,V9,V13}),
  {N2,N6,N10,N14} = ?MODULE:add_4d({V2,V6,V10,V14}),
  {N3,N7,N11,N15} = ?MODULE:add_4d({V3,V7,V11,V15}),
  {N4,N8,N12,N16} = ?MODULE:add_4d({V4,V8,V12,V16}),
  
  ?MODULE:upd_calc_cell_value("11",N1),
  ?MODULE:upd_calc_cell_value("12",N2),
  ?MODULE:upd_calc_cell_value("13",N3),
  ?MODULE:upd_calc_cell_value("14",N4),
  ?MODULE:upd_calc_cell_value("21",N5),
  ?MODULE:upd_calc_cell_value("22",N6),
  ?MODULE:upd_calc_cell_value("23",N7),
  ?MODULE:upd_calc_cell_value("24",N8),
  ?MODULE:upd_calc_cell_value("31",N9),
  ?MODULE:upd_calc_cell_value("32",N10),
  ?MODULE:upd_calc_cell_value("33",N11),
  ?MODULE:upd_calc_cell_value("34",N12),
  ?MODULE:upd_calc_cell_value("41",N13),
  ?MODULE:upd_calc_cell_value("42",N14),
  ?MODULE:upd_calc_cell_value("43",N15),
  ?MODULE:upd_calc_cell_value("44",N16).

% first loop after start
start2() ->
  ?MODULE:all_cells_from_pix(),
  
%  V1 = ?MODULE:cell_value("11"),
%  V2 = ?MODULE:cell_value("12"),
%  V3 = ?MODULE:cell_value("13"),
%  V4 = ?MODULE:cell_value("14"),
%  case ?MODULE:empty_in_row(V1,V2,V3,V4) of
%    true ->
      % first row is empty
%      ?MODULE:move_d(),
%      timer:sleep(50),
%      ?MODULE:start2();
%    false ->
      % first row not empty
      case ?MODULE:can_mr1() of
        true ->
          % can move right - so move
          ?MODULE:move_r(),
          timer:sleep(50),
          ?MODULE:start3(1);
        false ->
          % can not move right - so try move down
          case ?MODULE:can_tmd() of
            true -> ?MODULE:move_d();
            false ->
              case ?MODULE:can_tmr() of
                true -> ?MODULE:move_r();
                false -> ?MODULE:move_l()
              end
          end,
          
          timer:sleep(50),
          ?MODULE:start3(1)
      end.
%  end.


% main loop
start3(N0) ->
  ?MODULE:all_cells_from_pix(),
  
  CD = ?MODULE:can_tmd(),
  CR = ?MODULE:can_tmr(),
  CL = ?MODULE:can_tml(),
  if CD =:= false, CR =:= false, CL =:= false ->
      game_over;
    true->
      % game go
  
  
  N = case N0 of
    1 ->
      io:format("~p~n",[1]),
      case CR of
        %true -> ?MODULE:move_r();
        true -> ?MODULE:move_r(), io:format("~p~n",["R"]);
        false ->
          case CD of
            %true -> ?MODULE:move_d();
            %true -> ?MODULE:move_d(), io:format("~p~n",["D"]);
            true -> io:format("~p~n",["=========================================="]),?MODULE:io_real(), io:format("~p~n",["D"]), ?MODULE:calc_next_pos("D"), ?MODULE:move_d(), timer:sleep(50), ?MODULE:all_cells_from_pix(), ?MODULE:io_calc_and_real(), io:format("~p~n",["=========================================="]);
            %false -> ?MODULE:move_l()
            false -> ?MODULE:move_l(), io:format("~p~n",["L"])
          end
      end,
      0;
    0 ->
      io:format("~p~n",[0]),
      case CD of
        %true -> ?MODULE:move_d();
        %true -> ?MODULE:move_d(), io:format("~p~n",["D"]);
        true -> io:format("~p~n",["=========================================="]),?MODULE:io_real(), io:format("~p~n",["D"]), ?MODULE:calc_next_pos("D"), ?MODULE:move_d(), timer:sleep(50), ?MODULE:all_cells_from_pix(), ?MODULE:io_calc_and_real(), io:format("~p~n",["=========================================="]);
        false ->
          case CR of
            %true -> ?MODULE:move_r();
            true -> ?MODULE:move_r(), io:format("~p~n",["R"]);
            %false -> ?MODULE:move_l()
            false -> ?MODULE:move_l(), io:format("~p~n",["L"])
          end
      end,
      1
  end,
  timer:sleep(50),
  
  ?MODULE:start3(N)
  
  end.


% start bot
start() ->
  ?MODULE:ct(),
  ?MODULE:win2(),
  ?MODULE:all_cells_from_pix(),
  
%  timer:sleep(150),
  ?MODULE:move_d(),
%  timer:sleep(150),
%  ?MODULE:move_l(),
%  timer:sleep(150),
%  ?MODULE:move_l(),
%  timer:sleep(150),
%  ?MODULE:move_l(),
  
  
  ?MODULE:start2().
  %ok.



