
import 'dart:convert';

import 'meal_emlement.dart';

Meal mealFromJson(String str) => Meal.fromJson(json.decode(str));

String mealToJson(Meal data) => json.encode(data.toJson());

class Meal {
  Meal({
    required this.meals,
  });

  List<MealElement> meals;

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
    meals: List<MealElement>.from(json["meals"].map((x) => MealElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
  };
}


