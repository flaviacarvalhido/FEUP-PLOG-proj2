# -*- coding: utf-8 -*-
"""
Created on Mon Dec 28 11:37:53 2020

@author: supertommc
"""

import random

def generate_chefs(no_chefs):
    
    random.seed()
    
    chefs = []
    
    for i in range(no_chefs):
        chefs.append(random.randint(500, 10000))
        
    return chefs

def generate_meals(no_meals):
    
    random.seed()
    
    meals = []
    
    for i in range(no_meals):
        meals.append(random.randint(200, 1500))
        meals.append(random.randint(1, 6))
        
    return meals


def generate_chef_meals(no_chefs, no_meals):
    
    random.seed()
    
    chef_meals = []
    
    for i in range(no_chefs):
        for i in range(no_meals):
            chef_meals.append(random.choice([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1]))
            
    return chef_meals


def list_to_string(lst, size_to_split):
    
    string = "["
    
    for i in range(len(lst)):
        string += str(lst[i])
        if (i != len(lst)-1):
            string += ", "
        if (size_to_split != 1 and i != len(lst) - 1 and (i+1) % size_to_split == 0):
            string += "\n"
    
    return string + "]"

def display_output(chefs, meals, chef_meals):
    chefs_str = list_to_string(chefs, 1)
    meals_str = list_to_string(meals, 2)
    chef_meals_str = list_to_string(chef_meals, len(meals) / 2)
    
    print("Chefs: ")
    print(chefs_str)
    print()
    print("Meals: ")
    print(meals_str)
    print()
    print("Chef Meals: ")
    print(chef_meals_str)

def generate(no_chefs, no_meals):
    chefs = generate_chefs(no_chefs)
    meals = generate_meals(no_meals)
    chef_meals = generate_chef_meals(no_chefs, no_meals)

    display_output(chefs, meals, chef_meals)
    

#generate(25, 10)

import matplotlib.pyplot as plt

plt.plot([0.03, 0.11, 0.12, 0.03, 2.62])
plt.ylabel('Time')
plt.show()
    
    
    