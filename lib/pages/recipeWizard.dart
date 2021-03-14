import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/pages/camera.dart';
import 'dart:async';
import 'dart:io';
import 'package:recipic/services/process_image.dart';


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
            child: Column(
              children: [
                Text("Welcome to the new recipe wizard! Here you can add pictures of "
                    "the food that you want us to suggest a recipe for. You can also "
                    "add pictures of grocery store receipts - we'll simply read what "
                    "food items you purchased. The pictures you take will be shown "
                    "below."),
                SizedBox(height: 20),
                Text("You can also delete a picture you've taken by tapping on it. "
                    "Once you're done adding pictures, click the Next button."),
              ],
            ),
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
              onPressed: () {
                ProcessImage instance = ProcessImage(img:Constants().getPics()[0]);
                instance.getIngredients();
              },
            ),
          ),
        ]
      ),
    );
  }
}

class PicturesList extends StatefulWidget {
  @override
  _PicturesListState createState() => _PicturesListState();
}

class _PicturesListState extends State<PicturesList> {

  void deletePictureConfirmation(Image pic) {
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Picture?'),
          content: SingleChildScrollView(
            child: Text("Are you sure you want to delete this picture? This action cannot be undone."),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Constants().removePic(pic);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<int>(
        valueListenable: Constants().getNumOfPics(),
        builder: (BuildContext context, int value, Widget child) {
          return ListView.builder(
            itemCount: Constants().getNumOfPics().value,
            itemBuilder: (context, index) {
              Image currentPicture = Constants().getPics()[index];
              return GestureDetector(
                child: Card(
                  semanticContainer: true,
                  child: currentPicture,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 10,
                  margin: EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                ),
                onTap: () {
                  log("tapped picture");
                  deletePictureConfirmation(currentPicture);
                },
              );
            },
          );
        },
      ),
    );
  }
}
