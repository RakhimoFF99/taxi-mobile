
import 'dart:convert';
import 'package:taxi/ordersModel.dart';
import 'package:http/http.dart' as http;

class Orders_api_manager {

  Future <OrderModel> getOrders(uri,token) async {
    var client = http.Client();
    var directionModel;

    try {
      var response = await client.get(uri,headers: {
        "Authorization" : "Bearer $token"
      });
      print(response.body);
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        print(jsonMap);
        directionModel = OrderModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return directionModel;
    }

    return directionModel;
  }
}
