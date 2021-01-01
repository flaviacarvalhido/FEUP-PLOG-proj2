:- use_module(library(clpfd)).

:- include('problem_generator.pl').
:- include('tests.pl').
:- include('display.pl').


/*

	Chefs - [0, 0, 1]
	ChefMeals - [
					1, 1, 1, 0, 0,
					0, 1, 1, 0, 0,
					1, 0, 0, 1, 1
				]
	CookMeals - [1, 0, 0, 1, 1]
	Meals - []

*/

start:- mainMenu; true.

%Solução com MaxMeals = 4:	Contratar Chefs 2 e 3 e incluir na ementa os pratos 1, 2, 3 e 5
test_solve:- generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium:-	generateMediumAlt(Meals, Chefs, ChefMeals, MealsList), solve(7, Meals, Chefs, ChefMeals, MealsList).


solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-
	
	length(Chefs, LenChefs),
	length(Meals, LenMeals),
	ActualLenMeals #= LenMeals / 2,
	mealsListToDomainsFinal(MealsList, MaxMeals, MealsListFinal),

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
	
	getAllChefMeals(ActualLenMeals, ResChefs, ChefMeals, LenChefs, [], CurrentChefMeals),
	forceOrOnBigListNew(CurrentChefMeals, PossibleChefMeals, ActualLenMeals),
	%getChefMealsAlt(ActualLenMeals, 1, ChefMeals, CurrentChefMeals),
	% write(CurrentChefMeals), nl,
	% write(PossibleChefMeals), nl,

	forceZerosNewNewNew(PossibleChefMeals, ResMeals),
	mealIdsToTypesFinal(ResMeals, Types, ActualLenMeals, Meals),
	global_cardinality(Types, MealsListFinal),

	% Evaluation
	sumChefsSalaries(Chefs, ResChefs, SalariesSum),
	sumMealsProfit(Meals, ResMeals, MealsSum),
	Profit #= MealsSum - SalariesSum,

	% Labeling
	append(ResChefs, ResMeals, Final),
	labeling([maximize(Profit)], Final),

	displaySolution(ResChefs, LenChefs, ResMeals, Types, SalariesSum, MealsSum, Profit).

test:-	A in 0..1,
		B in 2..2,
		Meals = [200, 1, 250, 2, 300, 3, 150, 2, 175, 1],
		ChefMeals = [
					1, 1, 1, 0, 0,
					0, 1, 1, 0, 0,
					1, 0, 0, 1, 1
					],
		getAllChefMeals(5, [A, B], ChefMeals, 2, [0, 0, 0, 0, 0], CurrentChefMeals),
		length(ResMeals, 5),
		domain(ResMeals, 0, 1),

		forceZerosNew(CurrentChefMeals, ResMeals),

		sum(ResMeals, #=<, 4),
		sumMealsProfit(Meals, ResMeals, Sum),

		labeling([maximize(A), maximize(B), maximize(Sum)], [A, B|ResMeals]),
		write(A), nl,
		write(B), nl,
		write(ResMeals), nl,
		write(CurrentChefMeals), nl.

