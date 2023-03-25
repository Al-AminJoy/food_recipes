import 'dart:convert';

MealDetails mealDetailsFromJson(String str) => MealDetails.fromJson(json.decode(str));

String mealDetailsToJson(MealDetails data) => json.encode(data.toJson());

class MealDetails {
  MealDetails({
    required this.meals,
  });

  List<Map<String, String?>> meals;

  factory MealDetails.fromJson(Map<String, dynamic> json) => MealDetails(
    meals: List<Map<String, String?>>.from(json["meals"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
  );

  Map<String, dynamic> toJson() => {
    "meals": List<dynamic>.from(meals.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v)))),
  };
}