import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/image.dart';
import 'package:http/http.dart' as http;

class ProcessImage {

  Image img;

  ProcessImage({this.img});

  Future<void> getIngredients() async {

    try {
      // make the request
      // Response response = await get('https://timezone.abstractapi.com/v1/current_time?api_key=35629f1c13314218b3fd86d1972b01a8&location=$url');
      // Map data = jsonDecode(response.body);
      // print(data);

      String api_user_token = "eb46c8bd2280d383a0374db192c79d296e16e5d7";
      Map<String,String> headers = {'Authorization': 'Bearer ' + api_user_token};

      print(img);

    } catch (e) {
      print('caught error: $e');

    }

  }


}