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

/*  Recipe({
    required this.mealId, required this.mealName, required this.instruction, required this.image,
    required this.youtubeTutorial, required this.ingredientList, required this.measureList
}); */

/*
Map<String, dynamic> toJson() => {
        "idCategory": idCategory,
        "strCategory": strCategory,
        "strCategoryThumb": strCategoryThumb,
        "strCategoryDescription": strCategoryDescription,
      };
 */



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