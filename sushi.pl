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

/*
	ResChefs - lista de 0s e 1s
	ResMeals - lista de 0s e 1s
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
chefIdsToSalaries([Id|OtherIds], [Salary|OtherSalaries], Chefs):-	element(Id, Chefs, Salary),
																	chefIdsToSalaries(OtherIds, OtherSalaries, Chefs).
chefIdsToSalaries([Id|OtherIds], [Salary|OtherSalaries], Chefs):-	Id #= 0, Salary #= 99999,
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
/*
ensureChefMealsOnly([], _, _).
ensureChefMealsOnly([ChefId|OtherChefIds], ChefMeals, ResMeals):-	Idx #= ChefId * 3 - 3,
																	ensureMeals(Idx, ChefMeals, ResMeals, 3),
																	ensureChefMealsOnly(OtherChefIds, ChefMeals, ResMeals).
*/
getMeals(_, _, _, 0).
getMeals(Idx, ChefMeals, [Meal|Meals], N):-	N >= 0,
											ActualIdx #= Idx - N,
											element(ActualIdx, ChefMeals, TempMeal),
											TempMeal #\= 0, !,
											Meal #= TempMeal,
											N1 is N - 1,
											getMeals(Idx, ChefMeals, Meals, N1).
getMeals(_, _, _, _).

getChefsMeals([], _, _):- !.
getChefsMeals([ChefId|OtherChefIds], ChefMeals, [Meal1, Meal2, Meal3|Meals]):-	Idx #= ChefId * 3 + 1,
															getMeals(Idx, ChefMeals, [Meal1, Meal2, Meal3], 3), !,
															getChefsMeals(OtherChefIds, ChefMeals, Meals).

fillMeals([]).
fillMeals([Meal|OtherMeals]):-	Meal #= 0,
								fillMeals(OtherMeals).
fillMeals([Meal|OtherMeals]):-	fillMeals(OtherMeals).


ensureAllMealsAreCooked:-!.

testGetMeals:-	ResMeals = [A, B, C, D, E, F, G], getChefsMeals([1, 2], [1, 2, 3, 3, 2, 0, 1, 5, 4], ResMeals), fillMeals(ResMeals), write(ResMeals), nl.


% ir buscar chef meals
% transformar em set e dizer que todos os elementos do ResMeals têm que ser iguais a um dos chef meals
% usar in_set


%ensureChefMealsOnly(ChefMeals, ResMeals)
ensureChefMealsOnly(_, []).
ensureChefMealsOnly(ChefMealsSet, [Meal|OtherMeals]):-	Meal in_set ChefMealsSet,
														ensureChefMealsOnly(ChefMealsSet, OtherMeals).

newGetMeals(_, _, [], 0).
newGetMeals(Idx, ChefMeals, [Meal|Meals], N):-	N >= 0,
												ActualIdx #= Idx - N,
												element(ActualIdx, ChefMeals, Meal),
												Meal #\= 0, !,
												N1 is N-1,
												newGetMeals(Idx, ChefMeals, Meals, N1).
newGetMeals(_, _, [], _).

newGetChefMeals([], _, Meals, Meals).
newGetChefMeals([ChefId|OtherChefIds], ChefMeals, Meals, MealsFinal):-	Idx #= ChefId * 3 + 1,
																		newGetMeals(Idx, ChefMeals, TempMeals, 3),
																		append(Meals, TempMeals, NewMeals),
																		newGetChefMeals(OtherChefIds, ChefMeals, NewMeals, MealsFinal).

/*


	Chefs

	Tem que haver pelo menos Xi pratos do tipo i




*/

ensureAtLeastEqualToOne(Var, []):-	Var #= 0.
ensureAtLeastEqualToOne(Var, [Value|OtherValues]):-	Var #= Value.							
ensureAtLeastEqualToOne(Var, [Value|OtherValues]):-	ensureAtLeastEqualToOne(Var, OtherValues).

restrictList([], _).
restrictList([H|T], ValuesList):-	ensureAtLeastEqualToOne(H, ValuesList),
									restrictList(T, ValuesList).

test_restrict:-	List = [A, B, C, D],
				domain(List, 0, 10),
				Values = [5, 2, 9],
				all_distinct_except_0(List),
				restrictVars(Values, List),
				%restrictList(List, Values),
				labeling([maximize(B)], List),
				write(List), nl.

count_equals(_, [], 0).
count_equals(Val, [H|T], Count) :-
    Val #= H #<=> B,
    Count #= Count1 + B,
    count_equals(Val, T, Count1).


restrictVars(_, []).
restrictVars(ValuesList, [Var|OtherVars]):-     count_equals(Var, ValuesList, Count),
                                                Count #= 1,
                                                restrictVars(ValuesList, OtherVars).
restrictVars(_, [Var|OtherVars]):-  Var #= 0.

% No ResMeals tem que haver menos de MaxMeals pratos e só podem aparecer lá pratos que estejam em CookMeals e tem que satisfazer a lista de tipos de pratos
restrictResMeals(ResMeals, CookMeals, Meals, TypesList):-	all_distinct_except_0(ResMeals),
															restrictVars(CookMeals, ResMeals),
															mealIdsToType(ResMeals, Meals, Types),
															global_cardinality(Types, TypesList).


solve(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-	length(Chefs, LenChefs),
														length(Meals, TempLenMeals),
														LenMeals #= TempLenMeals / 2,
														mealsListToDomains(MealsList, MealsListFinal, MaxMeals),

														% Decision Variables
														length(ResChefs, LenChefs),
														domain(ResChefs, 0, LenChefs),
														length(ResMeals, MaxMeals),
														domain(ResMeals, 0, LenMeals),


														% Restrictions
														all_distinct_except_0(ResChefs),
														%mealIdsToType(ResMeals, Meals, Types),
														%global_cardinality(Types, MealsListFinal),
														%ensureChefMealsOnly(ResChefs, ChefMeals, ResMeals),
														%getChefsMeals(ResChefs, ChefMeals, ResMeals),
														%fillMeals(ResMeals),
														%length(CookMeals, LenCookMeals),
														%LenCookMeals #=< MaxMeals,
														%mealIdsToType(ResMeals, Meals, CookTypes),
														%global_cardinality(CookTypes, MealsListFinal),

														newGetChefMeals(ResChefs, ChefMeals, [], CookMeals),
														%restrictResMeals(ResMeals, CookMeals, Meals, MealsListFinal),
														%mealIdsToType(CookMeals, Meals, Types),
														%global_cardinality(Types, MealsListFinal),
														%list_to_fdset(CookMeals, CookMealsSet),
														%ensureChefMealsOnly(CookMealsSet, ResMeals),

														% Evaluation
														sumChefsSalaries(Chefs, ResChefs, SalariesSum),
														sumMealsProfit(CookMeals, Meals, MealsSum),
														Profit #= MealsSum - SalariesSum,


														%Labeling
														append(ResChefs, ResMeals, Final),
														%labeling([maximize(MealsSum)], ResMeals),
														%labeling([minimize(SalariesSum), maximize(MealsSum)], ResChefs),
														%labeling([maximize(MealsSum), minimize(SalariesSum)], Final),
														labeling([maximize(Profit)], Final),
														%labeling([], ResMeals),

														write(CookMeals), nl,
														write(ResChefs), nl,
														write(Profit), nl,
														write(MealsSum), nl,
														write(ResMeals), nl
														%write(MealsSum), nl,
														%write(SalariesSum), nl
														.


solve2(MaxMeals, Meals, Chefs, ChefMeals, MealsList):-	length(Chefs, LenChefs),
														length(Meals, TempLenMeals),
														LenMeals #= TempLenMeals / 2,
														mealsListToDomains(MealsList, MealsListFinal, MaxMeals),

														% Decision Variables
														length(ResChefs, LenChefs),
														domain(ResChefs, 0, LenChefs),
														length(ResMeals, MaxMeals),
														domain(ResMeals, 0, LenMeals),


														% Restrictions
														all_distinct_except_0(ResChefs),
														%newGetChefMeals(ResChefs, ChefMeals, [], CookMeals),
														%restrictResMeals(ResMeals, CookMeals, Meals, MealsListFinal),

														% Evaluation
														sumChefsSalaries(Chefs, ResChefs, SalariesSum),
														%sumMealsProfit(CookMeals, Meals, MealsSum),
														%Profit #= MealsSum - SalariesSum,


														%Labeling
														append(ResChefs, ResMeals, Final),
														labeling([minimize(SalariesSum)], Final),

														%write(CookMeals), nl,
														write(ResChefs), nl
														%write(Profit), nl,
														%write(MealsSum), nl,
														%write(ResMeals), nl
														%write(MealsSum), nl,
														%write(SalariesSum), nl
														.



test_solve:- generateSmall(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).
test_solve2:- generateSmall(Meals, Chefs, ChefMeals, MealsList), solve2(5, Meals, Chefs, ChefMeals, MealsList).

