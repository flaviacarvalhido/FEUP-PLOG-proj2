getMealsTypes(_).

sumChefsSalaries(Chefs, ChefIds, SalariesSum):-	scalar_product(Chefs, ChefIds, #=, SalariesSum).

mealsListToDomains([], [], _).
% porquê isto da cardinalidade dos pratos?  o que é que estas duas funções estão a fazer? 
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

getSubList(_, 0, _, []).
getSubList(_, _, [], []).
getSubList(StartIdx, Len, List, [Head|Tail]):-	Idx #= StartIdx - 1 + Len,
												element(Idx, List, Head),
												Len1 #= Len - 1,
												getSubList(StartIdx, Len1, List, Tail).

getChefMeals(ChefId, ChefMeals, CurrentChefMeals):-	Idx #= ChefId * 3 - 2,
													getSubList(Idx, 3, ChefMeals, TempCurrentChefMeals),
													reverse(TempCurrentChefMeals, CurrentChefMeals).

getChefMealsAlt(LenMeals, ChefId, ChefMeals, CurrentChefMeals):-	Constant #= LenMeals - 1,
																	Idx #= ChefId * LenMeals - Constant,
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

createZerosList(0, []).
createZerosList(N, [0|Tail]):-	N > 0, N1 is N-1, createZerosList(N1, Tail).

restrictMeals(_):-	!.

forceOr([], [], []).
forceOr([H1|T1], [H2|T2], [H3|T3]):-	bool_or([H1, H2], H3),
										forceOr(T1, T2, T3).

forceOr([], [], _).
forceOr([H1|T1], [H2|T2], Val):-	bool_or([H1, H2], Val),
									forceOr(T1, T2, Val).

forceAnd([], []).
forceAnd([H1|T1], [H2|T2]):-	bool_and([H1, H2], 0),
								forceAnd(T1, T2).

forceXor([], []).
forceXor([H1|T1], [H2|T2]):-	bool_xor([H1, H2], 0),
								forceXor(T1, T2).
forceAndNew([], [], []).
forceAndNew([H1|_], [H2|_], [_|_]):-	bool_and([H1, H2], 0).

forceZeros([], []).
forceZeros([H1|T1], [H2|T2]):-	(H1 #= 0 -> H2 #= 0; H2 in 0..1),
								forceZeros(T1, T2).

forceZerosNew([], [], _).
forceZerosNew([H1|T1], [H2|T2], 1):-	H1 #= 0 #<=> V,
										Upper #= 1 - V,
										domain([H2], 0, Upper),
										forceZerosNew(T1, T2, 1).
forceZerosNew(_, _, 0).

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

getPossibleMeals(LenMeals, AllMeals):- !.	
