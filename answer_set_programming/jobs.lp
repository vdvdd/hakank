% 
% Jobs Puzzle in ASP.
% 
% (This is a standard problem in Automatic Reasoning.)
%
% From http://www-unix.mcs.anl.gov/~wos/mathproblems/jobs.html
% """
% There are four people: Roberta, Thelma, Steve, and Pete.
% Among them, they hold eight different jobs.
% Each holds exactly two jobs.
% The jobs are chef, guard, nurse, clerk, police officer (gender not implied),
% teacher, actor, and boxer.
% The job of nurse is held by a male.
% The husband of the chef is the clerk.
% Roberta is not a boxer.
% Pete has no education past the ninth grade.
% Roberta, [and] the chef, and the police officer went golfing together.
%
% Question: Who holds which jobs
% """
%
% This was created by Hakan Kjellerstrand, hakank@bonetmail.com
% See also http://www.hakank.org/answer_set_programming/
%

% Answer:
% has_job
% DIM: 2 (entries: 8)
% 	roberta,guard
% 	steve,nurse
% 	pete,clerk
% 	steve,police_officer
% 	roberta,teacher
% 	pete,actor
% 	thelma,boxer
% 	thelma,chef

% the persons
person(roberta;thelma;steve;pete).
job(chef;guard;nurse;clerk;police_officer;teacher;actor;boxer).


male(steve;pete).
female(roberta;thelma).
require_higher_education(nurse;police_officer;teacher).

% just one person has a specific job
1 { has_job(P,J) : person(P) } 1 :- job(J).

% Each person has exactly 2 jobs
2 { has_job(P,J) : job(J) } 2 :- person(P).

% The job of nurse is held by a male.
:- person(P), has_job(P,nurse), not male(P).

% for debugging
% not_has_job(P, J) | has_job(P, J) :- person(P), job(J).

% The husband of the chef is the clerk.
:- has_job(P,chef), has_job(P, clerk).
:- has_job(P,clerk), not male(P).
:- has_job(P,chef), not female(P).

% Roberta is not a boxer.
:- has_job(roberta, boxer).

% Pete has no education past the ninth grade.
:- has_job(pete, J), require_higher_education(J). 

% Roberta, [and] the chef, and the police officer went golfing together.
:- has_job(roberta, chef).
:- has_job(roberta, police_officer).
:- person(P), has_job(P, chef), has_job(P, police_officer).

% From the name of the job (actor: male)
:- has_job(P,actor), not male(P).

% Question: Who holds which jobs

#hide.
#show has_job(P,J).
% #show not_has_job(P,J).