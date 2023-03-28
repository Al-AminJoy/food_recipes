import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recepie_app/data/Ingredient.dart';
import 'package:recepie_app/data/Measure.dart';
import 'package:recepie_app/data/Recipe.dart';
import 'package:recepie_app/data/meal_emlement.dart';
import 'package:recepie_app/network_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RecipeDetails extends StatefulWidget {
  final MealElement mealElement;

  const RecipeDetails({Key? key, required this.mealElement}) : super(key: key);

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late final MealElement mealElement;

  NetworkRepository networkRepository = NetworkRepository();

  Recipe _recipe = Recipe();

  @override
  void initState() {
    super.initState();
    mealElement = widget.mealElement;

    getRecipe();
  }

  void getRecipe() {
    networkRepository.getRecipe(mealElement.idMeal).then((value) {
      setState(() {
        _recipe = value;
      });
    });
  }

  void _launchURL() async {
    String _youtubeTutorial = _recipe.youtubeTutorial;
    if (await canLaunchUrl(Uri.parse(_youtubeTutorial))) {
      await launchUrl(Uri.parse(_youtubeTutorial));
    } else {
      if (await canLaunchUrl(Uri.parse(_youtubeTutorial))) {
        await launchUrl(Uri.parse(_youtubeTutorial));
      } else {
        throw 'Could not launch $_youtubeTutorial';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mealElement.strMeal,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Container(
              height: 150,
              width: double.infinity,
              padding: EdgeInsets.all(2),
              color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        _launchURL();
                      },
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: const [
                          Text('Watch on Youtube',style: TextStyle(color: Colors.white),),
                          SizedBox(width: 10,),
                          Icon(Icons.slow_motion_video_outlined,color: Colors.red,)
                        ],
                      )
                      ,
                    ),
                  ],
                )
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.orange,
                      borderRadius:
                      BorderRadius.only(topLeft: Radius.circular(20))),
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          'Ingredients :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: _recipe.ingredientList.length,
                            itemBuilder: (context, index) {
                              List<Ingredient> _ingredientList =
                                  _recipe.ingredientList;
                              List<Measure> _measureList = _recipe.measureList;

                              print(_ingredientList);
                              print(_measureList);

                              return Row(
                                children: [
                                  const Icon(
                                    Icons.trip_origin,
                                    color: Colors.black,
                                    size: 5,
                                  ),
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          " ${_ingredientList[index].ingredientName}", style:
                                      const TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          ": ${index >= (_measureList.length-1) ? "N/A":_measureList[index].measureQuantity}", style:
                                      const TextStyle(color: Colors.white, fontSize: 16)),
                                    ),
                                  )
                                ],
                              );
                            }),
                        const Text(
                          'Instruction :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),Text(
                          _recipe.instruction,
                          style:
                          const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 200,
                    bottom: 0,
                    right: -40,
                    top: -600,
                    child: CircleAvatar(
                  radius: 20,
                      child:  ClipOval(
                     child: Image.network(mealElement.strMealThumb),
                ),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
