import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'dart:io';

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
