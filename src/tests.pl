
% Predicates to run various instances of the problem

test_solve:- generateSmallAlt(Meals, Chefs, ChefMeals, MealsList), solve(5, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium:-	generateMediumAlt(Meals, Chefs, ChefMeals, MealsList), solve(7, Meals, Chefs, ChefMeals, MealsList).

test_solve_medium_big:-	generateMediumBig(Meals, Chefs, ChefMeals, MealsList), solve(8, Meals, Chefs, ChefMeals, MealsList).

test_solve_very_big:-	generateVeryBig(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big1:-	generateBig1(Meals, Chefs, ChefMeals, MealsList), solve(15, Meals, Chefs, ChefMeals, MealsList).

test_solve_big2:-	generateBig2(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big3:-	generateBig3(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_solve_big4:-	generateBig4(Meals, Chefs, ChefMeals, MealsList), solve(12, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_10:-	fixedChefs10(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_15:-	fixedChefs15(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_20:-	fixedChefs20(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_30:-	fixedChefs30(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_25:-	fixedChefs25(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_40:-	fixedChefs40(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_45:-	fixedChefs45(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedChefs_50:-	fixedChefs50(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_5:-	fixedMeals5(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_10:-	fixedMeals10(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_15:-	fixedMeals15(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_20:-	fixedMeals20(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_25:-	fixedMeals25(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).

test_fixedMeals_30:-	fixedMeals30(Meals, Chefs, ChefMeals, MealsList), solve(20, Meals, Chefs, ChefMeals, MealsList).
