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

  void changeText(String text){
    setState((){
      searchItem = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Food Recipe',style: TextStyle(color: Colors.white),)),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(text:  const TextSpan(
                children: [
                  TextSpan(text: "Make your own food,",
                    style: TextStyle(fontSize: 20,color: Colors.black),),
                  TextSpan(text: "\nStay",
                    style: TextStyle(fontSize: 20,color: Colors.black,
                        fontWeight: FontWeight.bold),),
                  TextSpan(text: " Home",
                    style: TextStyle(fontSize: 20,color: Colors.orange,
                        fontWeight: FontWeight.bold),)
                ]
            ),),

            const SizedBox(
              height: 10,
            ),

            TextField(
              controller: _textController,
              onChanged: changeText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
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

            )

          ],
        ),
      ),

    );;
  }
}

