import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi/main.dart';

class ChangeDriverPassword extends StatefulWidget {


  @override
  _ChangeDriverPasswordState createState() => _ChangeDriverPasswordState();
}

class _ChangeDriverPasswordState extends State<ChangeDriverPassword> {
  String value1;
  String value2;
  bool toogleValue = false;
  TextEditingController password1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
          backgroundColor: theme == Brightness.light ? Colors.white:Colors.black,
          body: SingleChildScrollView(
            child: Container(

              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  Text("Parolni o'zgartirish",style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700
                  ),),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    decoration: BoxDecoration(
                        boxShadow: theme == Brightness.light ? [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 13,
                            offset: Offset(0.5,4.0)
                        )
                        ]:null,
                        color:theme == Brightness.light ? Colors.white : BoxColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Yangi parolni kiriting",style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(

                              borderRadius: BorderRadius.circular(8),
                              color: theme == Brightness.light ? Colors.white:Colors.black,
                              border:Border.all(color: Colors.orange,width: 2)
                          ),
                          child: TextField(
                            controller: password1,

                            onChanged: (String str) {
                              value1 = str;
                              checkValue();
                            },
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintStyle: TextStyle(


                              ),
                              labelStyle: TextStyle(

                              ),

                              border:InputBorder.none,
                            ),
                            style: TextStyle(

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text("Yangi parolni takrorlang",style: TextStyle(

                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: theme == Brightness.light ? Colors.white:Colors.black,
                              border:Border.all(color: Colors.orange,width: 2)
                          ),
                          child: TextField(
                            onChanged: (String str) {
                              value2 = str;
                              checkValue();
                            },
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              hintStyle: TextStyle(


                              ),
                              labelStyle: TextStyle(

                              ),

                              border:InputBorder.none,
                            ),
                            style: TextStyle(

                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          height: 45,
                          child: ElevatedButton(
                            onPressed: toogleValue ? () {
                                saveDriverPassword();
                            } : null,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.orange),
                            ),
                            child: Center(
                              child: Text("Saqlash",style: TextStyle(
                                  fontSize: 20
                              ),),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),




                ],
              ),
            ),
          )
      ),
    );
  }
  checkValue () {
    if(value1 == value2){
      setState(() {
        toogleValue = true;
      });
    }
    else {
      setState(() {
        toogleValue = false;
      });
    }
    if(value1 ==""|| value2 ==""){
      setState(() {
        toogleValue = false;
      });
    }
  }

 Future saveDriverPassword ()  async{
    EasyLoading.show();
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var userId = await prefs.getString('userId');
   var url = Uri.parse("$Url/api/user/password/$userId");
   Map map = {
     'password':password1.text
   };
   http.Response response = await http.put(url,body:map);
   var data = jsonDecode(response.body);
if(data["success"]){
  Navigator.pop(context);
 EasyLoading.showSuccess("Parol saqlandi");

}
else {
  EasyLoading.showError("Xatolik yuz berdi");
}

 }
}
