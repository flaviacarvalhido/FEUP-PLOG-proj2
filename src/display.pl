:- use_module(library(lists)).

:- include('menus.pl').

/*
 * displayInput(+MaxMeals, +MealsList, +Meals, +ActualLenMeals, +Chefs, +LenMeals, +ChefMeals)
 *
 * Displays the problem input information
 *
 */
displayInput(MaxMeals, MealsList, Meals, ActualLenMeals, Chefs, LenChefs, ChefMeals):-
    write('---------------------------------------------------Problem input----------------------------------------------------'), nl,nl,
	write('Maximum number of dishes to have: '), write(MaxMeals), nl,
	write('Minimum required number of dishes per type: '), nl, write('Type    Min'), displayTypesAndMinimum(MealsList), nl, nl,
	write('List of meals available: '), nl, write('Type    Profit'), displayMeals(Meals), nl,
	write('Total meals available: '), write(ActualLenMeals), nl, nl, nl,
	write('List of chefs available: '), nl, write('Number    Salary'), displayChefs(Chefs, 1, LenChefs), nl, nl,
	TotalChefs is LenChefs+1,
	write('List of meals that chefs can cook (0-doesn\'t cook, 1-cooks, lists refer to available meals): '), nl, write('Chef Number      Chef Meals'), displayChefMeals(ChefMeals, 1, ActualLenMeals, TotalChefs), nl,
	write('--------------------------------------------------------------------------------------------------------------------'), nl.

/*
 * displaySolution(+ResChefs, +LenChefs, +ResMeals, +Types, +SalariesSum, +MealsSum, +Profit)
 *
 * Displays the problem solution information
 *
 */
displaySolution(ResChefs, LenChefs, ResMeals, Types, SalariesSum, MealsSum, Profit):-
    write('-------------------------------------------------Problem solution---------------------------------------------------'), nl,nl,
	% write('MealsList: '), write(MealsList), nl,
	write('Chefs to be hired (0-not hired, 1-hired): '), nl, write('Number    Hired'), displayHiredChefs(ResChefs, 1, LenChefs), nl, nl,
	write('Meals to be included in the menu (0-don\'t include, 1-include, list refers to available meals): '), write(ResMeals), nl,nl,
	% write('CurrentChefMeals: '), write(CurrentChefMeals), nl,
	% write('PossibleChefMeals: '), write(PossibleChefMeals), nl,
	write('Food types available: '), displayAvailableTypes(Types), nl,nl,
	write('Total salary ammount to pay: '), write(SalariesSum), nl, nl,
	write('Total montly meal profit: '), write(MealsSum), nl, nl,
	write('Overall profit: '), write(Profit), nl, 
	write('--------------------------------------------------------------------------------------------------------------------').


/*
 * displayTypesAndMinimum(+MealsList)
 *
 * Displays the meal types and respective cardinalities
 *
 */
displayTypesAndMinimum([Type-Min|MealsList]):-
                                            nl,write(Type), write('       '), write(Min),
                                            displayTypesAndMinimum(MealsList).
displayTypesAndMinimum(_).

/*
 * displayMeals(+Meals)
 *
 * Displays the available meals
 *
 */
displayMeals([Profit,Type|Meals]):-
                                    nl,write(Type), write('       '), write(Profit),
                                    displayMeals(Meals).
displayMeals(_).

/*
 * displayChefs(+Chefs, +N, +LenChefs)
 *
 * Displays available chefs
 *
 */
displayChefs([Salary|Chefs], N, LenChefs):- 
                                    nl,write(N), write('         '), write(Salary),
                                    N1 is N+1,
                                    displayChefs(Chefs,N1,LenChefs).
displayChefs([],_,_).

/*
 * displayChefMeals(+ChefMeals, +NChef, +TotalMeals, +LenChefs)
 *
 * Displays, for each available chef, the meals he can cook
 *
 */
displayChefMeals(_,LenChefs,_,LenChefs).
displayChefMeals(ChefMeals, NChef, TotalMeals, LenChefs):-
                                    getChefMealsAlt(TotalMeals, NChef, ChefMeals, CurrentChefMeals),
                                    nl,write(NChef), write('                '), write(CurrentChefMeals),
                                    NChef1 is NChef+1,
                                    displayChefMeals(ChefMeals, NChef1, TotalMeals, LenChefs).

/*
 * displayHiredChefs(+Chefs, +N, +LenChefs)
 *
 * Displays tha available chefs and whether they were hired or not
 *
 */
displayHiredChefs([Hired|Chefs],N, LenChefs):- 
                                    nl,write(N), write('         '), write(Hired),
                                    N1 is N+1,
                                    displayChefs(Chefs,N1,LenChefs).
displayHiredChefs([],_,_).

/*
 * displayAvailableTypes(+Types)
 *
 * Displays the available meal types
 *
 */
displayAvailableTypes(Types):-
                                    sort(Types, UniqueTypes),
                                    printTypes(UniqueTypes).

/*
 * printTypes(+Types)
 *
 * Displays the meal types
 *
 */
printTypes([]).
printTypes([0|UniqueTypes]):-printTypes(UniqueTypes).
printTypes([T|UniqueTypes]):-
            write(T), write('   '), printTypes(UniqueTypes).

