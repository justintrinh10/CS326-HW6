ticTacToe :-
    write('Welcome to TicTacToe'), nl,
    emptyBoard(Board),
    displayBoard(Board),
    playGame(Board, "X").

playGame(Board, Player) :- 
    takeTurn(Board, Player, NewBoard),
    displayBoard(NewBoard),
    (   win(NewBoard, Player) ->
        format('Player ~w wins!', [Player]), nl;
        notDraw(NewBoard) ->
            (   Player = "X" ->
                NextPlayer = "Y"
            ;   NextPlayer = "X"
            ),
            playGame(NewBoard, NextPlayer)
    ).

takeTurn(Board, Player, NewBoard) :-
    format('Player ~w\'s Turn:', [Player]), nl,
    write('Row: '), read(UserRow), nl,
    write('Col: '), read(UserCol), nl,
    (   updateBoard(Board, Player, UserRow, UserCol, NewBoard);
        format('Invalid Move'), nl,
        takeTurn(Board, Player, NewBoard)
    ).

notDraw([R1, R2, R3]) :-
    member(' ', R1);
    member(' ', R2);
    member(' ', R3).

win(Board, Player) :- 
    horizontalWin(Board, Player);
    verticalWin(Board, Player);
    diagonalWin(Board, Player).

horizontalWin([R1, R2, R3], Player) :-
    rowWin(R1, Player);
    rowWin(R2, Player);
    rowWin(R3, Player);

rowWin([C1, C2, C3], Player) :-
    C1 = Player,
    C2 = Player,
    C3 = Player.

verticalWin([[C11, C12, C13], [C21, C22, C23], [C31, C32, C33]], Player) :- 
    allPlayer(C11, C21, C31, Player);
    allPlayer(C12, C22, C32, Player);
    allPlayer(C13, C23, C33, Player).

allPlayer(C1, C2, C3, Player) :-
    C1 = Player,
    C2 = Player,
    C3 = Player.

diagonalWin([[C11, C12, C13], [C21, C22, C23], [C31, C32, C33]], Player) :-
    allPlayer(C11, C22, C33, Player);
    allPlayer(C13, C22, C31, Player).

updateBoard(Board, Player, UserRow, UserCol, NewBoard) :-
    validMove(Board, UserRow, UserCol),
    place(Board, Player, UserRow, UserCol, NewBoard).

place([R1, R2, R3], Player, 0, Col, [NewR1, R2, R3]) :-
    updateRow(R1, Player, Col, NewR1).
place([R1, R2, R3], Player, 1, Col, [R1, NewR2, R3]) :-
    updateRow(R2, Player, Col, NewR2).
place([R1, R2, R3], Player, 2, Col, [R1, R2, NewR3]) :-
    updateRow(R3, Player, Col, NewR3).

updateRow([C1, C2, C3], Player, 0, [Player, C2, C3]).
updateRow([C1, C2, C3], Player, 1, [C1, Player, C3]).
updateRow([C1, C2, C3], Player, 2, [C1, C2, Player]).

validMove(Board, UserRow, UserCol) :-
    getRow(Board, UserRow, Row),
    getCol(Row, UserCol, Box),
    Box = ' '.
    
getRow(Board, RowIndex, Row) :-
    nth0(RowIndex, Board, Row).

getCol(Row, ColIndex, Col) :-
    nth0(ColIndex, Row, Col).

emptyBoard([[' ',' ',' '],
            [' ',' ',' '],
            [' ',' ',' ']]).

displayBoard([R3, R2, R1]) :-
    write('3 '), displayRow(R3), nl,
    write('  -----------'), nl,
    write('2 '), displayRow(R2), nl,
    write('  -----------'), nl,
    write('1 '), displayRow(R1), nl,
    write('   1   2   3'), nl.

displayRow([C1, C2, C3]) :-
    format(' ~w | ~w | ~w ', [C1, C2, C3]).