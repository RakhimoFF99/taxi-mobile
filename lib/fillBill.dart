import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Constants.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';

class fillBill extends StatefulWidget {
  final Brightness theme;
  fillBill({Key key,this.theme}):super(key:key);

  @override
  _fillBillState createState() => _fillBillState();
}

class _fillBillState extends State<fillBill> {
    Dio dio = Dio();
  TextEditingController _amount = TextEditingController();

  @override

  Widget build(BuildContext context) {

    return  Column(children: [
      Container(

          width: 159,
          height : 38,
          decoration: BoxDecoration(

          ),
          child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              child: Center(child: Text("Balansni to'ldirish",style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500
              ))),
              color: Color(0xffF7931E),
              onPressed: () {
                  createConfirmDialog(context);
              }) ),
      SizedBox(height: 20),
    ]
    );
  }
  createConfirmDialog(BuildContext context) {
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return AlertDialog(
        title: Text("Summani kirting",style: TextStyle(

        ),),
        content: TextField(
          keyboardType: TextInputType.number,
          autofocus: true,
          controller: _amount,

        ),
        actions: [
          Container(
            height: 38,
            width: 80,
            color: Color(0xffeeeeee),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Yopish",style: TextStyle(
                  color: Colors.black
              ),),
            ),
          ),
          Container(
            height: 38,
            width: 90,
            color: Colors.orange,
            child:MaterialButton(
              onPressed: () {
                sendPaymentValue();
                Navigator.pop(context);

              },
              child: Text("To'ldirish",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),),
            ),

          )

        ],
      );
    });
  }

Future sendPaymentValue () async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = await prefs.getString('id');

  var url = '$Url/api/driver/pay';
  Map maped = {
    "driver":id,
    "amount":int.parse(_amount.text) * 100
  };

  var response = await dio.post(url,data: maped);
  var statusCode = await jsonDecode(jsonEncode(response.statusCode));
  var data = await jsonDecode(jsonEncode(response.data));

  print(statusCode);
  if(statusCode == 200){
    print(data["url"]);
    openUrl(data["url"]);
  }


}
Future openUrl(url) async {
  if (await canLaunch(url))
  await launch(url);
  

}

}
