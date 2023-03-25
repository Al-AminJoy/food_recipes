
import 'package:recepie_app/data/MealDetails.dart';
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


  Future<void> getRecipe (String mealId)async{
    MealDetails? mealDetails;
    
    var response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId"));

    if(response.statusCode == 200){
      mealDetails = mealDetailsFromJson(response.body.toString());
    }

    for(Map<String, String?> meals in mealDetails!.meals){
      for(MapEntry<String,String?> data in meals.entries){
        print(data.key);
      }
    }

   // print(mealDetails?.toJson());
    
  }

}