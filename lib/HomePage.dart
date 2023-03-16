import 'dart:ui';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _textController = TextEditingController();

  String searchItem = "";

  void changeText(String text) {
    setState(() {
      searchItem = text;
    });
  }

  @override
  Widget build(BuildContext context) {
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
            Expanded(
                child: GridView.builder(
                    itemCount: 10,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3/2.61,
                      mainAxisSpacing: 12
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10),
                          child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: Colors.white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      SizedBox(
                                          height: 150,
                                          width: double.infinity,
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://cdn.pixabay.com/photo/2017/03/23/19/57/asparagus-2169305_960_720.jpg'),
                                          )),
                                      Positioned(
                                        child: SizedBox(
                                          child: Container(
                                            height: 40,
                                            width: double.infinity,
                                            color: Colors.black.withOpacity(.5),
                                          ),
                                        ),
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                      ),
                                      Positioned(
                                        child: Container(
                                          padding: EdgeInsets.all(10),

                                          child: Text(
                                            'Dessart',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                        ),
                                        bottom: 0,
                                        left: 0,
                                        right: 0,
                                      )
                                    ],
                                  )
                                ],
                              )));
                    }))
          ],
        ),
      ),
    );
    ;
  }
}
