import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Constants {
  static ValueNotifier<String> _pageToShow = ValueNotifier<String>("Landing");

  ValueNotifier<String> getPageToShow() {
    return _pageToShow;
  }

  void setPageToShow(String newPage) {
    _pageToShow.value = newPage;
  }
}

const textInputDecoration = InputDecoration(
  hintText: 'Email',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2),
  ),
);

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }
}
