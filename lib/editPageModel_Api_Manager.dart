
import 'dart:convert';
import 'package:taxi/EditPageModel.dart';
import 'package:http/http.dart' as http;

class EditPageModel_Api_Manager {

  Future <EditPageModel> editDriverData(uri,token) async {
    var client = http.Client();
    var editPageModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        editPageModel = EditPageModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return editPageModel;
    }

    return editPageModel;
  }
}
