% 
% Hidato puzzle in ASP.
% 
% http://www.shockwave.com/gamelanding/hidato.jsp
% http://www.hidato.com/
%
% """
% Puzzles start semi-filled with numbered tiles.
% The first and last numbers are circled.
% Connect the numbers together to win. Consecutive
% number must touch horizontally, vertically, or
% diagonally.
% """
%
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%



% domains
size(1..n).
values(1..n*n).
values2(1..n*n-1).
diffs(-1;0;1).


% unique index of rows and cols
1 { x(Row, Col, Value) : values(Value) } 1 :- size(Row), size(Col).

% alldifferent values
1 { x(Row, Col, Value) : size(Row) : size(Col) } 1 :- values(Value).

% place the hints
x(Row, Col, Value) :- hint(Row, Col, Value).

%
% check valid states (Row,Col) -> (Row2, Col2)
%
valid(Row, Col, Row2, Col2) :- diffs(A), diffs(B),
                               Row2 = Row+A,
                               Col2 = Col+B,
                               Row2 >= 1, Col2 >= 1,
                               Row2 <= size, Col2 <= size,
                               size(Row), size(Col).


% remove all invalid states
:- x(Row, Col, Value+1), x(Row2, Col2, Value), not valid(Row, Col, Row2, Col2), values2(Value).

#hide.
#show x(Row, Col, Value).