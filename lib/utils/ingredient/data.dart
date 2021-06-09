import 'package:flutter/cupertino.dart';
import 'package:foodz/services/database/entities/ingredient/entity_ingredient.dart';

const CATEGORY_FRUITS_AND_VEGGIES_STRING = "Fruits and veggies";
const CATEGORY_BAKERY_STRING = "Bakery";
const CATEGORY_MEAT_STRING = "Meats and seafood";
const CATEGORY_DRINKS_STRING = "Drinks";
const CATEGORY_SPICES_STRING = "Herbs and spices";
const CATEGORY_DAIRY_AND_EGGS_STRING = "Dairy and eggs";
const CATEGORY_PASTA_RICE_BEANS_STRING = "Pasta, rice and beans";
const CATEGORY_CONDIMENTS_STRING = "Condiments";
const CATEGORY_SNACKS_STRING = "Snack";

final List<EntityIngredient> ingredientList = [
  EntityIngredient(
      title: "Ananas",
      image: Image.asset("assets/images/ingredients/ananas.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Apple",
      image: Image.asset("assets/images/ingredients/apple.png"),
      seasons: [1, 2, 3, 4, 8, 9, 10, 11, 12],
      metric: "",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Asparagus",
      image: Image.asset("assets/images/ingredients/asparagus.png"),
      seasons: [4, 5, 6],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Baguette",
      image: Image.asset("assets/images/ingredients/baguette.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_BAKERY_STRING,
      allergies: []),
  EntityIngredient(
      title: "Banana",
      image: Image.asset("assets/images/ingredients/banana.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Beans",
      image: Image.asset("assets/images/ingredients/beans.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Beef",
      image: Image.asset("assets/images/ingredients/beef.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Beer",
      image: Image.asset("assets/images/ingredients/beer.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_DRINKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Beetroot",
      image: Image.asset("assets/images/ingredients/beetroot.png"),
      seasons: [1, 2, 3, 9, 10, 11, 12],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Black beans",
      image: Image.asset("assets/images/ingredients/black_beans.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_PASTA_RICE_BEANS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Bread",
      image: Image.asset("assets/images/ingredients/bread.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_BAKERY_STRING,
      allergies: []),
  EntityIngredient(
      title: "Chicken",
      image: Image.asset("assets/images/ingredients/chicken.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Chili powder",
      image: Image.asset("assets/images/ingredients/chili_powder.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_SPICES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Coconut milk",
      image: Image.asset("assets/images/ingredients/coconut_milk.png"),
      seasons: [],
      metric: "l",
      category: CATEGORY_DRINKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Eggplant",
      image: Image.asset("assets/images/ingredients/eggplant.png"),
      seasons: [5, 6, 7, 8, 9],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Egg",
      image: Image.asset("assets/images/ingredients/egg.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_DAIRY_AND_EGGS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Garlic",
      image: Image.asset("assets/images/ingredients/garlic.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Garlic",
      image: Image.asset("assets/images/ingredients/garlic.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Lemon juice",
      image: Image.asset("assets/images/ingredients/lemon_juice.png"),
      seasons: [],
      metric: "l",
      category: CATEGORY_DRINKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Lentils",
      image: Image.asset("assets/images/ingredients/lentils.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_PASTA_RICE_BEANS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Mate",
      image: Image.asset("assets/images/ingredients/mate.png"),
      seasons: [],
      metric: "l",
      category: CATEGORY_DRINKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Mint",
      image: Image.asset("assets/images/ingredients/mint.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_SPICES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Olive oil",
      image: Image.asset("assets/images/ingredients/olive_oil.png"),
      seasons: [],
      metric: "l",
      category: CATEGORY_CONDIMENTS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Onions",
      image: Image.asset("assets/images/ingredients/onions.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Orange",
      image: Image.asset("assets/images/ingredients/orange.png"),
      seasons: [],
      metric: "",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Pepper",
      image: Image.asset("assets/images/ingredients/pepper.png"),
      seasons: [6, 7, 8, 9, 10, 11],
      metric: "",
      category: CATEGORY_FRUITS_AND_VEGGIES_STRING,
      allergies: []),
  EntityIngredient(
      title: "Pasta",
      image: Image.asset("assets/images/ingredients/pasta.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_PASTA_RICE_BEANS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Peanut",
      image: Image.asset("assets/images/ingredients/peanut.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_SNACKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Peanut",
      image: Image.asset("assets/images/ingredients/peanut.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_SNACKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Comté",
      image: Image.asset("assets/images/ingredients/cheese.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_DAIRY_AND_EGGS_STRING,
      allergies: []),
  EntityIngredient(
      title: "White wine",
      image: Image.asset("assets/images/ingredients/white_wine.png"),
      seasons: [],
      metric: "l",
      category: CATEGORY_DRINKS_STRING,
      allergies: []),
  EntityIngredient(
      title: "Bacon",
      image: Image.asset("assets/images/ingredients/bacon.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Creme fraiche",
      image: Image.asset("assets/images/ingredients/creme.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Smoked salmon",
      image: Image.asset("assets/images/ingredients/smoked_salmon.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Sour cream",
      image: Image.asset("assets/images/ingredients/creme.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_MEAT_STRING,
      allergies: []),
  EntityIngredient(
      title: "Thyme",
      image: Image.asset("assets/images/ingredients/thyme.png"),
      seasons: [],
      metric: "g",
      category: CATEGORY_SPICES_STRING,
      allergies: []),
];
