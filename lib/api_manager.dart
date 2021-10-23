

import 'dart:convert';
import 'package:taxi/Model.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/theme_changer.dart';

class API_Manager {

  Future <Data> getNews(uri,token) async {
    var client = http.Client();
    var userModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        userModel = Data.fromJson(jsonMap);
      }

    } catch (e) {
      print(e);
      return userModel;
    }

    return userModel;
  }
}
