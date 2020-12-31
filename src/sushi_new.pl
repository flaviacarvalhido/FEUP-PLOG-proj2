:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- include('problem_generator.pl').
:- include('menus.pl').
:- include('tests.pl').
:- include('fixedChefsProblems.pl').
:- include('fixedMealsProblems.pl').


reset_timer :- statistics(walltime,_).	
print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.

start:- mainMenu; true.

%Solução com MaxMeals = 4:	Contratar Chefs 2 e 3 e incluir na ementa os pratos 1, 2, 3 e 5
test_solve:- generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium:-	generateMediumAlt(Meals, Chefs, ChefMeals, MealsList), solve(7, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium_big:-	generateMediumBig(Meals, Chefs, ChefMeals, MealsList), solve(8, Meals, Chefs, ChefMeals, MealsList).

test_solve_very_big:-	generateVeryBig(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big1:-	generateBig1(Meals, Chefs, ChefMeals, MealsList), solve(15, Meals, Chefs, ChefMeals, MealsList).

test_solve_big2:-	generateBig2(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big3:-	generateBig3(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big4:-	generateBig4(Meals, Chefs, ChefMeals, MealsList), solve(12, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_10:-	fixedChefs10(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_15:-	fixedChefs15(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_20:-	fixedChefs20(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_30:-	fixedChefs30(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_25:-	fixedChefs25(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_40:-	fixedChefs40(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_45:-	fixedChefs45(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_50:-	fixedChefs50(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_5:-	fixedMeals5(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_10:-	fixedMeals10(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_15:-	fixedMeals15(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_20:-	fixedMeals20(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_25:-	fixedMeals25(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_30:-	fixedMeals30(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).



solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-

	reset_timer,

	length(Chefs, LenChefs),
	length(Meals, LenMeals),
	ActualLenMeals #= LenMeals / 2,
	mealsListToDomainsFinal(MealsList, MaxMeals, MealsListFinal),
	%mealsListToDomainsFasterFinal(MealsList, ActualLenMeals, Meals, MealsListFinal),

	nl,	
	/*TODO: make this a separate function, display the lists better*/
	write('---------------------------------------------------Problem input----------------------------------------------------'), nl,nl,
	write('Maximum number of dishes to have: '), write(MaxMeals), nl, nl,
	write('Minimum required number of dishes per type: '), write(MealsList), nl, nl,
	write('List of meals available (profit-type): '), write(Meals), nl,nl,
	write('Total meals available: '), write(ActualLenMeals), nl,nl,
	write('List of chefs available (salary): '), write(Chefs), nl, nl,
	write('List of meals that chefs can cook (length=total of meals * number of chefs, 0=doesn\'t cook, 1=cooks): '), nl, write(ChefMeals), nl, nl,
	write('Types of dishes and their domains: '), write(MealsListFinal), nl,
	nl,
	write('--------------------------------------------------------------------------------------------------------------------'), nl,nl,
	

	write('----------------------------------------------------Processing------------------------------------------------------'), nl,nl,

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

	forceZerosNewNewNew(PossibleChefMeals, ResMeals),
	mealIdsToTypesFinal(ResMeals, Types, ActualLenMeals, Meals),
	global_cardinality(Types, MealsListFinal),
	%myCardinality(MealsList, Types),


	% Evaluation
	sumChefsSalaries(Chefs, ResChefs, SalariesSum),
	sumMealsProfit(Meals, ResMeals, MealsSum),
	Profit #= MealsSum - SalariesSum,


	% Labeling
	append(ResChefs, ResMeals, Final),
	labeling([maximize(Profit)], Final),

	print_time,
	/*
	fd_statistics,
	write('ResChefs: '), write(ResChefs), nl,
	write('ResMeals: '), write(ResMeals), nl,
	write('Salaries: '), write(SalariesSum), nl,
	write('Meals Profit: '), write(MealsSum), nl,
	write('Total Profit: '), write(Profit), nl
	*/


	write('-------------------------------------------------Problem solution---------------------------------------------------'), nl,nl,
	% write('MealsList: '), write(MealsList), nl,
	write('Chefs to be hired (0-not hired, 1-hired): '), write(ResChefs), nl,nl,
	write('Meals to be included in the menu (0-don\'t include, 1-include): '), write(ResMeals), nl,nl,
	% write('CurrentChefMeals: '), write(CurrentChefMeals), nl,
	% write('PossibleChefMeals: '), write(PossibleChefMeals), nl,
	write('Food types available: '), write(Types), nl,nl,
	write('Total salary ammount to pay: '), write(SalariesSum), nl, nl,
	write('Total montly meal profit: '), write(MealsSum), nl, nl,
	write('Overall profit: '), write(Profit), nl, nl,
	write('--------------------------------------------------------------------------------------------------------------------')
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

