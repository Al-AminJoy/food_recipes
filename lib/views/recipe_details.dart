import 'package:flutter/material.dart';
import 'package:recepie_app/data/Ingredient.dart';
import 'package:recepie_app/data/Measure.dart';
import 'package:recepie_app/data/Recipe.dart';
import 'package:recepie_app/data/meal_emlement.dart';
import 'package:recepie_app/network_repository.dart';

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
              color: Colors.white,
              )),
          Flexible(
            fit: FlexFit.tight,
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
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

                              return Row(
                                children: [
                                  Icon(
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
                                          ": ${_measureList[index].measureQuantity}", style:
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
                        ),
                        Text(
                          _recipe.instruction,
                          style:
                          const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    left: 190,
                    bottom: 0,
                    right: -190,top: -700,
                    child: CircleAvatar(
                  backgroundImage: NetworkImage(_recipe.image),
                  radius: 100,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
