import 'package:flutter/material.dart';
import 'package:recepie_app/data/category.dart';
import 'package:recepie_app/data/meal.dart';
import 'package:recepie_app/network_repository.dart';
import 'package:recepie_app/views/recipe_details.dart';

import '../data/meal_emlement.dart';

class Recipes extends StatefulWidget {
  final Category category;

  const Recipes({Key? key, required this.category}) : super(key: key);

  @override
  State<Recipes> createState() => _RecipesState();
}

class _RecipesState extends State<Recipes> {
  NetworkRepository networkRepository = NetworkRepository();

  List<MealElement> _mealList = [];

  @override
  void initState() {
    super.initState();
    getMeals();
  }

  void getMeals() {
    networkRepository.getMeals(widget.category.strCategory).then((value) {
      setState(() {
        if (value != null) {
          _mealList = value.meals;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Category category = widget.category;

    Orientation orientaion = MediaQuery
        .of(context)
        .orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Recipes List ${category.strCategory}',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: const BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(category.strCategoryThumb),
                    radius: 48,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: Text(
                        category.strCategoryDescription,
                        style: const TextStyle(fontSize: 16, color: Colors.white),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Recipe List',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(

              child: _mealList.isEmpty ? const Center( child: CircularProgressIndicator(value: 0.3,color: Colors.orange,),)  :GridView.builder(
                  itemCount: _mealList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (orientaion == Orientation.portrait)
                          ? 2
                          : 3,
                      childAspectRatio: (MediaQuery
                          .of(context)
                          .size
                          .height * 0.0015)),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) =>
                            RecipeDetails(mealElement: _mealList[index]),));
                      },
                      child: Card(
                        elevation: 2,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10))),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                  image: NetworkImage(
                                      _mealList[index].strMealThumb),
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Text(
                                  _mealList[index].strMeal,
                                  style: const TextStyle(
                                    fontSize: 14.0, color: Colors.orange,),
                                  maxLines: 1,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
