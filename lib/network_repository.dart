
import 'package:recepie_app/data/Ingredient.dart';
import 'package:recepie_app/data/MealDetails.dart';
import 'package:recepie_app/data/Measure.dart';
import 'package:recepie_app/data/Recipe.dart';
import 'package:recepie_app/data/meal.dart';

import 'data/category_model.dart';
import "package:http/http.dart" as http;

class NetworkRepository{

  Future<CategoryModel?> getCategories() async{

    CategoryModel? categoryModel;

    var response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if(response.statusCode == 200){
      categoryModel = categoryModelFromJson(response.body.toString());
    }

    return categoryModel;

  }


  Future<Meal?> getMeals(String category)async{
    Meal? meal ;

    var response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$category"));

    if(response.statusCode == 200){
      meal = mealFromJson(response.body.toString());
    }

    return meal;

  }


  Future<Recipe> getRecipe (String mealId)async{
    MealDetails? mealDetails;
    
    var response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId"));

    if(response.statusCode == 200){
      mealDetails = mealDetailsFromJson(response.body.toString());
    }

    List<Ingredient> ingredientList = [];
    List<Measure> measureList = [];
    Recipe recipe = Recipe();

    for(Map<String, String?> meals in mealDetails!.meals){
      for(MapEntry<String,String?> data in meals.entries){
        if(data.key.toLowerCase().contains("ingredient".toLowerCase())){
          if(data.value != null && data.value!.isNotEmpty){
            ingredientList.add(Ingredient(ingredientName: data.value!));
          }
        }
        if(data.key.toLowerCase().contains("measure".toLowerCase())){
          if(data.value != null && data.value!.isNotEmpty){
            measureList.add(Measure(measureQuantity: data.value!));
          }
        }
        if(data.key.toLowerCase() == "idMeal".toLowerCase()){
          recipe.mealId = data.value!;
        }
        if(data.key.toLowerCase() == "strMeal".toLowerCase()){
          recipe.mealName = data.value!;
        }
        if(data.key.toLowerCase() == "strInstructions".toLowerCase()){
          recipe.instruction = data.value!;
        }
        if(data.key.toLowerCase() == "strYoutube".toLowerCase()){
          recipe.youtubeTutorial = data.value!;
        }
        if(data.key.toLowerCase() == "strMealThumb".toLowerCase()){
          recipe.image = data.value!;
        }
      }
    }


    recipe.ingredientList = ingredientList;
    recipe.measureList = measureList;

    print(recipe.toJson());

    return recipe;

  }

}