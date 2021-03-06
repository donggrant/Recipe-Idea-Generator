import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/pages/camera.dart';
import 'dart:async';
import 'dart:io';


class RecipeWizardAddPhotos extends StatelessWidget {

  var cameras;
  RecipeWizardAddPhotos(this.cameras);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6C63FF),
        elevation: 0.0,
        title: Text('Step 1: Add Photos'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 5.0),
            child: Text("Welcome to the new recipe wizard! Here you can add pictures of "
                "the food that you want us to suggest a recipe for. You can also "
                "add pictures of grocery store receipts - we'll simply read what "
                "food items you purchased. Once you're done adding pictures, click "
                "the Next button."),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Add Pictures of Food"),
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Camera(cameras)),
                  );
                },
              ),
              SizedBox(width: 20),
              RaisedButton(
                child: Text("Add Receipts"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Camera(cameras)),
                  );
                },
              ),
            ],
          ),
          Card(
            semanticContainer: true,
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              "images/apple.jpg",
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 10,
            margin: EdgeInsets.all(25),
          ),
        ],
      ),
    );;
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Picture Display')),
      body: Image.file(File(imagePath)),
    );
  }
}
