
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

}