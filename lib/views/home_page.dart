import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:recepie_app/data/category.dart';
import 'package:recepie_app/data/category_model.dart';
import 'package:recepie_app/network_repository.dart';
import 'package:recepie_app/views/recipes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textController = TextEditingController();

  List<Category> _categories = [];

  NetworkRepository repository = new NetworkRepository();

  String searchItem = "";

  void changeText(String text) {
    setState(() {
      searchItem = text;
    });
  }

  @override
  void initState() {
    super.initState();
    findCategoryModel();
  }

  findCategoryModel() {
    repository.getCategories().then((value) {
      setState(() {
        if (value != null) {
          _categories = value.categories;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Orientation orientaion = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Food Recipe',
        style: TextStyle(color: Colors.white),
      )),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: "Make your own food,",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                TextSpan(
                  text: "\nStay",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: " Home",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _textController,
              onChanged: changeText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.orange),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                contentPadding: EdgeInsets.all(5),
              ),
              style: const TextStyle(color: Colors.black),
              maxLength: 20,
              maxLines: 1,
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Categories',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: GridView.builder(
                    itemCount: _categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientaion == Orientation.portrait) ? 2 : 3,
                            childAspectRatio:(MediaQuery.of(context).size.height * 0.0013)),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Recipes(
                                        category:
                                            _categories[index])));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                      height: 150,
                                      padding: EdgeInsets.all(5),
                                      child: Image(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                            '${_categories[index].strCategoryThumb}'),
                                      )),
                                  Positioned(
                                    bottom: -8,
                                    left: 0,
                                    right: 0,
                                    child: SizedBox(
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.black
                                                .withOpacity(.3),
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10))),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -8,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: Text(
                                        '${_categories[index].strCategory}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),maxLines: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
    ;
  }
}
