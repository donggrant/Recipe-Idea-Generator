import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipic/models/user.dart';
import 'package:recipic/pages/wrapper.dart';
import 'package:recipic/services/auth.dart';
import 'package:camera/camera.dart';

//Edited the main.dart to direct to newly designed UI elements

List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(cameras),
        //theme: ThemeData.dark(),
      ),
    );
  }
}
