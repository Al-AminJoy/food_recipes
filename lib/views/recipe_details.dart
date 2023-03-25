import 'package:flutter/material.dart';
import 'package:recepie_app/data/meal_emlement.dart';
import 'package:recepie_app/network_repository.dart';

class RecipeDetails extends StatefulWidget {
  final MealElement mealElement ;
  const RecipeDetails({Key? key,required this.mealElement}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late final MealElement mealElement;

  NetworkRepository networkRepository = NetworkRepository();


  @override
  void initState() {
    super.initState();
     mealElement = widget.mealElement;

     getRecipe();

  }


  void getRecipe() {
    networkRepository.getRecipe(mealElement.idMeal).then((value) {


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealElement.strMeal,style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [

              ],
            )
          ],
        ),
      ),
    );
  }


}
