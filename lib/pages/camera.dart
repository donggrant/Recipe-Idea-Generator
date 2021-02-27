import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:recipic/models/constants.dart';
import 'package:recipic/models/favorite_recipe.dart';
import 'package:recipic/models/favorite_recipe_list.dart';
import 'package:recipic/services/auth.dart';
import 'package:recipic/services/database.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';


class Camera extends StatefulWidget {

  final CameraDescription camera;
  Camera(this.camera);
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {

  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.camera, ResolutionPreset.medium);
    controller.initialize().then((_){
      if(!mounted){
        return;
      }
      setState(() {});
      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!controller.value.isInitialized){
      return new Container();
    }
    return new AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: new CameraPreview(controller),
    );
  }
}