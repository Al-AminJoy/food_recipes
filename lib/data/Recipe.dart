import 'package:recepie_app/data/Ingredient.dart';
import 'package:recepie_app/data/Measure.dart';

class Recipe{
  String mealId= "";
  String mealName = '';
  String instruction = "";
  String image ="";
  String youtubeTutorial = "";
  List<Ingredient> ingredientList = [];
  List<Measure> measureList = [];




Map<String,dynamic> toJson() => {
    "mealId" : mealId,
    "mealName" : mealName,
    "instruction" : instruction,
    "image":image,
    "youtubeTutorial": youtubeTutorial,
    "ingredientList" : List<dynamic>.from(ingredientList.map((x) => x.toJson())),
    "measureList" : List<dynamic>.from(measureList.map((x) => x.toJson()))
};

}