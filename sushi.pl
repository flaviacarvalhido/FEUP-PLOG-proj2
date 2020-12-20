:- use_module(library(clpfd)).
:- use_module(library(lists)).


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

generateMealsSmall([[200, 1], [250, 2], [300, 3], [150, 2], [175, 1]]).

generateChefsSmall([4000, 2000, 1000]).

generateChefMealsSmall([[1, 2, 3], [3, 2], [1, 5, 4]]).

generateMealsListSmall([1-1, 2-1]).

generateSmall(Meals, Chefs, ChefMeals):-	generateMealsSmall(Meals),
											generateChefsSmall(Chefs),
											generateChefMealsSmall(ChefMeals).

chefIdsToSalaries([], [], _).
chefIdsToSalaries([Id|OtherIds], [Salary|OtherSalaries], Chefs):-	element(Id, Chefs, Salary),
																	chefIdsToSalaries(OtherIds, OtherSalaries, Chefs).

sumChefsSalaries(Chefs, ChefIds, Sum):-	chefIdsToSalaries(ChefIds, Salaries, Chefs),
										sum(Salaries, #=, Sum).

solve(Meals, Chefs, ChefMeals):-	length(Chefs, LenChefs),
							
									% Decision Variables
									length(ResChefs, LenChefs),
									domain(ResChefs, 1, LenChefs),


									% Restrictions
									all_distinct(ResChefs),


									% Evaluation
									sumChefsSalaries(Chefs, ResChefs, Sum),


									%Labeling
									labeling([minimize(Sum)], ResChefs),
									write(ResChefs), nl,
									write(Sum), nl
									.



test_solve:- generateSmall(Meals, Chefs, ChefMeals), solve(Meals, Chefs, ChefMeals).

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