import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/EditPageModel.dart';
import 'package:taxi/editPage.dart';
import 'package:taxi/editPageModel_Api_Manager.dart';
import 'package:taxi/main.dart';
import 'package:taxi/Constants.dart';
import 'package:taxi/theme_changer.dart';
import 'package:taxi/changeDriverPassword.dart';

class DriverEditPage extends StatefulWidget {
  final Brightness theme;
  final renderParentComponent;

  DriverEditPage({Key key,this.theme,this.renderParentComponent}):super(key:key);



  @override
  _DriverEditPageState createState() => _DriverEditPageState();
}

class _DriverEditPageState extends State<DriverEditPage> {
  Future <EditPageModel> editPageModel;
  bool renderPage= false;
  bool showOptions = false;
  void initState() {
    super.initState();
    readToken();


  }

  renderComponent () {
   setState(() {
     Navigator.pop(context);
     renderPage = !renderPage;
   });
  }
  readToken ()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    var editUri = Uri.parse('$Url/api/driver/$id');
    var token = await prefs.getString("token");
    editPageModel = EditPageModel_Api_Manager().editDriverData(editUri, token);
    EasyLoading.show();
    setState(() {
      renderPage = !renderPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme == Brightness.light ? Colors.white: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Column(
            children: [
              SizedBox(height: 60,),

              SizedBox(height: 15,),
              FutureBuilder <EditPageModel> (
                  future: editPageModel,
                  builder: (context,snapshot) {

                    if(snapshot.hasData){
                      EasyLoading.dismiss();
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeDriverPassword())),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: theme ==Brightness.light ?  [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(0.2,2.0)
                              )
                              ]:null ,
                            color: theme ==Brightness.light ?  Colors.white:BoxColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.only(left: 10, right: 5),

                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Parolni o'zgartirish",style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Icon(Icons.chevron_right,size: 27,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),

                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(userData: snapshot.data.data,renderParentComponent: renderComponent,))),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: theme ==Brightness.light ? [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(0.5,4.0)
                                  )
                                  ] : null,
                                  color: theme ==Brightness.light ?  Colors.white:BoxColor,
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              padding: EdgeInsets.only(left: 10, right: 5),

                              height: 60,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Malumotni o'zgartirish",style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600
                                  ),),
                                  Icon(Icons.chevron_right,size: 27,)
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 15,),

                        ],

                      );

                    }
                    else {
                      return Container();
                    }
                  }
              ),


            ],
          ),
        ),
      ),
    );
  }

}
