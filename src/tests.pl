testMealIdsToTypes:-	ResMeals = [0, 1, 1, 0, 1],
						Meals = [200, 1, 250, 2, 300, 3, 150, 2, 175, 1],
						mealIdsToTypesFinal(ResMeals, Types, 5, Meals),
						write(Types), nl.

test_meals_sum:-	Meals = [200, 1, 250, 2, 300, 3, 150, 2, 175, 1],
					ResMeals = [_, _, _, _, _],
					domain(ResMeals, 0, 1),
					sumMealsProfit(Meals, ResMeals, Sum),
					labeling([maximize(Sum)], ResMeals),
					write(ResMeals), nl,
					write(Sum), nl.

test_salary_sum:-	Chefs = [4000, 2000, 1000],
					ResChefs = [_, _, _],
					domain(ResChefs, 0, 1),
					sumChefsSalaries(Chefs, ResChefs, Sum),
					sum(ResChefs, #>, 0),
					labeling([minimize(Sum)], ResChefs),
					write(ResChefs), nl.

new_test:-	Vars = [_, 1, _],
			domain(Vars, 0, 1),
			Vars2 = [_, _, _],
			domain(Vars2, 0, 1),
			forceXor(Vars, Vars2),
			append(Vars, Vars2, Final),
			labeling([], Final),
			write(Vars), nl,
			write(Vars2), nl.

testForceByScalar:-	length(Vars, 3),
					domain(Vars, 0, 1),
					A in 0..1,
					B in 0..1,
					C in 0..1,
					List = [A, B, C],

					forceByScalar(List, Vars),

					sum(Vars, #=, Sum),

					labeling([maximize(Sum)], Vars),
					write(Vars), nl.


testForceZeros:-	length(Vars, 3),
					domain(Vars, 0, 1),
					A in 0..1,
					B in 0..1,
					C in 0..1,
					List = [A, B, C],

					ListNew = [1, 1, 1],

					Weights = [1000, 2000, 500],

					forceZerosNewNewNew(ListNew, Vars),

					sum(Vars, #=, 2),
					scalar_product(Weights, Vars, #=, Scalar),

					append(List, Vars, Final),
					labeling([minimize(Scalar)], Final),
					write(Vars), nl,
					write(A), nl,
					write(B), nl,
					write(C), nl,
					write(Scalar).

testForceOr:-	length(Vars, 3),
				domain(Vars, 0, 1),
				List = [1, 0, 0],

				forceOr(Vars, List),

				sum(Vars, #=, Sum),

				labeling([maximize(Sum)], Vars),
				write(Vars), nl.

testForceAnd:-	length(Vars, 3),
				domain(Vars, 0, 1),
				List = [1, 0, 0],

				forceAnd(Vars, List),

				sum(Vars, #=, Sum),

				labeling([maximize(Sum)], Vars),
				write(Vars), nl.

testGetMeals:-	ChefMeals = [
					1, 1, 1, 0, 0,
					0, 1, 1, 0, 0,
					1, 0, 0, 1, 1
				],
				getMeals(5, 1, ChefMeals, Meals, 1),
				write(Meals), nl.

testGetAllChefMeals:-	ResChefs = [0, 1, 1],
						ChefMeals = [
							1, 1, 1, 0, 0,
							0, 0, 1, 0, 0,
							1, 0, 0, 0, 1
						],
						getAllChefMeals(5, ResChefs, ChefMeals, 3, [0, 0, 0, 0, 0], Meals),
						nl, write(Meals), nl.

testActuallyForceOr:-	List = [1, 0, 0, 0, 0, 0, 0, 1, 0],
						actuallyForceOr(List, 0, Res, 3, 1, 3),
						write(Res), nl.

testActuallyForceOrNew:-	List = [1,0,0,1,1,0,0,0,0,0,0,0,0,0,0],
							forceOrOnBigList(List, ResListFinal, 5),
							write(ResListFinal), nl.

