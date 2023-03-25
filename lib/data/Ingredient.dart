class Ingredient{
  String ingredientName;
  Ingredient({required this.ingredientName});

  Map<String,dynamic> toJson() =>{
    "ingredientName":ingredientName
  };
}