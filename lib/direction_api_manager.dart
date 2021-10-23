
import 'dart:convert';
import 'package:taxi/DirectionModel.dart';
import 'package:http/http.dart' as http;

class Direction_Api_Manager {

  Future <DirectionModel> getDirections(uri,token) async {
    var client = http.Client();
    var directionModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        directionModel = DirectionModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return directionModel;
    }

    return directionModel;
  }
}
