import 'dart:developer';
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
          PicturesList(),
          SizedBox(height: 20),
          Center(
            child: RaisedButton(
              child: Text("Next"),
              onPressed: () {},
            ),
          ),
        ]
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("Image path: $imagePath");
    log("Rebuilding PicturesList...");
    return Scaffold(
      appBar: AppBar(title: Text('Picture Display')),
      body: Column(
        children: [
          Center(child: Image.file(File(imagePath))),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                child: Text("Use this Picture"),
                onPressed: () {
                  Constants().addPic(Image.file(File(imagePath)));
                  log("${Constants().getNumOfPics().value.toString()} pictures taken so far");
                  Navigator.pop(context); // pop once to go back to the camera screen
                  Navigator.pop(context); // pop again to go back to page 1 of the recipe wizard
                },
              ),
              SizedBox(width: 20),
              RaisedButton(
                child: Text("Retake Picture"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PicturesList extends StatefulWidget {
  @override
  _PicturesListState createState() => _PicturesListState();
}

class _PicturesListState extends State<PicturesList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: Constants().getNumOfPics(),
        builder: (BuildContext context, int value, Widget child) {
          return ListView.builder(
            itemCount: Constants().getNumOfPics().value,
            itemBuilder: (context, index) {
              return Card(
                semanticContainer: true,
                child: Constants().getPics()[index],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 10,
                margin: EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0)
              );
            },
          );
        },
      ),
    );
  }
}
