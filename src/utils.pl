
countOccurrences(_, [], 0).
countOccurrences(TargetType, [Type|OtherTypes], Count):-	Type #= TargetType #<=> Res,
															Count #= CountNew + Res,
															countOccurrences(TargetType, OtherTypes, CountNew).

myCardinality([], _).
myCardinality([Type-Cardinality|OtherCardinalities], Types):-	countOccurrences(Type, Types, Count),
																Count #>= Cardinality,
																myCardinality(OtherCardinalities, Types).

sumChefsSalaries(Chefs, ChefIds, SalariesSum):-	scalar_product(Chefs, ChefIds, #=, SalariesSum).

mealsListToDomains([], [], _).
mealsListToDomains([Id-Cardinality|OtherMeals], [Id-NewCard|List], Max):-	NewCard in Cardinality..Max,
																			mealsListToDomains(OtherMeals, List, Max).

mealsListToDomainsFinal(MealsList, Max, MealsListFinal):-	mealsListToDomains(MealsList, TempMealsList, Max),
															A in 0..Max,
															append([0-A], TempMealsList, MealsListFinal).

calculateUpperBound([], _, 0).
calculateUpperBound([Id-Cardinality|OtherIdsCardinalities], TargetId, ToSubtract):-	Id #\= TargetId #<=> Res,
																					calculateUpperBound(OtherIdsCardinalities, TargetId, ToSubtractNew),
																					ToSubtract #= ToSubtractNew + Cardinality * Res.

countTypeOccurences([], _, 0).
countTypeOccurences([Profit, Type|OtherMeals], TargetType, Occurences):-	Type #= TargetType #<=> Res,
																			countTypeOccurences(OtherMeals, TargetType, OccurencesNew),
																			Occurences #= OccurencesNew + Res.

mealsListToDomainsFaster([], [], _).
mealsListToDomainsFaster([Id-Cardinality|OtherMeals], [Id-NewCard|List], Meals):-	countTypeOccurences(Meals, Id, NumberOfOccurences),
																					write('Occurences: '), write(NumberOfOccurences), nl,
																					write('Type: '), write(Id), nl,
																					NewCard in Cardinality..NumberOfOccurences,
																					write('NewCard: '), write(Cardinality), write('..'), write(NumberOfOccurences), nl,
																					mealsListToDomainsFaster(OtherMeals, List, Meals).

mealsListToDomainsFasterFinal(MealsList, Max, Meals, MealsListFinal):-	mealsListToDomainsFaster(MealsList, TempMealsList, Meals),
																		calculateUpperBound(MealsList, 0, ToSubtract),
																		UpperBound #= Max - ToSubtract,
																		A in 0..UpperBound,
																		write('A: '), write(UpperBound), nl,
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
			getChefMealsAlt(LenMeals, N, ChefMeals, TempCurrentChefMeals),
			multiplyList(TempCurrentChefMeals, NewTempCurrentChefMeals, Res),
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

myOr(Val1, Val2, Res):- Val1 #= 0 #<=> Res1, Val2 #= 0 #<=> Res2, Res #= 1 - (Res1 * Res2).

listOr([], [], []).
listOr([H1|T1], [H2|T2], [H3|T3]):- myOr(H1, H2, H3), listOr(T1, T2, T3).

mealIdsToTypes(_, [], 0, _).
mealIdsToTypes(ResMeals, [Head|OtherTypes], N, Meals):-	N > 0,
														Idx #= N * 2,
														element(N, ResMeals, Id),
														element(Idx, Meals, Type),
														Id #= 1 #<=> Res,
														Head #= Type * Res,
														N1 #= N - 1,
														mealIdsToTypes(ResMeals, OtherTypes, N1, Meals).

mealIdsToTypesFinal(ResMeals, Types, N, Meals):-	mealIdsToTypes(ResMeals, TempTypes, N, Meals),
													reverse(TempTypes, Types).

getPossibleMeals(LenMeals, AllMeals):- !.	
