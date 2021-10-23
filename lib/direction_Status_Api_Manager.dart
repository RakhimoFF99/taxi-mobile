
import 'dart:convert';
import 'package:taxi/DirectionStatusModel.dart';
import 'package:http/http.dart' as http;

class Direction_Status_Api_Manager {

  Future <DirectionStatusModel> getDirections(uri,token) async {
    var client = http.Client();
    var directionStatusModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        directionStatusModel = DirectionStatusModel.fromJson(jsonMap);

      }
    } catch (Exception) {
      return directionStatusModel;
    }

    return directionStatusModel;
  }
}
