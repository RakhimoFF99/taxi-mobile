import 'dart:async';
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/Constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:taxi/main.dart';
import 'package:taxi/theme_changer.dart';
class RegisterPage extends StatefulWidget {
    var loginContext;
    RegisterPage({this.loginContext});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var serviceType = ["people", "cargo"];
  bool checkCode = false;
  int _groupValue = 0;
  bool validatePhone = false;
  bool validatePassword = false;
  bool validateName = false;
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _secretCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    EasyLoading.dismiss();
    return Scaffold(
        backgroundColor: theme == Brightness.light ? Colors.white : Color(
            0xff1A1B2F),
        body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50,),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: !checkCode ? Container(
                      margin: EdgeInsets.only(left: 5),

                      padding: EdgeInsets.all(4),
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Icon(Icons.arrow_back),
                          Text("Orqaga", style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          ),),

                        ],
                      ),
                    ) : Container(),),

                  SingleChildScrollView(
                      child: checkCode ? secretCodeInput() : Container(
                          height: 400,
                          child:  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: MultiValidator([
                                    MinLengthValidator(1, errorText: "Ismni kiriting")
                                  ]),
                                  controller: _name,
                                  onChanged: (value) {
                                    validateInput(value, "name");
                                  },
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.person, color: Color(0xffF7931E),),
                                      hintText: "Ism",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffF7931E))
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
                                    MinLengthValidator(1, errorText: "Telefon nomerni kiriting")
                                  ]),
                                  controller: _phone,
                                  onChanged: (value) {
                                    validateInput(value, "phone");
                                  },
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.call, color: Color(0xffF7931E),),
                                      hintText: "Telefon",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffF7931E))
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
                                  controller: _password,
                                  onChanged: (value) {
                                    validateInput(value, "password");
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock_outlined,
                                        color: Color(0xffF7931E),),
                                      hintText: "Parol",
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffF7931E))
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Radio(
                                        value: 0,
                                        groupValue: _groupValue,
                                        onChanged: handleValue,
                                      ),
                                    ),
                                    Text("Odam tashish"),
                                    Container(
                                      child: Radio(
                                        value: 1,
                                        groupValue: _groupValue,
                                        onChanged: handleValue,
                                      ),
                                    ),
                                    Text("Yuk tashish"),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Color(0xffF7931E),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)
                                      )),
                                  onPressed: () {
                                    validateName && validatePassword && validatePhone ? registerationUser():EasyLoading.showError("Malumotlarni to'liq kiriting");
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 40,
                                    child: Center(
                                      child: Text("Ro'yxatdan o'tish"),
                                    ),
                                  ),),
                              ],),
                          )
                      )


                ],
              ),),
            ))
    );
  }

  secretCodeInput() {
    return Container(
      child: Column(
        children: [
          Text(""),
          SizedBox(height: 40,),
          Text("Telefoningizga sms shaklida kod yuborildi", style: TextStyle(
              fontSize: 16,
              color: Colors.orange
          ),),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: TextFormField(
              autofocus: true,
              controller: _secretCode,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Color(0xffF7931E),),
                  hintText: "Kodni kiriting ...",
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
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Color(0xffF7931E),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                )),
            onPressed: () {
              _secretCode.text.length > 0 ? sendSecretCode() : null;
            },
            child: Container(
              width: 200,
              height: 40,
              child: Center(
                child: Text("Yuborish"),
              ),
            ),),
        ],
      ),
    );
  }

  Future sendSecretCode() async {
    var phoneStr = _phone.text.split('+');
    try {
      var url = Uri.parse('$Url/api/user/activate');
      Map mapedData = {
        'phone': phoneStr.last,
        "code": _secretCode.text
      };
      EasyLoading.show();

      http.Response response = await http.post(url, body: mapedData);

      var data = await jsonDecode(response.body);

      if (data["success"]) {
        LoginUser();

      }
      else {
        EasyLoading.showError("Kod noto'gri");
      }
    }
    catch (e) {
      EasyLoading.showError("Xatolik yuz berdi");
    }
  }

  Future registerationUser() async {
    EasyLoading.show();
    var phoneStr = _phone.text.split('+');
    var url = Uri.parse('$Url/api/user/register');
    Map mapedData = {
      'name': _name.text,
      'password': _password.text,
      'phone': phoneStr.last,
      'type': serviceType[_groupValue],
      "role": "driver"
    };
    try {
      http.Response response = await http.post(url, body: mapedData);
      var data = await jsonDecode(response.body);
      print(data);
      EasyLoading.dismiss();
      if (data['success']) {
        setState(() {
          checkCode = true;
        });
      }
      else {
        EasyLoading.showError(data["data"]);
      }
    }
    catch (error) {
      EasyLoading.showError(error);
    }
  }

  void handleValue(int value) {
    setState(() {
      _groupValue = value;
    });
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


    if(typeField == "name") {
      if(value.length > 0){
        setState(() {
          validateName = true;
        });
      }
      else {
        setState(() {
          validateName = false;
        });
      }
    }

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
          Navigator.pop(context);
          ThemeBuilder.of(widget.loginContext).changeWindowHandler();
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

}



