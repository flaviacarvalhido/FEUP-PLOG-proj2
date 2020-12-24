:- use_module(library(clpfd)).
:- use_module(library(lists)).


generateMealsSmall([200, 1, 250, 2, 300, 3, 150, 2, 175, 1]).

generateChefsSmall([4000, 2000, 1000]).

generateChefMealsSmall([1, 2, 3, 3, 2, 0, 1, 5, 4]).

generateMealsListSmall([1-1, 2-1, 3-1]).

generateChefMealsSmallAlt([
						1, 1, 1, 0, 0,
						0, 1, 1, 0, 0,
						1, 0, 0, 1, 1
						]).

generateSmall(Meals, Chefs, ChefMeals, MealsList):-	generateMealsSmall(Meals),
													generateChefsSmall(Chefs),
													generateChefMealsSmall(ChefMeals),
													generateMealsListSmall(MealsList).

generateSmallAlt(Meals, Chefs, ChefMeals, MealsList):-	generateMealsSmall(Meals),
														generateChefsSmall(Chefs),
														generateChefMealsSmallAlt(ChefMeals),
														generateMealsListSmall(MealsList).

getMealsTypes(ResMeals).

sumChefsSalaries(Chefs, ChefIds, SalariesSum):-	scalar_product(Chefs, ChefIds, #=, SalariesSum).

mealsListToDomains([], [], _).
mealsListToDomains([Id-Cardinality|OtherMeals], [Id-NewCard|List], Max):-	NewCard in Cardinality..Max,
																			mealsListToDomains(OtherMeals, List, Max).

mealsListToDomainsFinal(MealsList, Max, MealsListFinal):-	mealsListToDomains(MealsList, TempMealsList, Max),
															A in 0..Max,
															append([0-A], TempMealsList, MealsListFinal).

% Adds a zero after each element of a list (used for performing scalar_product with ResMeals)
buildScalarList([], []).
buildScalarList([H|T], [H, 0|T2]):-	buildScalarList(T, T2).

sumMealsProfit(Meals, MealIds, MealsSum):-	buildScalarList(MealIds, ScalarMealIds),
											scalar_product(Meals, ScalarMealIds, #=, MealsSum).

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

getSubList(_, 0, _, []).
getSubList(_, _, [], []).
getSubList(StartIdx, Len, List, [Head|Tail]):-	Idx #= StartIdx - 1 + Len,
												element(Idx, List, Head),
												Len1 #= Len - 1,
												getSubList(StartIdx, Len1, List, Tail).

getChefMeals(ChefId, ChefMeals, CurrentChefMeals):-	Idx #= ChefId * 3 - 2,
													getSubList(Idx, 3, ChefMeals, TempCurrentChefMeals),
													reverse(TempCurrentChefMeals, CurrentChefMeals).

getChefMealsAlt(LenMeals, ChefId, ChefMeals, CurrentChefMeals):-	Idx #= ChefId * 5 - 4,
																	getSubList(Idx, LenMeals, ChefMeals, TempCurrentChefMeals),
																	reverse(TempCurrentChefMeals, CurrentChefMeals).

getAllChefMeals(_, _, _, 0, AllMeals, AllMeals, ResMeals).
getAllChefMeals(LenMeals, ChefIds, ChefMeals, N, AllMeals, AllMealsFinal, ResMeals):-	
			N > 0,
			element(N, ChefIds, Id),
			getMeals(LenMeals, N, ChefMeals, TempCurrentChefMeals, Res),
			/*Id #= 1 #<=> Res,
			write(Res), nl,
			forceZerosNew(TempCurrentChefMeals, ResMeals, Res),*/
			append(AllMeals, TempCurrentChefMeals, CurrentChefMeals),
			N1 #= N-1,
			getAllChefMeals(LenMeals, ChefIds, ChefMeals, N1, CurrentChefMeals, AllMealsFinal, ResMeals).

getMeals(LenMeals, N, ChefMeals, CurrentChefMeals, 0):-	getChefMealsAlt(LenMeals, N, ChefMeals, CurrentChefMeals).
getMeals(LenMeals, N, ChefMeals, CurrentChefMeals, 1):-	createZerosList(LenMeals, CurrentChefMeals).

createZerosList(0, []).
createZerosList(N, [0|Tail]):-	N > 0, N1 is N-1, createZerosList(N1, Tail).

restrictMeals(ResMeals):-	!.

forceOr([], [], []).
forceOr([H1|T1], [H2|T2], [H3|T3]):-	bool_or([H1, H2], H3),
										forceOr(T1, T2, T3).

forceOr([], [], Val).
forceOr([H1|T1], [H2|T2], Val):-	bool_or([H1, H2], Val),
									forceOr(T1, T2, Val).

forceAnd([], []).
forceAnd([H1|T1], [H2|T2]):-	bool_and([H1, H2], 0),
								forceAnd(T1, T2).

forceXor([], []).
forceXor([H1|T1], [H2|T2]):-	bool_xor([H1, H2], 0),
								forceXor(T1, T2).
forceAndNew([], [], []).
forceAndNew([H1|T1], [H2|T2], [H3|T3]):-	bool_and([H1, H2], 0).

forceZeros([], []).
forceZeros([H1|T1], [H2|T2]):-	(H1 #= 0 -> H2 #= 0; H2 in 0..1),
								forceZeros(T1, T2).

forceZerosNew([], [], _).
forceZerosNew([H1|T1], [H2|T2], 1):-	H1 #= 0 #<=> V,
										Upper #= 1 - V,
										domain([H2], 0, Upper),
										forceZerosNew(T1, T2, 1).
forceZerosNew(_, _, 0).

forceByScalar([], []).
forceByScalar([H1|T1], [H2|T2]):-	Temp #= H1 * H2,
									write(Temp), nl,
									Temp #>= 0,
									forceByScalar(T1, T2).

mealIdsToTypes(_, [], 0, _).
mealIdsToTypes(ResMeals, [Head|OtherTypes], N, Meals):-	N > 0,
														Idx #= N * 2,
														element(N, ResMeals, Id),
														write(Id), nl,
														element(Idx, Meals, Type),
														Id #= 1 #<=> Res,
														Head #= Type * Res,
														N1 #= N - 1,
														mealIdsToTypes(ResMeals, OtherTypes, N1, Meals).

mealIdsToTypesFinal(ResMeals, Types, N, Meals):-	mealIdsToTypes(ResMeals, TempTypes, N, Meals),
													reverse(TempTypes, Types).

testMealIdsToTypes:-	ResMeals = [0, 1, 1, 0, 1],
						Meals = [200, 1, 250, 2, 300, 3, 150, 2, 175, 1],
						mealIdsToTypesFinal(ResMeals, Types, 5, Meals),
						write(Types), nl.

%Solução com MaxMeals = 4:	Contratar Chefs 2 e 3 e incluir na ementa os pratos 1, 2, 3 e 5
test_solve:-	generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(4, Meals, Chefs, ChefMeals, MealsList).

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
	sum(ResChefs, #>, 0), % Contrata-se pelo menos um chef

	getAllChefMeals(ActualLenMeals, ResChefs, ChefMeals, LenChefs, [], CurrentChefMeals, ResMeals),
	%getChefMealsAlt(ActualLenMeals, 1, ChefMeals, CurrentChefMeals),
	write(CurrentChefMeals), nl,
	mealIdsToTypesFinal(ResMeals, Types, ActualLenMeals, Meals),
	global_cardinality(Types, MealsListFinal),




	% Evaluation
	sumChefsSalaries(Chefs, ResChefs, SalariesSum),
	sumMealsProfit(Meals, ResMeals, MealsSum),
	Profit #= MealsSum - SalariesSum,


	% Labeling

	append(ResChefs, ResMeals, Final),
	labeling([maximize(Profit)], Final),
	write('ResChefs: '), write(ResChefs), nl,
	write('ResMeals: '), write(ResMeals), nl,
	write('CurrentChefMeals: '), write(CurrentChefMeals), nl,
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

test_meals_sum:-	Meals = [200, 1, 250, 2, 300, 3, 150, 2, 175, 1],
					ResMeals = [A, B, C, D, E],
					domain(ResMeals, 0, 1),
					sumMealsProfit(Meals, ResMeals, Sum),
					labeling([maximize(Sum)], ResMeals),
					write(ResMeals), nl,
					write(Sum), nl.

test_salary_sum:-	Chefs = [4000, 2000, 1000],
					ResChefs = [A, B, C],
					domain(ResChefs, 0, 1),
					sumChefsSalaries(Chefs, ResChefs, Sum),
					sum(ResChefs, #>, 0),
					labeling([minimize(Sum)], ResChefs),
					write(ResChefs), nl.

new_test:-	Vars = [A, 1, C],
			domain(Vars, 0, 1),
			Vars2 = [D, E, F],
			domain(Vars2, 0, 1),
			forceXor(Vars, Vars2),
			append(Vars, Vars2, Final),
			labeling([], Final),
			write(Vars), nl,
			write(Vars2), nl.

testForceByScalar:-	length(Vars, 3),
					domain(Vars, 0, 1),
					A in 0..1,
					B in 0..1,
					C in 0..1,
					List = [A, B, C],

					forceByScalar(List, Vars),

					sum(Vars, #=, Sum),

					labeling([maximize(Sum)], Vars),
					write(Vars), nl.

testForceZeros:-	length(Vars, 3),
					domain(Vars, 0, 1),
					A in 0..1,
					B in 0..1,
					C in 0..1,
					List = [A, B, C],

					forceZeros(List, Vars),

					sum(Vars, #=, Sum),

					labeling([maximize(A), maximize(Sum)], Vars),
					write(Vars), nl.

testForceOr:-	length(Vars, 3),
				domain(Vars, 0, 1),
				List = [1, 0, 0],

				forceOr(Vars, List),

				sum(Vars, #=, Sum),

				labeling([maximize(Sum)], Vars),
				write(Vars), nl.

testForceAnd:-	length(Vars, 3),
				domain(Vars, 0, 1),
				List = [1, 0, 0],

				forceAnd(Vars, List),

				sum(Vars, #=, Sum),

				labeling([maximize(Sum)], Vars),
				write(Vars), nl.

testGetMeals:-	ChefMeals = [
					1, 1, 1, 0, 0,
					0, 1, 1, 0, 0,
					1, 0, 0, 1, 1
				],
				getMeals(5, 1, ChefMeals, Meals, 1),
				write(Meals), nl.

testGetAllChefMeals:-	ResChefs = [0, 1, 1],
						ChefMeals = [
							1, 1, 1, 0, 0,
							0, 0, 1, 0, 0,
							1, 0, 0, 1, 1
						],
						getAllChefMeals(5, ResChefs, ChefMeals, 3, [0, 0, 0, 0, 0], Meals),
						nl, write(Meals), nl.