import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RestorePassword extends StatefulWidget {


  @override
  _RestorePasswordState createState() => _RestorePasswordState();
}

class _RestorePasswordState extends State<RestorePassword> {
  TextEditingController _restorePhone = TextEditingController();
  TextEditingController _secretCode = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  int screenIndex = 0;
  var hash = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var screens =  [restoreWindow(size),sendCodeWindow(size),newPasswordWindow(size)];

    return Scaffold(
        backgroundColor: Color(0xff1A1B2F),
        body: screens[screenIndex]

    );
  }
  sendCodeWindow (size) {
    return  Container(
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
                    controller: _secretCode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {

                    },

                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock, color: Color(0xffF7931E),),
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

                  SizedBox(height: 25,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffF7931E),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        )),
                    onPressed: () {
                      setState(() {
                       _secretCode.text.length > 0 ? sendSecretCode():EasyLoading.showError("Kodni kiriting");
                      });
                    },
                    child: Container(
                      width: 300,
                      height: 40,
                      child: Center(
                        child: Text("Kodni yuborish"),
                      ),
                    ),),


                ],
              ),),),

        ],
      ),
    );
  }
restoreWindow (size) {
    return  Container(
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
                  Text("Parolni tiklash",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _restorePhone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) {

                    },

                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.call, color: Color(0xffF7931E),),
                        hintText: "Telefon raqamni kiriting",
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
                      setState(() {
                       _restorePhone.text.length > 0 ? sendPhoneNumber() :EasyLoading.showError("Telefon raqamni kiriting");
                      });
                    },
                    child: Container(
                      width: 300,
                      height: 40,
                      child: Center(
                        child: Text("Davom etish"),
                      ),
                    ),),


                ],
              ),),),

        ],
      ),
    );
}
newPasswordWindow(size) {
    return Container(
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
                  TextField(
                    controller: _newPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock, color: Color(0xffF7931E),),
                        hintText: "Yangi parolni kiriting ...",
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
                     _newPassword.text.length > 0 ? sendNewPassword():EasyLoading.showError("Yangi parolni kiriting");
                    },
                    child: Container(
                      width: 300,
                      height: 40,
                      child: Center(
                        child: Text("Davom etish"),
                      ),
                    ),),


                ],
              ),),),

        ],
      ),
    );
}
Future sendPhoneNumber () async{
    var phone = _restorePhone.text.split('+').join('');
    var url = Uri.parse("$Url/api/user/reset/phone");
    print(url);
    Map maped = {
      "phone":phone
    };
    try {
      http.Response  response  = await http.post(url,body:maped);
      var data = await jsonDecode(response.body);
      if(data["success"]) {
        setState(() {
          screenIndex++;
        });

      }
      else {
        EasyLoading.showError("Foydalanuvchi topilmadi");
      }

    }
    catch(e) {
      print(e);
    }


}
Future sendSecretCode () async{
  var phone = _restorePhone.text.split('+').join('');
  var url = Uri.parse("$Url/api/user/reset/check");
  print(url);
  Map maped = {
    "phone":phone,
    "code":_secretCode.text
  };
  try {
    http.Response  response  = await http.post(url,body:maped);
    var data = await jsonDecode(response.body);
    print(data);
    if(data["success"]) {
      setState(() {
        hash = data["data"]["hash"];
        screenIndex++;
      });

    }
    else {
      EasyLoading.showError("Kod noto'g'ri");
    }


  }
  catch(e) {
    print(e);
  }
}
Future sendNewPassword () async{
  var phone = _restorePhone.text.split('+').join('');
  var url = Uri.parse("$Url/api/user/reset/password");
  print(url);
  Map maped = {
    "phone":phone,
    "hash" :hash,
    "password":_newPassword.text

  };
  try {
    http.Response  response  = await http.post(url,body:maped);
    var data = await jsonDecode(response.body);
    print(data);
    if(data["success"]) {
      EasyLoading.showSuccess("Parol mufaqqiyatli o'zgardi");
      Navigator.pop(context);
    }
    else {
      EasyLoading.showError("Xatolik yuz berdi");
    }


  }
  catch(e) {
    print(e);
  }
}
}
