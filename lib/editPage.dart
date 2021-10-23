import 'dart:convert';
import 'dart:io';

import 'package:taxi/Constants.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/main.dart';


String carNumberInput = "";
String carTypeInput = "";

class EditPage extends StatefulWidget {
  final userData;
  final renderParentComponent;

  const EditPage({Key key,this.userData,this.renderParentComponent}) : super(key: key);

  @override

  _EditPageState createState() => _EditPageState();
}
class _EditPageState extends State<EditPage> {


  bool texImages = false;
  bool driveImages = false;
  bool passportPhoto = false;
  Dio dio = Dio();
  List f = [];

  List  passportImages = [];
  List  texPassportImages= [];
  List  driverLicenceImages = [];
  var collection  = ["passportImages","texPassportImages","driverLicenceImages"];



  File _image;

  Widget buildGridView(file) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
              shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: 7,
                children: List.generate(file.length, (index){

                if(file[index] is PickedFile){
                  print(file[index]);
                return Image.file(File(file[index].path));
                }
                else {
                      return Image.network(Url + file[index]);


                }





    }),

              ),
    );
  }


  loadAssets(type,selected,) async {
    List  resultList = [];

    try {
      resultList = await ImagePicker().getMultiImage(imageQuality: 60,maxWidth: 800,maxHeight: 600);
      if(resultList.length > 3) {
        resultList.removeRange(3, resultList.length);
      }


    } on Exception catch (e) {
      print(e.toString());
    }



    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
      if(type=="texPassport") {
       return setState(() {
          texPassportImages = resultList;
          texImages = true;

        });
      }
      else if (type=="driverLicenceImage"){
       return setState(() {
         driveImages = true;
          driverLicenceImages = resultList;

        });
      }
      else if (type == "passportImage"){
        return setState(() {
          passportPhoto = true;
          passportImages = resultList;
        });
      }

  }




  @override


  Widget build(BuildContext context) {

  carTypeInput = widget.userData.car.type;
  carNumberInput = widget.userData.car.number;
    return Scaffold(
      backgroundColor: theme == Brightness.light  ? Colors.white: Colors.black,
      body: SafeArea(
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          child: Form(
            child:SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text("Malumotlarni o'zgartirish",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(

                            boxShadow: theme == Brightness.light ? [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 13,
                                offset: Offset(0.5,4.0)
                            )
                            ]:null,
                        borderRadius: BorderRadius.circular(10),
                        color:theme == Brightness.light ? Colors.white:BoxColor
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal:10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Text("Mashina rusumi",style: TextStyle(
                            fontSize: 16
                          ),),
                        SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border:Border.all(color: Colors.orange,width: 2)
                            ),
                            child: TextField(

                              controller: TextEditingController(text: carTypeInput.length > 0 ? carTypeInput : widget.userData.car.type),
                              onChanged: (value) {
                                getInputValue("typeInput",value);
                              },
                              keyboardType: TextInputType.text,
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
                          SizedBox(height: 10,),
                          Text('Mashina raqami',style: TextStyle(
                            fontSize: 16,

                          ),),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),

                                border:Border.all(color: Colors.orange,width: 2)
                            ),
                            child: TextField(
                              controller: TextEditingController(text:carNumberInput.length > 0 ? carNumberInput : widget.userData.car.number),
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                getInputValue("numberInput",value);
                              },
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
                          SizedBox(height: 15,),
                          Text(" Tex Passportning suratini yuklash",style: TextStyle(
                              fontSize: 18
                          ),),

                          texImages || widget.userData.files.tex.length > 0 ?  SizedBox(
                            child: buildGridView(texPassportImages.length>0 ? texPassportImages : widget.userData.files.tex,)):Container(),
                        SizedBox(height: 15,),
                          InkWell(
                            onTap: () => loadAssets("texPassport",texPassportImages),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.orange,
                                        width: 2
                                    )
                                ),
                                width: 100,
                                height: 40,

                                child: Center(child: Text("Yuklash"),)
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text("Haydovchilik guvohnoma suratini yuklash",style: TextStyle(
                                fontSize: 18
                            ),),
                          ),


                          driveImages || widget.userData.files.prava.length > 0 ?  SizedBox(
                            child: buildGridView(driverLicenceImages.length >0 ? driverLicenceImages : widget.userData.files.prava,),) :Container(),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: () => loadAssets("driverLicenceImage",driverLicenceImages,),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.orange,
                                        width: 2
                                    )
                                ),
                                width: 100,
                                height: 40,

                                child: Center(child: Text("Yuklash"),)
                            ),
                          ),

                          SizedBox(height: 20),
                          Text("Passportning suratini yuklash",style: TextStyle(
                              fontSize: 18
                          ),),

                          passportPhoto || widget.userData.files.passport.length > 0 ?  SizedBox(
                            child: buildGridView(passportImages.length> 0 ? passportImages : widget.userData.files.passport,),) :Container(),
                          SizedBox(height: 15,),
                          InkWell(
                            onTap: () => loadAssets('passportImage',passportImages,),
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.orange,
                                        width: 2
                                    )
                                ),
                                width: 100,
                                height: 40,

                                child: Center(child: Text("Yuklash"),)
                            ),
                          ),

                          SizedBox(height: 20),
                          Container(

                              height : 38,
                              decoration: BoxDecoration(

                              ),
                              child: Center(
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                    child: Center(child: Text("Saqlash",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                    ))),
                                    color: Color(0xffF7931E),
                                    onPressed:  ()  {
                                      saveUserData();


                                    }),
                              ) ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
 Future saveImage ()  async {
   EasyLoading.show(
       status: "Yuklanmoqda",
       maskType: EasyLoadingMaskType.black
   );
   List <int> passportImageData;
   List <int> texPassportImageData;
   List <int> driverLicenceImageData;
   List passport = [];
   List textpassPort = [];
   List driverLicence = [];
   SharedPreferences prefs = await SharedPreferences.getInstance();
   var id = await prefs.getString('id');
   for (var i = 0; i < collection.length; i++) {
     if (collection[i] == "passportImages") {
       var data = passportImages;
       if (data != null) {
         for (var j = 0; j < data.length; j++) {
    ;
           MultipartFile multipartFile = await MultipartFile.fromFile(
               passportImages[j].path,
               contentType: MediaType("image", "jpg")
           );
           passport.add(multipartFile);
         }
       }
     }

     else if (collection[i] == "texPassportImages") {
       var data = texPassportImages;
       if (data != null) {
         for (var j = 0; j < data.length; j++) {

           MultipartFile multipartFile = await MultipartFile.fromFile(
               texPassportImages[j].path,
               contentType: MediaType("image", "jpg")
           );

           textpassPort.add(multipartFile);
         }
       }
     }
     else if (collection[i] == "driverLicenceImages") {
       var data = driverLicenceImages;
       if (data != null) {
         for (var j = 0; j < data.length; j++) {

           MultipartFile multipartFile = await MultipartFile.fromFile(
               driverLicenceImages[j].path,
               contentType: MediaType("image", "jpg")
           );
           driverLicence.add(multipartFile);
         }
       }
     }
   }


   try {
     FormData formData = FormData.fromMap({
       "prava":driverLicence.length > 0 ? driverLicence : widget.userData.files.prava,
       "passport":passport.length > 0 ? passport : widget.userData.files.passport,
       "tex" : textpassPort.length > 0 ? textpassPort : widget.userData.files.tex
     });



     var response = await dio.put("$Url/api/driver/$id",data: formData);
     print(jsonDecode(jsonEncode(response.data)));
     var json =  await jsonDecode(response.statusCode.toString());
     if(json == 200) {
       if(!widget.userData.isActive) {
         EasyLoading.dismiss();
         return  notifyClient(context);
       }
       Navigator.pop(context);
       widget.renderParentComponent();
       EasyLoading.showSuccess("Mufaqqiyatli yuklandi");

     }
     else {
    EasyLoading.showError("Xatolik yuz berdi");
     }

   }
   catch (e) {
     print(e);
   }

}
  Future saveUserData () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    var url = '$Url/api/driver/json/$id';
    Map mapedData = {
      "car" : {
        "type":carTypeInput,
        "number":carNumberInput
      }};


    await saveImage();

    var response = await dio.put(url,data: mapedData);
    var toJson =  await jsonDecode(jsonEncode(response.data));


  }



  notifyClient(BuildContext context) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
          title:  Text("Malumotlaringiz jo'natildi. Xizmat ko'rsatishga ruhsat berilishini kuting"),
        elevation: 2,


      );
    });
  }

  getInputValue (input,value) {
    if(input == "numberInput"){
        carNumberInput = value;
    }
    else {
      carTypeInput = value;
    }
  }
}
