:- use_module(library(between)).

/*
 * countOccurences(+TargetType, +Types, -Count)
 *
 * Counts the number of times TargetType appears in the list Types
 *
 */
countOccurrences(_, [], 0).
countOccurrences(TargetType, [Type|OtherTypes], Count):-	Type #= TargetType #<=> Res,
															Count #= CountNew + Res,
															countOccurrences(TargetType, OtherTypes, CountNew).

/*
 * myCardinality(+Cardinalities, +Types)
 *
 * Forces the list types to have at least Xi elements equal to i.
 * Cardinalities is a list with the format [i-Xi, i1-Xi1, ...]
 *
 */
myCardinality([], _).
myCardinality([Type-Cardinality|OtherCardinalities], Types):-	countOccurrences(Type, Types, Count),
																Count #>= Cardinality,
																myCardinality(OtherCardinalities, Types).

/*
 * sumChefsSalaries(+Chefs, +ChefIds, -SalariesSum)
 *
 * Calculates the total salaries of the chefs.
 * Chefs is the list of salaries of each chef and ChefIds is the list with the selected chefs.
 *
 */
sumChefsSalaries(Chefs, ChefIds, SalariesSum):-	scalar_product(Chefs, ChefIds, #=, SalariesSum).

/*
 * mealsListToDomains(+MealsList, -NewMealsList, +Max)
 *
 * Converts a list of format [Type-Cardinality, ...] to a list of format [Type-Domain, ...], where Domain is in Cardinality..Max
 *
 */
mealsListToDomains([], [], _).
mealsListToDomains([Id-Cardinality|OtherMeals], [Id-NewCard|List], Max):-	NewCard in Cardinality..Max,
																			mealsListToDomains(OtherMeals, List, Max).

/*
 * mealsListToDomainFinal(+MealsList, +Max, -MealsListFinal)
 *
 * After getting the MealsList converted to a domains list, adds an entry for type 0 to that list
 *
 */
mealsListToDomainsFinal(MealsList, Max, MealsListFinal):-	mealsListToDomains(MealsList, TempMealsList, Max),
															A in 0..Max,
															append([0-A], TempMealsList, MealsListFinal).

/*
 * calculateUpperBound(+MealsList, +TargetId, -ToSubtract)
 *
 * Calculates the upper bound for the domain of a certain type in the cardinalities list
 *
 */
calculateUpperBound([], _, 0).
calculateUpperBound([Id-Cardinality|OtherIdsCardinalities], TargetId, ToSubtract):-	Id #\= TargetId #<=> Res,
																					calculateUpperBound(OtherIdsCardinalities, TargetId, ToSubtractNew),
																					ToSubtract #= ToSubtractNew + Cardinality * Res.

/*
 * countTypeOccurences(+Types, +TargetType, -Occurences)
 *
 * Counts the number of times TargetType appears in the list Types
 *
 */
countTypeOccurences([], _, 0).
countTypeOccurences([Profit, Type|OtherMeals], TargetType, Occurences):-	Type #= TargetType #<=> Res,
																			countTypeOccurences(OtherMeals, TargetType, OccurencesNew),
																			Occurences #= OccurencesNew + Res.

/*
 * mealsListToDomainsFaster(+MealsList, -NewMealsList, +Meals)
 *
 * Converts a list of format [Type-Cardinality, ...] to a list of format [Type-Domain, ...], where Domain is in Cardinality..MaxNumberOfTimesTypeCanAppear
 *
 */
mealsListToDomainsFaster([], [], _).
mealsListToDomainsFaster([Id-Cardinality|OtherMeals], [Id-NewCard|List], Meals):-	countTypeOccurences(Meals, Id, NumberOfOccurences),
																					NewCard in Cardinality..NumberOfOccurences,
																					mealsListToDomainsFaster(OtherMeals, List, Meals).

/*
 * mealsListToDomainsFasterFinal(+MealsList, +Max, +Meals, -MealsListFinal)
 *
 * After getting the MealsList converted to a domains list, adds an entry for type 0 to that list
 *
 */
mealsListToDomainsFasterFinal(MealsList, Max, Meals, MealsListFinal):-	mealsListToDomainsFaster(MealsList, TempMealsList, Meals),
																		calculateUpperBound(MealsList, 0, ToSubtract),
																		UpperBound #= Max - ToSubtract,
																		A in 0..UpperBound,
																		append([0-A], TempMealsList, MealsListFinal).

/*
 * buildScalarList(+List, -ScalarList)
 *
 * Adds a zero after each element of a list (used for performing scalar_product with ResMeals)
 *
 */
buildScalarList([], []).
buildScalarList([H|T], [H, 0|T2]):-	buildScalarList(T, T2).

/*
 * sumMealsProfit(+Meals, +MealIds, -MealsSum)
 *
 * Calculates the total expected meals profit
 *
 */
sumMealsProfit(Meals, MealIds, MealsSum):-	buildScalarList(MealIds, ScalarMealIds),
											scalar_product(Meals, ScalarMealIds, #=, MealsSum).

/*
 * getSubList(+StartIdx, +Len, +List, -SubList)
 *
 * Gets a sublist of List, starting at StartIdx and with length Len
 *
 */
getSubList(_, 0, _, []).
getSubList(_, _, [], []).
getSubList(StartIdx, Len, List, [Head|Tail]):-	Idx #= StartIdx - 1 + Len,
												element(Idx, List, Head),
												Len1 #= Len - 1,
												getSubList(StartIdx, Len1, List, Tail).

/*
 * getChefMealsAlt(+LenMeals, +ChefId, +ChefMeals, -CurrentChefMeals)
 *
 * Gets the meals that the chef with id ChefId can cook
 *
 */
getChefMealsAlt(LenMeals, ChefId, ChefMeals, CurrentChefMeals):-	Constant #= LenMeals - 1,
																	Idx #= ChefId * LenMeals - Constant,
																	getSubList(Idx, LenMeals, ChefMeals, TempCurrentChefMeals),
																	reverse(TempCurrentChefMeals, CurrentChefMeals).

/*
 * multiplyList(+List1, -List2, +Val)
 *
 * Returns a list that results from the multiplication of Val to every member of List
 * 
 * Example:
 * multiplyList([1, 2, 3], List, 0) => List = [0, 0, 0]
 *
 */
multiplyList([], [], _).
multiplyList([H1|T1], [H2|T2], Val):-	H2 #= H1 * Val,
										multiplyList(T1, T2, Val).

/*
 * getAllChefMeals(+LenMeals, +ChefIds, +ChefMeals, +N, +AllMeals, -AllMealsFinal)
 *
 * Gets the meals of all the selected chefs, represented in ChefIds
 *
 */
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

/*
 * forceOrSinglePos(+List1, -List2, LenMeals, N)
 *
 * Performs a boolean or on list, split in LenMeals elements
 * 
 * Example:
 * forceOrOnSigleListPos([1, 0, 0, 1, 0, 1], List2, 2, 2)=> List = [1 or 0 or 0, 0 or 1 or 1] => List = [1, 1]
 *
 */
forceOrSingleListPos(_, [], _, 0).
forceOrSingleListPos(List1, [H1|T1], LenMeals, N):-	length(List1, Len),
													ActualLen #= Len / LenMeals, 
													actuallyForceOr(List1, 0, H1, ActualLen, N, LenMeals),
													N1 #= N - 1,
													forceOrSingleListPos(List1, T1, LenMeals, N1).

/*
 * actuallyForceOr(+List1, +Res, -FinalRes, +N, +Idx, +LenMeals)
 *
 * Performs a boolean or between elements of the same list
 *
 * Example:
 * actuallyForceOr([1, 0, 0, 1], 0, Res, 2, 1, 2) => Res = 1 or 0 => Res = 1
 *
 */
actuallyForceOr(_, Res, Res, 0, _, _).
actuallyForceOr(List1, Res, FinalRes, N, Idx, LenMeals):-	ActualIdx #= LenMeals * (N-1) + Idx,
															element(ActualIdx, List1, Elem),
															myOr(Elem, Res, TempRes),
															N1 #= N - 1,
															actuallyForceOr(List1, TempRes, FinalRes, N1, Idx, LenMeals).

/*
 * forceOrOnBigList(+List, -ResList, +LenMeals)
 *
 * Performs a boolean or on a list, split by LenMeals elements
 *
 */
forceOrOnBigList(List, ResList, LenMeals):-	forceOrSingleListPos(List, TempResList, LenMeals, LenMeals),
											reverse(TempResList, ResList).

/*
 * forceZeros(+List1, +List2)
 *
 * Forces List2 to have 0s where List1 also has 0s. The other elements can be either 1 or 0
 *
 */
forceZeros([], []).
forceZeros([H1|T1], [H2|T2]):-	H1 #= 0 #=> H2 #\= 1,
								forceZeros(T1, T2).

/*
 * myOr(+Val1, +Val2, -Res)
 *
 * Performs a boolean or between Val1 and Val2
 *
 */
myOr(Val1, Val2, Res):- Val1 #= 0 #<=> Res1, Val2 #= 0 #<=> Res2, Res #= 1 - (Res1 * Res2).

/*
 * mealIdsToTypes(+ResMeals, -Types, +N, +Meals)
 *
 * Gets a reversed flist with the types of the selected meals, represented in ResMeals
 *
 */
mealIdsToTypes(_, [], 0, _).
mealIdsToTypes(ResMeals, [Head|OtherTypes], N, Meals):-	N > 0,
														Idx #= N * 2,
														element(N, ResMeals, Id),
														element(Idx, Meals, Type),
														Id #= 1 #<=> Res,
														Head #= Type * Res,
														N1 #= N - 1,
														mealIdsToTypes(ResMeals, OtherTypes, N1, Meals).

/*
 * mealIdsToTypes(+ResMeals, -Types, +N, +Meals)
 *
 * Gets a list with the types of the selected meals, represented in ResMeals
 *
 */
mealIdsToTypesFinal(ResMeals, Types, N, Meals):-	mealIdsToTypes(ResMeals, TempTypes, N, Meals),
													reverse(TempTypes, Types).




%Menu Utils

/*
 * getInputAndValidate(+Low, +High, -Input)
 *
 * Asks the user for input and then verifies if it is in the interval [Low, High]
 *
 */
getInputAndValidate(Low, High, Input):- write('Your choice: '), nl, read(Input), skip_line, integer(Input),
										between(Low, High, Input).
getInputAndValidate(Low, High, Input):- write('Incorrect Selection'), nl, getInputAndValidate(Low, High, Input).


/*
 * clearConsole/0
 *
 * Clears the Sicstus console.
 *
 */
clearConsole :- write('\33\[2J').
