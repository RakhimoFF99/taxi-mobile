
import 'dart:convert';
import 'package:taxi/counterModel.dart';
import 'package:http/http.dart' as http;

class CounterPageModel_Api_Manager {
  Future <CounterModel> getDirections(uri,token) async {
    var client = http.Client();
    var counterModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        counterModel = CounterModel.fromJson(jsonMap);

      }
    } catch (Exception) {
      return counterModel;
    }

    return counterModel;
  }
}
