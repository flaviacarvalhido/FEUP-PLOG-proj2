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


%medium size problem
generateMealsMedium([200, 1,
					 250, 2, 
					 300, 3, 
					 150, 2, 
					 175, 1,
					 300, 4, 
					 200, 5, 
					 178, 2, 
					 290, 1,
					 300, 2]).

generateChefsMedium([4000,2000,3000,5000,2000,600,2500]).

/*
	Chefs - 3 e 5 (3000 + 2000 = 5000)
	Meals Profit - 290 + 200 + 250 + 178 + 300 + 300 + 200 = 1718
	Pratos - [1, 1, 1, 0, 1, 1, 1, 1, 1, 0]
	Types -  [1, 2, 3, 0, 1, 4, 5, 2, 1, 0]


*/

generateChefMealsMediumAlt([1,1,0,1,1,0,0,0,1,0,
							1,0,0,0,0,1,0,0,0,1,
							1,1,1,0,0,1,0,0,1,0,
							0,0,0,0,1,0,0,0,1,0,
							1,1,0,0,1,0,1,1,0,0, %
							0,0,1,0,0,1,0,0,1,1, %
							1,0,0,0,1,0,0,1,0,0]).

generateMealsListMedium([1-2, 2-2, 3-1, 4-1, 5-1]).

generateMediumAlt(Meals, Chefs, ChefMeals, MealsList):-	generateMealsMedium(Meals),
														generateChefsMedium(Chefs),
														generateChefMealsMediumAlt(ChefMeals),
														generateMealsListMedium(MealsList).





