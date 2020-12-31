
/*


	1 - 0.0s
	2 - 2.87s
	3 - 
	




*/

fixedChefsChefs10([8552, 1727, 2281, 6728, 2430, 9858, 9689, 2913, 5421, 5911]).

fixedChefsMeals10(	[534, 6, 
					1428, 1, 
					1340, 2, 
					993, 1, 
					582, 1, 
					630, 4, 
					1412, 3, 
					623, 6, 
					919, 6, 
					894, 4]).

fixedChefsChefMeals10(	[0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 
						1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 
						0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 
						0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 
						0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 
						0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 
						0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 
						0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 
						0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 
						1, 1, 0, 1, 0, 1, 0, 1, 0, 0]).

fixedChefsMealsList10([1-2, 2-1, 3-1, 4-1, 5-0, 6-3]).

fixedChefs10(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals10(Meals),
													fixedChefsChefMeals10(ChefMeals),
													fixedChefsMealsList10(MealsList).


fixedChefsMeals15(	[912, 6, 
					1270, 1, 
					370, 2, 
					574, 4, 
					634, 4, 
					1129, 1, 
					392, 6, 
					336, 1, 
					1019, 4, 
					826, 3, 
					224, 5, 
					669, 6, 
					430, 3, 
					350, 3, 
					1261, 5]).

fixedChefsChefMeals15(	[1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 
						0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 
						0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 
						0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 
						1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
						1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 
						0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 
						0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1]).

fixedChefs15(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals15(Meals),
													fixedChefsChefMeals15(ChefMeals),
													fixedChefsMealsList10(MealsList).

fixedChefsMeals20(	[742, 1, 
					321, 1, 
					1271, 5, 
					1386, 6, 
					216, 2, 
					252, 1, 
					485, 3, 
					227, 2, 
					1348, 6, 
					1001, 6, 
					1350, 6, 
					1437, 5, 
					694, 1, 
					914, 3, 
					1265, 5, 
					460, 4, 
					1449, 3, 
					426, 4, 
					1434, 6, 
					1339, 3]).

fixedChefsChefMeals20(	[1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
						1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 
						0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 
						0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 
						0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 
						0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 
						1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 
						0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 
						1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0]).

fixedChefsMealsList20([1-3, 2-2, 3-1, 4-1, 5-0, 6-2]).

fixedChefs20(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals20(Meals),
													fixedChefsChefMeals20(ChefMeals),
													fixedChefsMealsList10(MealsList).


fixedChefsMeals30(	[1296, 2, 
					1220, 3, 
					1330, 3, 
					442, 3, 
					1374, 5, 
					277, 6, 
					1038, 5, 
					1358, 2, 
					721, 3, 
					524, 6, 
					1448, 6, 
					219, 2, 
					660, 2, 
					1475, 3, 
					1496, 5, 
					482, 5, 
					534, 3, 
					706, 2, 
					626, 2, 
					1380, 5, 
					789, 5, 
					798, 2, 
					717, 3, 
					260, 1, 
					749, 6, 
					1288, 4, 
					1439, 1, 
					347, 3, 
					793, 2, 
					668, 6]).

fixedChefsChefMeals30(	[0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 
						0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 
						1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 
						0, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 1, 0, 1, 
						0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
						0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 
						0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 
						0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 
						0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 
						1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]).

fixedChefsMealsList30([1-3, 2-2, 3-1, 4-1, 5-3, 6-3]).

fixedChefs30(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals30(Meals),
													fixedChefsChefMeals30(ChefMeals),
													fixedChefsMealsList10(MealsList).

fixedChefsMeals25(	[1473, 4, 
					1243, 3, 
					739, 5, 
					697, 4, 
					362, 2, 
					1409, 2, 
					326, 4, 
					1006, 5, 
					804, 5, 
					379, 3, 
					394, 3, 
					1447, 6, 
					1219, 5, 
					1170, 4, 
					1015, 4, 
					1032, 2, 
					1387, 6, 
					1062, 4, 
					1409, 4, 
					1304, 3, 
					1067, 1, 
					866, 1, 
					302, 1, 
					1349, 6, 
					608, 5]).

fixedChefsChefMeals25(	[0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 
						0, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 
						0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 
						0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 
						1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 
						1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 
						0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 
						0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 
						0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0]).

fixedChefs25(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals25(Meals),
													fixedChefsChefMeals25(ChefMeals),
													fixedChefsMealsList10(MealsList).


fixedChefsMeals40(	[631, 5, 
					329, 2, 
					719, 2, 
					213, 1, 
					1147, 3, 
					1315, 1, 
					1263, 1, 
					1332, 3, 
					477, 4, 
					1183, 3, 
					581, 6, 
					1487, 1, 
					1378, 5, 
					1102, 4, 
					363, 3, 
					1065, 6, 
					567, 1, 
					1197, 3, 
					341, 4, 
					422, 5, 
					782, 1, 
					278, 6, 
					1295, 5, 
					936, 1, 
					302, 6, 
					1171, 3, 
					655, 4, 
					210, 4, 
					578, 2, 
					971, 1, 
					702, 6, 
					1009, 6, 
					262, 1, 
					1113, 2, 
					525, 4, 
					450, 5, 
					618, 6, 
					1241, 5, 
					332, 4, 
					785, 1]).

fixedChefsChefMeals40(	[0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 
						0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 
						0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 
						0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 
						0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 
						1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 
						0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 
						1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 
						0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0]).

fixedChefs40(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals40(Meals),
													fixedChefsChefMeals40(ChefMeals),
													fixedChefsMealsList10(MealsList).


fixedChefsMeals50(	[631, 5, 
					329, 2, 
					719, 2, 
					213, 1, 
					1147, 3, 
					1315, 1, 
					1263, 1, 
					1332, 3, 
					477, 4, 
					1183, 3, 
					581, 6, 
					1487, 1, 
					1378, 5, 
					1102, 4, 
					363, 3, 
					1065, 6, 
					567, 1, 
					1197, 3, 
					341, 4, 
					422, 5, 
					782, 1, 
					278, 6, 
					1295, 5, 
					936, 1, 
					302, 6, 
					1171, 3, 
					655, 4, 
					210, 4, 
					578, 2, 
					971, 1, 
					702, 6, 
					1009, 6, 
					262, 1, 
					1113, 2, 
					525, 4, 
					450, 5, 
					618, 6, 
					1241, 5, 
					332, 4, 
					785, 1,
					1000, 2]).

fixedChefsChefMeals50(	[0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0, 0, 1,
						0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0,
						0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
						0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1,
						0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0,
						0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 1, 0,
						1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0,
						0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
						1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1,
						0, 1, 0, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0]).

fixedChefs50(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals50(Meals),
													fixedChefsChefMeals50(ChefMeals),
													%MealsList = [1-0, 2-0, 3-0, 4-0, 5-0, 6-0].
													fixedChefsMealsList10(MealsList).



fixedChefsMeals45(	[1150, 6, 
					557, 4, 
					1307, 4, 
					815, 3, 
					251, 1, 
					1280, 3, 
					602, 1, 
					822, 5, 
					314, 6, 
					429, 6, 
					755, 6, 
					730, 1, 
					916, 6, 
					511, 6, 
					997, 3, 
					381, 3, 
					1011, 5, 
					680, 4, 
					585, 6, 
					531, 3, 
					716, 3, 
					1316, 2, 
					1087, 1, 
					866, 4, 
					922, 5, 
					210, 4, 
					1245, 5, 
					1060, 3, 
					797, 2, 
					657, 2, 
					551, 5, 
					944, 3, 
					1415, 6, 
					792, 3, 
					1475, 1, 
					910, 6, 
					882, 1, 
					901, 5, 
					1384, 2, 
					1378, 1, 
					906, 5, 
					913, 6, 
					588, 1, 
					1217, 6, 
					1404, 1]).

fixedChefsChefMeals45(	[1, 1, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 
						1, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 
						0, 0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 
						0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 
						0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
						0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 1, 
						0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 
						0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 1, 
						0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 
						0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0]).

fixedChefs45(Meals, Chefs, ChefMeals, MealsList):-	fixedChefsChefs10(Chefs),
													fixedChefsMeals45(Meals),
													fixedChefsChefMeals45(ChefMeals),
													fixedChefsMealsList10(MealsList).