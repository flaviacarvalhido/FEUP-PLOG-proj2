:- use_module(library(clpfd)).
:- use_module(library(lists)).


generateMealsSmall([200, 1, 250, 2, 300, 3, 150, 2, 175, 1]).

generateChefsSmall([500, 700, 500]).

generateChefMealsSmall([1, 2, 3, 3, 2, 0, 1, 5, 4]).

generateMealsListSmall([1-1, 2-1, 3-1]).

generateChefMealsSmallAlt([
						1, 0, 0, 0, 0,
						0, 0, 1, 1, 0,
						0, 1, 1, 0, 0
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

multiplyList([], [], _).
multiplyList([H1|T1], [H2|T2], Val):-	H2 #= H1 * Val,
										multiplyList(T1, T2, Val).

getAllChefMeals(_, _, _, 0, AllMeals, AllMeals).
getAllChefMeals(LenMeals, ChefIds, ChefMeals, N, AllMeals, AllMealsFinal):-	
			N > 0,
			element(N, ChefIds, Id),
			Id #= 1 #<=> Res,
			/*Id #= 0 #=> Flag #= 0,
			Id #= 1 #=> Flag #= 1,*/
			write('Res: '), write(Res), nl,
			write('Flag: '), write(Flag), nl,
			getChefMealsAlt(LenMeals, N, ChefMeals, TempCurrentChefMeals),
			%getMeals(LenMeals, N, ChefMeals, TempCurrentChefMeals, Res),
			write('Meals Before: '), write(TempCurrentChefMeals), nl,
			multiplyList(TempCurrentChefMeals, NewTempCurrentChefMeals, Res),
			write('Meals: '), write(NewTempCurrentChefMeals), nl,
			/*Id #= 1 #<=> Res,
			write(Res), nl,*/
			%forceZerosNewNew(TempCurrentChefMeals, ResMeals),
			%forceOr(AllMeals, NewTempCurrentChefMeals, CurrentChefMeals),
			append(AllMeals, NewTempCurrentChefMeals, CurrentChefMeals),
			N1 #= N-1,
			getAllChefMeals(LenMeals, ChefIds, ChefMeals, N1, CurrentChefMeals, AllMealsFinal).

getMeals(LenMeals, N, ChefMeals, CurrentChefMeals, 1):-	getChefMealsAlt(LenMeals, N, ChefMeals, CurrentChefMeals).
getMeals(LenMeals, N, ChefMeals, CurrentChefMeals, 0):-	createZerosList(LenMeals, CurrentChefMeals).

forceOrSingleListPos(_, [], _, 0).
forceOrSingleListPos(List1, [H1|T1], LenMeals, N):-	length(List1, Len),
													ActualLen #= Len / LenMeals, 
													actuallyForceOr(List1, 0, H1, ActualLen, N, LenMeals),
													N1 #= N - 1,
													forceOrSingleListPos(List1, T1, LenMeals, N1).

actuallyForceOr(_, Res, Res, 0, _, _).
actuallyForceOr(List1, Res, FinalRes, N, Idx, LenMeals):-	ActualIdx #= LenMeals * (N-1) + Idx,
															element(ActualIdx, List1, Elem),
															bool_or([Elem, Res], TempRes),
															N1 #= N - 1,
															actuallyForceOr(List1, TempRes, FinalRes, N1, Idx, LenMeals).

forceOrOnBigList(List, ResList, LenMeals):-	forceOrSingleListPos(List, TempResList, LenMeals, LenMeals),
											reverse(TempResList, ResList).


forceOrSingleListPosNew(_, [], _, 0).
forceOrSingleListPosNew(List1, [H1|T1], LenMeals, N):-	length(List1, Len),
														ActualLen #= Len / LenMeals, 
														actuallyForceOrNew(List1, 0, H1, ActualLen, N, LenMeals),
														N1 #= N - 1,
														forceOrSingleListPosNew(List1, T1, LenMeals, N1).

actuallyForceOrNew(_, Res, Res, 0, _, _).
actuallyForceOrNew(List1, Res, FinalRes, N, Idx, LenMeals):-	ActualIdx #= LenMeals * (N-1) + Idx,
																element(ActualIdx, List1, Elem),
																myOr(Elem, Res, TempRes),
																N1 #= N - 1,
																actuallyForceOrNew(List1, TempRes, FinalRes, N1, Idx, LenMeals).

forceOrOnBigListNew(List, ResList, LenMeals):-	forceOrSingleListPosNew(List, TempResList, LenMeals, LenMeals),
												reverse(TempResList, ResList).

testActuallyForceOr:-	List = [1, 0, 0, 0, 0, 0, 0, 1, 0],
						actuallyForceOr(List, 0, Res, 3, 1, 3),
						write(Res), nl.

testActuallyForceOrNew:-	List = [1,0,0,1,1,0,0,0,0,0,0,0,0,0,0],
							forceOrOnBigList(List, ResListFinal, 5),
							write(ResListFinal), nl.

getPossibleMeals(LenMeals, AllMeals):- !.	

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

forceZerosNew([], []).
forceZerosNew([H1|T1], [H2|T2]):-	H1 #= 0 #<=> V,
										Upper #= 1 - V,
										domain([H2], 0, Upper),
										forceZerosNew(T1, T2, 1).

forceZerosNewNew([], []).
forceZerosNewNew([H1|T1], [H2|T2]):-	H1 #= 1 #<=> Res,
										(Res #= 1 -> write('nothing'), nl; H2 #= 0),
										forceZerosNewNew(T1, T2).

forceZerosNewNewNew([], []).
forceZerosNewNewNew([H1|T1], [H2|T2]):-	H1 #= 0 #=> H2 #\= 1,
										forceZerosNewNewNew(T1, T2).

forceByScalar([], []).
forceByScalar([H1|T1], [H2|T2]):-	Temp #= H1 * H2,
									write(Temp), nl,
									Temp #>= 0,
									forceByScalar(T1, T2).

myOr(Val1, Val2, Res):- Val1 #= 0 #<=> Res1, Val2 #= 0 #<=> Res2, Res #= 1 - (Res1 * Res2), write(Res), nl.

listOr([], [], []).
listOr([H1|T1], [H2|T2], [H3|T3]):- myOr(H1, H2, H3), listOr(T1, T2, T3).

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
test_solve:-	generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).

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

					ListNew = [1, 1, 1],

					Weights = [1000, 2000, 500],

					forceZerosNewNewNew(ListNew, Vars),

					sum(Vars, #=, 2),
					scalar_product(Weights, Vars, #=, Scalar),

					append(List, Vars, Final),
					labeling([minimize(Scalar)], Final),
					write(Vars), nl,
					write(A), nl,
					write(B), nl,
					write(C), nl,
					write(Scalar).

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
							1, 0, 0, 0, 1
						],
						getAllChefMeals(5, ResChefs, ChefMeals, 3, [0, 0, 0, 0, 0], Meals),
						nl, write(Meals), nl.