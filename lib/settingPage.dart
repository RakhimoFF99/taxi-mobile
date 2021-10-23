import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi/main.dart';
import 'package:taxi/Constants.dart';
import 'package:taxi/driverEditPage.dart';
import 'package:taxi/theme_changer.dart';

class SettingPage extends StatefulWidget {
  final Brightness theme;
  final userData;
  final data;
  final toogler;
  SettingPage({Key key,this.theme,this.userData,this.data,this.toogler}):super(key:key);



  @override
  _SettingPageState createState() => _SettingPageState();
}


class _SettingPageState extends State<SettingPage> {



  didChangeDependencies () {
    super.didChangeDependencies();
    checkNightMode();
    EasyLoading.dismiss();
  }

  PickedFile _image;
  Dio dio = Dio();
  bool lang = false;
  bool toogleButton = false;

  checkNightMode () {
    if(theme == Brightness.light)  {
      setState(() {
        toogleButton = true;
      });

    }
    else {
      setState(() {
        toogleButton = false;
      });
    }
  }
  toogleValue ()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeBuilder.of(context).changeTheme();
    setState(() {
      toogleButton = !toogleButton;
    });

    if(toogleButton) {
      prefs.setString("nightMode", "white");
    }
    else {
      prefs.setString("nightMode", 'dark');

    }
  }
  @override
  Widget build(BuildContext context) {

    String imgUrl = widget.userData.profilePhoto;
    return Container(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
                height: 200,
                child: Stack(
                  children: [
                    Positioned(child:Container(
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          boxShadow: theme ==Brightness.light ? [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 13,
                              offset: Offset(0.5,4.0)
                          )
                          ] : null,
                          borderRadius: BorderRadius.circular(5),
                          color: theme == Brightness.dark ? BoxColor : Colors.white
                      ),
                      width: 360,
                      height: 100,
                      padding: EdgeInsets.only(left: 10,right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 11),
                                width: 77,
                                height: 63,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: NetworkImage(Url  + imgUrl),
                                        fit: BoxFit.cover
                                    )

                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text("Ism : " + widget.data.name,style: TextStyle(
                                        fontSize: 16
                                    ),overflow: TextOverflow.ellipsis,),
                                    padding: EdgeInsets.only(left: 15,top:30,right: 10),
                                    width: 170,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15,top: 5,),
                                    child:Text("Id : " + widget.userData.number.toString(),style: TextStyle(
                                        fontSize: 14
                                    ),) ,
                                  ),
                                ],
                              ),

                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20,right: 10),
                            width: 35,
                            child: Center(
                              child: IconButton(icon:Center(child: Icon(Icons.edit,size: 20,color: Colors.white,))
                                , onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DriverEditPage())),
                              ),
                            ) ,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: theme ==Brightness.dark ? Color(0xff181818) : Orange
                            ),
                          ),
                        ],
                      ),
                    ), ) ,
                    Positioned(
                      top: 75,
                      right: 26,
                      child:  InkWell(
                        onTap: uploadAvatar ,
                        child: Container(
                          child: Image.asset('icons/addPhoto.png'),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color(0xffF29824),
                          ),
                          width: 40,
                          height: 40,

                        ),
                      ),),


                  ],
                )),
            Container(
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        Container(

                          child: Text("Buyurtma",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500

                          ),),
                          padding: EdgeInsets.only(right: 5),),
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text("12 ta buyurtma",style: TextStyle(
                            color: Color(0xff939393),
                            fontSize: 14,

                          ),),
                        )
                      ],),
                      Container(
                        child: Text("250000",style: TextStyle(
                            color:Color(0xff939393),
                            fontSize: 20
                        ),),)
                    ],

                  ),
                  Divider(thickness: 1,color: Color(0xff939393),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                        children: [
                          Container(child: Text("Tujjor komissiyasi",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500

                          ),),),
                          Container(
                            padding: EdgeInsets.only(top: 5,right: 20),
                            child: Text("Har bir zakazdan 11 %",style: TextStyle(
                              color: Color(0xff939393),
                              fontSize: 14,

                            ),),
                          )
                        ],),
                      Container(
                        child: Text("-62154",style: TextStyle(
                            color:Color(0xff939393),
                            fontSize: 20
                        ),),)
                    ],

                  ),
                  Divider(thickness: 1,color: Color(0xff939393),),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(child: Text("Tungi rejim",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                      ),)),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            AnimatedPositioned(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn,

                              left: toogleButton ? 0.0 : 15.0,
                              right: toogleButton ? 15.0 : 0.0,

                              child: InkWell(
                                onTap: toogleValue,
                                child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    transitionBuilder:(Widget child, Animation<double>animation) {
                                      return RotationTransition(child: child, turns: animation);
                                    },
                                    child: toogleButton ? Icon(
                                        Icons.circle,color: Colors.white, size: 22.0,key: UniqueKey()) :
                                    Icon(
                                        Icons.circle,color: Colors.white, size: 22.0,key: UniqueKey())
                                ),

                              ),
                            ),
                          ],
                        ),
                        height: 21.0,
                        width: 38.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14.0),
                            color: toogleButton ? Color(0xffD8D8D8) : Color(0xff09D81E)
                        ),
                      ),

                    ],),

                ],
              ),
            ),
              SizedBox(height: 30,),
            Container(

                width: 200,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Color(0xffF7931E),
                       ),
                    onPressed: () {

                    createConfirmDialog(context);
                }, child: Text("Chiqish",style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600
                ),)))
          ],),
      ),
    );
  }
 Future uploadAvatar ()  async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var id = await prefs.getString('id');
    try {
     final image = await ImagePicker().getImage(source: ImageSource.gallery,);
     setState(() {
       _image = image;
     });
    MultipartFile multipartFile = await MultipartFile.fromFile(
        _image.path,
        contentType: MediaType("image", "jpg")
    );
    FormData formData = FormData.fromMap(
     {
       "file":multipartFile
     }
    );
    EasyLoading.show(status: "Yuklanyapti",maskType: EasyLoadingMaskType.black);
    var response = await dio.put('$Url/api/driver/avatar/$id',data: formData);
    var data = jsonDecode(response.statusCode.toString());
    if(data == 200){
    EasyLoading.showSuccess("Mufaqqiyatli yuklandi");
      widget.toogler();
      setState(() {
        lang = !lang;
      });
    }
    else {
    EasyLoading.showError("Xatolik yuz berdi");
    }


    }
    catch (e) {
      print(e);
    }


 }
 logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    ThemeBuilder.of(context).logOut();
 }


  createConfirmDialog(BuildContext context) {
    return showDialog(barrierDismissible: false,context: context, builder: (context) {
      return AlertDialog(
        title: Text("Ishonchingiz komilmi ?"),
        actions: [
          Container(
            height: 38,
            width: 80,
            color: Color(0xffeeeeee),
            child: MaterialButton(
              onPressed:  () async {
                Navigator.pop(context);
              },
              child: Text("Yo'q",style: TextStyle(
                  color: Colors.black
              ),),
            ),
          ),
          Container(
            height: 38,
            width: 90,
            color:  Color(0xffF7931E),
            child:MaterialButton(
              onPressed: () async{
                Navigator.pop(context);
                logOut();
              },
              child: Text("Ha",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600
              ),),
            ),

          )

        ],
      );
    });
  }

}
