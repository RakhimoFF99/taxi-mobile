import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:taxi/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/main.dart';
import 'package:taxi/restorePassword.dart';
import 'package:taxi/theme_changer.dart';
import 'package:taxi/RegisterPage.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool validatePhone = false;
  bool validatePassword = false;
  bool isActive = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkActivation();
  }

  didChangeDependencies () {
    super.didChangeDependencies();
    checkActivation();
  }
  Future checkActivation () async{
    http.Response response = await http.get(Uri.parse("https://appelyor.herokuapp.com/"));
    var data = jsonDecode(response.body);
    if(data["success"]) {
        isActive = false;
    }
    else {
      isActive = true;
    }

  }
  @override
  Widget build(BuildContext context) {
    EasyLoading.dismiss();
    final Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: theme == Brightness.light ? Colors.white: Color(0xff1A1B2F),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: SingleChildScrollView(
                  child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: MultiValidator([
                        MinLengthValidator(1, errorText: "Telefon nomerni kiriting")
                      ]),
                      onChanged: (value) {
                        validateInput(value, "phone");
                      },
                      controller: _phone,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.call, color: Color(0xffF7931E),),
                          hintText: "Telefon",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0xffF7931E))
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffF7931E)
                              )
                          ),
                          hintStyle: TextStyle(
                              color: Color(0xffF7931E)
                          ),
                          contentPadding: EdgeInsets.only(top: 15)
                      ),

                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: MultiValidator([
                        MinLengthValidator(1, errorText: "Parolni kiriting"),
                      ]),
                      onChanged: (value) {
                        validateInput(value, "password");
                      },
                      controller: _password,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock_outlined, color: Color(0xffF7931E),),
                          hintText: "Parol",
                          enabledBorder: UnderlineInputBorder(

                              borderSide: BorderSide(color: Color(0xffF7931E))
                          ),

                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffF7931E)
                              )
                          ),
                          hintStyle: TextStyle(
                              color: Color(0xffF7931E)
                          ),
                          contentPadding: EdgeInsets.only(top: 15)
                      ),

                    ),

                    SizedBox(height: 25,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffF7931E),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )),
                      onPressed: () {
                     isActive ?   validatePhone && validatePassword ? LoginUser():EasyLoading.showError("Malumotlarni to'liq kiriting"):null;
                      },
                      child: Container(
                        width: 300,
                        height: 40,
                        child: Center(
                          child: Text("Kirish"),
                        ),
                      ),),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffF7931E),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )),
                      onPressed: () => isActive ? Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) =>  RegisterPage(loginContext: context,))):null,
                      child: Container(
                        width: 300,
                        height: 40,
                        child: Center(
                          child: Text("Ro'yxatdan o'tish"),
                        ),
                      ),),
                        SizedBox(height: 20,),
                      GestureDetector(
                        onTap:  () => isActive ? Navigator.push(context, MaterialPageRoute(builder: (context) => RestorePassword())):null,
                        child: Text("Parolni unutdingizmi ?",style: TextStyle(
                          fontSize: 16
                        ),),
                      )
                  ],
                ),),),

            ],
          ),
        ),
      ),
    );
  }

  Future LoginUser() async {
    var prefs = await SharedPreferences.getInstance();
    var phoneStr = _phone.text.split('+');
   _phone.text.length > 0 && _password.text.length > 0 ? EasyLoading.show() :null;
    var url = Uri.parse(
        '$Url/api/user/driver/login');
    var tokenUri = Uri.parse(
        '$Url/api/user/me');

    var token;
    var driverId;
    Map mapedData = {
      'password': _password.text,
      'phone': phoneStr.last
    };

    try {
      http.Response response = await http.post(url, body: mapedData);
      var data = await jsonDecode(response.body);
      print(data);
      if (data["success"]) {
        token = data["token"];

        http.Response tokenData = await http.get(
            tokenUri,
            headers: {
              'Authorization': 'Bearer $token'
            }
        );

        var json = await jsonDecode(tokenData.body);


        if (json["data"]["role"] == "driver") {
          saveData(token,json["driver"]["_id"],json["data"]["_id"]);
          ThemeBuilder.of(context).changeWindowHandler();


          return EasyLoading.showSuccess('Kirish mufaqqiyatli boldi');
        }
        else {
       return EasyLoading.showError("Xatolik yuz berdi");
        }
      }
      else {

     return  EasyLoading.showError( data["error"]["uz"]);
      }
    }
    catch (error) {
      print(error);
    }

  }



  saveData(String token ,String id,String userId) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userToken = await sharedPreferences.getString('token');
    await sharedPreferences.setString("id", id);
    await sharedPreferences.setString("userId", userId);
    await sharedPreferences.setString("token", token);





  }
  validateInput(value,typeField) {
    if(typeField == "phone") {
      if(value.length > 0){
        setState(() {
          validatePhone = true;
        });
      }
      else {
        setState(() {
          validatePhone = false;
        });
      }
    }

    if(typeField == "password") {
      if(value.length > 0){
        setState(() {
          validatePassword = true;
        });
      }
      else {
        setState(() {
          validatePassword = false;
        });
      }
    }


  }

}
