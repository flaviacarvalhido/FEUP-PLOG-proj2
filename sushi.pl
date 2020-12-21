:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).


/*

	Cozinheiros - recebem X de salário, cozinham apenas certos pratos
	Pratos - X lucro médio mensal esperado, Y tipo
	Menu - tem que ter pelo menos Xi pratos do tipo i e NMaxPratos pratos no maximo


	Tipos de prato:
	1 - nigiri
	2 - maki
	3 - sashimi
	4 - uramaki
	5 - temaki
	6 - rolls

	Prato - [id, lucro, tipo]

	Cozinheiro - [id, salario, [ids dos pratos]]

	Lista salários cozinheiros (id é o index)
	Lista de listas com os pratos de cada cozinheiro


	Ex:
	[4000, 2000, 1000]
	[[1, 2, 3], [3, 2], [1, 5, 6]]

	Cozinheiro 1 - 4000 de salario, cozinha pratos 1, 2 e 3

	Pratos: (lucro, tipo)
	[[200, 1], [400, 1]]

*/

generateMealsSmall([200, 1, 250, 2, 300, 3, 150, 2, 175, 1]).

generateChefsSmall([4000, 2000, 1000]).

generateChefMealsSmall([1, 2, 3, 3, 2, 0, 1, 5, 4]).

generateMealsListSmall([1-1, 2-1, 3-1]).

generateSmall(Meals, Chefs, ChefMeals, MealsList):-	generateMealsSmall(Meals),
													generateChefsSmall(Chefs),
													generateChefMealsSmall(ChefMeals),
													generateMealsListSmall(MealsList).

chefIdsToSalaries([], [], _).
%chefIdsToSalaries([Id|OtherIds], [Salary|OtherSalaries], Chefs):-	Id #= 0, Salary #= 9999, /*write('00000'), nl, */chefIdsToSalaries(OtherIds, OtherSalaries, Chefs).
chefIdsToSalaries([Id|OtherIds], [Salary|OtherSalaries], Chefs):-	element(Id, Chefs, Salary),
																	chefIdsToSalaries(OtherIds, OtherSalaries, Chefs).

sumChefsSalaries(Chefs, ChefIds, Sum):-	chefIdsToSalaries(ChefIds, Salaries, Chefs),
										sum(Salaries, #=, Sum).


mealsListToDomains([], [], _).
mealsListToDomains([Id-Cardinality|OtherMeals], [Id-NewCard|List], Max):-	NewCard in Cardinality..Max,
																			mealsListToDomains(OtherMeals, List, Max).

/* 														mealsListToDomains(MealsList, MealsListFinal, MaxMeals),
														global_cardinality(ResMeals, MealsListFinal), */

mealIdsToProfit([], [], _).
mealIdsToProfit([MealId|OtherMealIds], [Profit|OtherProfits], Meals):-	Idx #= MealId * 2 - 1,
																		element(Idx, Meals, Profit),
																		mealIdsToProfit(OtherMealIds, OtherProfits, Meals).

sumMealsProfit(MealIds, Meals, Sum):-	mealIdsToProfit(MealIds, Profits, Meals),
										sum(Profits, #=, Sum).

mealIdsToType([], _, []).
mealIdsToType([MealId|OtherMealIds], Meals, [Type|OtherTypes]):-	Idx #= MealId * 2,
																	element(Idx , Meals, Type),
																	mealIdsToType(OtherMealIds, Meals, OtherTypes).

ensureMeals(_, _, _, 0).
ensureMeals(Idx, ChefMeals, ResMeals, N):-	CurrentIdx #= Idx + N,
											element(CurrentIdx, ChefMeals, Meal),
											count(Meal, ResMeals, #>, 0),
											N1 is N - 1,
											ensureMeals(Idx , ChefMeals, ResMeals, N1).

ensureChefMealsOnly([], _, _).
ensureChefMealsOnly([ChefId|OtherChefIds], ChefMeals, ResMeals):-	Idx #= ChefId * 3 - 3,
																	ensureMeals(Idx, ChefMeals, ResMeals, 3),
																	ensureChefMealsOnly(OtherChefIds, ChefMeals, ResMeals).

getMeals(_, _, [], 0).
getMeals(Idx, ChefMeals, [Meal|Meals], N):-	ActualIdx #= Idx - N,
											element(ActualIdx, ChefMeals, Meal),
											Meal #\= 0, !,
											N1 is N - 1,
											getMeals(Idx, ChefMeals, Meals, N1).
getMeals(_, _, [], _).

getChefsMeals([], _, Meals, MealsFinal):-	sort(Meals, MealsFinal).
getChefsMeals([ChefId|OtherChefIds], ChefMeals, Meals, MealsFinal):-	Idx #= ChefId * 3 + 1,
																		getMeals(Idx, ChefMeals, TempMeals, 3),
																		append(Meals, TempMeals, NewMeals),
																		getChefsMeals(OtherChefIds, ChefMeals, NewMeals, MealsFinal).



solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-	length(Chefs, LenChefs),
														length(Meals, TempLenMeals),
														LenMeals #= TempLenMeals / 2,
														mealsListToDomains(MealsList, MealsListFinal, MaxMeals),


														% Decision Variables
														length(ResChefs, LenChefs),
														domain(ResChefs, 1, LenChefs),
														length(ResMeals, MaxMeals),
														domain(ResMeals, 1, LenMeals),


														% Restrictions
														all_distinct_except_0(ResChefs),
														mealIdsToType(ResMeals, Meals, Types),
														global_cardinality(Types, MealsListFinal),
														%ensureChefMealsOnly(ResChefs, ChefMeals, ResMeals),
														getChefsMeals(ResChefs, ChefMeals, [], CookMeals),
														mealIdsToType(CookMeals, Meals, CookTypes),
														%global_cardinality(CookTypes, MealsListFinal),

														% Evaluation
														sumChefsSalaries(Chefs, ResChefs, SalariesSum),
														sumMealsProfit(ResMeals, Meals, MealsSum),
														Profit #= MealsSum - SalariesSum,


														%Labeling
														append(ResChefs, ResMeals, Final),
														%labeling([maximize(MealsSum)], ResMeals),
														%labeling([maximize(MealsSum), minimize(SalariesSum)], Final),
														labeling([maximize(Profit)], Final),
														%labeling([minimize(SalariesSum)], ResChefs),
														%labeling([], ResMeals),
														write(ResChefs), nl,
														write(Profit), nl,
														write(ResMeals), nl,
														write(MealsSum), nl,
														write(SalariesSum), nl
														.



test_solve:- generateSmall(Meals, Chefs, ChefMeals, MealsList), solve(9, Meals, Chefs, ChefMeals, MealsList).

/*
generateMealsSmall([[1, 400, 1], [2, 450, 2], [3, 385, 2], [4, 287, 1]]).

generateChefsSmall([[1, 1000, [4, 3]], [2, 1200, [1, 2, 3]]]).

generateMealsListSmall([1-1, 2-1]).

getChef(Id, [CurrentChef|OtherChefs], CurrentChef):- 	nth0(0, CurrentChef, CurrentChefId),
														Id == CurrentChefId.
getChef(Id, [_|OtherChefs], Chef):-	getChef(Id, OtherChefs, Chef).

getMeal(Id, [CurrentMeal|OtherMeals], CurrentMeal):-	nth0(0, CurrentMeal, CurrentMealId),
														Id == CurrentMealId.
getMeal(Id, [_|OtherMeals], Meal):-	getMeal(Id, OtherMeals, Meal).

getSalaries([ChefId|OtherChefsIds], Chefs):-	getChef(ChefId, Chefs, Chef).

mealsListToDomains([], []).
mealsListToDomains([Id-Cardinality|OtherMeals], [Id-NewCard|List]):-	NewCard in Cardinality..10, mealsListToDomains(OtherMeals, List).
*/


/*
sushi(NMaxPratos, MealsList, Chefs, Meals):-	length(Meals, LenMeals),
												LastIdMeals is LenMeals + 1,
												length(ResMeals, NMaxPratos),
												domain(ResMeals, 1, LastIdMeals),
												%all_distinct(ResMeals),
												length(Chefs, LenChefs),
												LastIdChefs is LenChefs + 1,
												length(ResChefs, LenChefs),
												domain(ResChefs, 1, LastIdChefs),
												all_distinct(ResChefs),


												mealsListToDomains(MealsList, MealsListDomains),
												write(MealsListDomains), nl,
												global_cardinality(ResMeals, MealsListDomains),


												labeling([], ResMeals),



												labeling([], ResChefs),
												write(ResMeals), nl,
												write(ResChefs), nl
												.
*/
/*
sushi(NMaxPratos, MealsList, Chefs, Meals):-	length(Chefs, LenChefs),
												LastIdChefs is LenChefs + 1,
												length(ResChefs, LenChefs),
												domain(ResChefs, 1, LastIdChefs),
												all_distinct(ResChefs),
												labeling([], ResChefs),
												write(ResChefs), nl
												.
*/

%test:- generateChefsSmall(Chefs), generateMealsSmall(Meals), generateMealsListSmall(MealsList), sushi(4, MealsList, Chefs, Meals).