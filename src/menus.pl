
:- include('utils.pl').

/*
 * mainMenu/0
 *
 * Displays the main menu and handles user input
 *
 */

mainMenu:- clearConsole, displayMainMenu, nl, write('What do you want to do?   : '), nl, getInputAndValidate(0, 4, UserChoice), !, \+handleChoice(UserChoice), mainMenu.


problemMenu:-	clearConsole, displayProblem, getInputAndValidate(0, 0, _).

/*
 * displayMainMenu/0
 *
 * Displays the main menu interface
 *
 */
displayMainMenu:-
					write(' ____________________________________________________________________________________________________________ '), nl,
					write('|                                                                                                            |'), nl,
					write('|               .-----------------. .----------------.  .----------------.  .----------------.               |'), nl,
					write('|              | .--------------. || .--------------. || .--------------. || .--------------. |              |'), nl,
					write('|              | | ___________  | || | ___________  | || |  __________  | || | ____  _____  | |              |'), nl,
					write('|              | ||_   ____   | | || ||_   ____   | | || | |___    ___| | || ||_   \\|_   _| | |              |'), nl,
					write('|              | |  | |____|  | | || |  | |____|  | | || |     |  |     | || |  |   \\ | |   | |              |'), nl,
					write('|              | |  |  _______| | || |  |  _______| | || |     |  |     | || |  | |\\ \\| |   | |              |'), nl,
					write('|              | | _| |_        | || | _| |_        | || |  ___|  |___  | || | _| |_\\   |_  | |              |'), nl,
					write('|              | ||_____|       | || ||_____|       | || | |__________| | || ||_____|\\____| | |              |'), nl,
					write('|              | |              | || |              | || |              | || |              | |              |'), nl,
					write('|              | ''------------''   ||  ''------------''  ||  ''------------''  ||  ''------------''  |              |'), nl,
					write('|               ''----------------''  ''----------------''  ''----------------''  ''----------------''               |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                               "Pequenos Prazeres Inesqueciveis de Nagoya"                                  |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                    1 - Small Size Problem                                                  |'), nl,
					write('|                                    2 - Medium Size Problem                                                 |'), nl,
					write('|                                    3 - Large Size Problem                                                  |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                    4 - Problem Explanation                                                 |'), nl,
					write('|                                    0 - Quit                                                                |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                                                                                            |'), nl,
					write(' ____________________________________________________________________________________________________________ '), nl.


displayProblem:-
                    write(' ____________________________________________________________________________________________________________ '), nl,
					write('|                                                                                                            |'), nl,
					write('|               .-----------------. .----------------.  .----------------.  .----------------.               |'), nl,
					write('|              | .--------------. || .--------------. || .--------------. || .--------------. |              |'), nl,
					write('|              | | ___________  | || | ___________  | || |  __________  | || | ____  _____  | |              |'), nl,
					write('|              | ||_   ____   | | || ||_   ____   | | || | |___    ___| | || ||_   \\|_   _| | |              |'), nl,
					write('|              | |  | |____|  | | || |  | |____|  | | || |     |  |     | || |  |   \\ | |   | |              |'), nl,
					write('|              | |  |  _______| | || |  |  _______| | || |     |  |     | || |  | |\\ \\| |   | |              |'), nl,
					write('|              | | _| |_        | || | _| |_        | || |  ___|  |___  | || | _| |_\\   |_  | |              |'), nl,
					write('|              | ||_____|       | || ||_____|       | || | |__________| | || ||_____|\\____| | |              |'), nl,
					write('|              | |              | || |              | || |              | || |              | |              |'), nl,
					write('|              | ''------------''   ||  ''------------''  ||  ''------------''  ||  ''------------''  |              |'), nl,
					write('|               ''----------------''  ''----------------''  ''----------------''  ''----------------''               |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                               "Pequenos Prazeres Inesqueciveis de Nagoya"                                  |'), nl,
					write('|    Someone wishes to open a sushi restaurant, named "Pequenos Prazeres Inesqueciveis de Nagoya" or PPIN.   |'), nl,
					write('|     However, the restaurant owner must decide which dishes to serve, from a vast selection of dishes.      |'), nl,
					write('|   As it is a sushi restaurant, each dish has a type (sashimi, etc) and a monthly profit associated to it.  |'), nl,
					write('|     The restaurant owner must also hire chefs to cook these dishes. Each chef asks for a monthly salary    |'), nl,
					write('|     and can only cook some dishes from the dish selection. The restaurant owner wants to have at least     |'), nl,
					write('|  x number of dishes from each y type and, simultaneously, a max number z of dishes available in the menu.  |'), nl,
					write('|   Taking these restrictions, the objective of the problem is to maximise the restaurant owner\'s monthly    |'), nl,
					write('|               earnings, by choosing the best chefs and dishes to have in order to do so.                   |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                                                                                            |'), nl,
					write('|                                               0 - Go Back                                                  |'), nl,
					write(' ____________________________________________________________________________________________________________ '), nl.



/*
 * handleChoice(+Choice)
 *
 * Handles the user input received in Choice, calling the right predicates, depending on the chosen menu option
 *
 */
handleChoice(0):- clearConsole, write('Quitting...').
handleChoice(1):- clearConsole, !, test_solve.
handleChoice(2):- clearConsole, !, test_solve_medium.
% handleChoice(3):- clearConsole, !, test_solve_large.
handleChoice(4):- problemMenu, !, fail.

