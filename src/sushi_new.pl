:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('problem_generator.pl').
:- include('utils.pl').
:- include('tests.pl').


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

%Solução com MaxMeals = 4:	Contratar Chefs 2 e 3 e incluir na ementa os pratos 1, 2, 3 e 5
test_solve:- generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium:-	generateMediumAlt(Meals, Chefs, ChefMeals, MealsList), solve(7, Meals, Chefs, ChefMeals, MealsList).


solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-
	
	length(Chefs, LenChefs),
	length(Meals, LenMeals),
	ActualLenMeals #= LenMeals / 2,
	mealsListToDomainsFinal(MealsList, MaxMeals, MealsListFinal),

	nl,
	write(ActualLenMeals), nl,
	write(Meals), nl,
	write(Chefs), nl,
	write(ChefMeals), nl,
	write(MealsListFinal), nl,
	nl,

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
	write(CurrentChefMeals), nl,
	write(PossibleChefMeals), nl,

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
	write('MealsList: '), write(MealsList), nl,
	write('ResChefs: '), write(ResChefs), nl,
	write('ResMeals: '), write(ResMeals), nl,
	write('CurrentChefMeals: '), write(CurrentChefMeals), nl,
	write('PossibleChefMeals: '), write(PossibleChefMeals), nl,
	write('Types: '), write(Types), nl,
	write('Salaries: '), write(SalariesSum), nl,
	write('Meals Profit: '), write(MealsSum), nl,
	write('Total Profit: '), write(Profit), nl
	.

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

