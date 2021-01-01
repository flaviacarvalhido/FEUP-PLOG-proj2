:- use_module(library(clpfd)).

:- include('problem_generator.pl').
:- include('tests.pl').
:- include('display.pl').
:- include('fixedChefsProblems.pl').
:- include('fixedMealsProblems.pl').


/*
 * resetTimer/0
 *
 * Resets the timer for statistics purposes
 *
 */
reset_timer :- statistics(walltime,_).

/*
 * printTime/0
 *
 * Displays the time passed since the timer was reset
 *
 */
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.

/*
 * start/0
 *
 * Entry point for the solver
 *
 */
start:- mainMenu; true.

/*
 * solve(+MaxMeals, +Meals, +Chefs, +ChefMeals, +MealsList)
 *
 * Solves the problem and displays the solution
 *
 */
solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-

	reset_timer,

	length(Chefs, LenChefs),
	length(Meals, LenMeals),
	ActualLenMeals #= LenMeals / 2,
	mealsListToDomainsFinal(MealsList, MaxMeals, MealsListFinal),
	%mealsListToDomainsFasterFinal(MealsList, ActualLenMeals, Meals, MealsListFinal),

	clearConsole,
	displayInput(MaxMeals, MealsList, Meals, ActualLenMeals, Chefs, LenChefs, ChefMeals),
	
	write('----------------------------------------------------Processing------------------------------------------------------'), nl,

	% Decision Variables
	length(ResChefs, LenChefs),
	length(ResMeals, ActualLenMeals),
	domain(ResChefs, 0, 1),
	domain(ResMeals, 0, 1),

	% Restrictions
	sum(ResMeals, #=<, MaxMeals), % No máximo há MaxMeals pratos
	sum(ResChefs, #>, 0), 		  % Contrata-se pelo menos um chef
	
	getAllChefMeals(ActualLenMeals, ResChefs, ChefMeals, LenChefs, [], CurrentChefMeals), % Get the meals of the current selected chefs
	forceOrOnBigList(CurrentChefMeals, PossibleChefMeals, ActualLenMeals), % Get the list with all the possible menu meals based on the current selected chefs

	forceZeros(PossibleChefMeals, ResMeals), % Force the ResMeals list to only have meals that are also on the PossibleChefsMeals list
	mealIdsToTypesFinal(ResMeals, Types, ActualLenMeals, Meals), % Get a list with the types of the selected meals
	global_cardinality(Types, MealsListFinal), % Force the ResMeals list to have at least Xi meals of type i
	%myCardinality(MealsList, Types),


	% Evaluation
	sumChefsSalaries(Chefs, ResChefs, SalariesSum), % Get the total salaries
	sumMealsProfit(Meals, ResMeals, MealsSum), % Get the total meals expected profit
	Profit #= MealsSum - SalariesSum, % Get the total profit

	% Labeling
	append(ResChefs, ResMeals, Final),
	labeling([maximize(Profit)], Final),

	displaySolution(ResChefs, LenChefs, ResMeals, Types, SalariesSum, MealsSum, Profit).
	print_time
	/*
	fd_statistics,
	write('ResChefs: '), write(ResChefs), nl,
	write('ResMeals: '), write(ResMeals), nl,
	write('Salaries: '), write(SalariesSum), nl,
	write('Meals Profit: '), write(MealsSum), nl,
	write('Total Profit: '), write(Profit), nl
	*/.


