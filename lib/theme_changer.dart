
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/Constants.dart';
import 'package:taxi/main.dart';

class ThemeBuilder extends StatefulWidget {
 final Widget Function (BuildContext context, Brightness brightness,bool changeWindow, bool unrealChange) builder;
 ThemeBuilder({this.builder});
 @override
  _ThemeBuilderState createState() => _ThemeBuilderState();
 static _ThemeBuilderState of(BuildContext context){
   return context.findAncestorStateOfType <_ThemeBuilderState>();
 }

}
class _ThemeBuilderState extends State<ThemeBuilder> {
  Brightness _brightness;
  bool changeWindow  = false;
  bool unrealChange = false;
  @override void initState () {
    super.initState();
    checkToken();
    changeToNightOrWhiteMode();
  }
  didChangeDependencies () {
    super.didChangeDependencies();
    changeToNightOrWhiteMode();
  }

  changeToNightOrWhiteMode ()  async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var mode =  await prefs.get("nightMode");
    setState(() {
      _brightness = mode == "white" ? Brightness.light:Brightness.dark;
    });
  }

 Future checkToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token =  prefs.getString("token");
    if(token != null){
      http.Response response = await http.get(Uri.parse('$Url/api/user/me'),headers: {
        "Authorization" : "Bearer $token"
      });
      var data = await jsonDecode(response.body);
     if(data["success"]) {
       setState(() {
         changeWindow = true;
       });
     }
     else{
       changeWindow = false;
     }

    }


  }


  void changeTheme () {
    setState(() {
      _brightness = _brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    });
  }
  void changeWindowHandler () {
      setState(() {
        changeWindow= true;
      });
  }
  void logOut() {
    setState(() {
      changeWindow = false;
    });
  }
   unrealForceUpdate () {
    setState(() {
      unrealChange = !unrealChange;
    });
  }
  Widget build(BuildContext context) {
    return widget.builder(context,_brightness,changeWindow,unrealChange);
  }
}
