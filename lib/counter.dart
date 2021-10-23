import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi/DirectionModel.dart';
import 'package:taxi/counterModel.dart';
import 'package:taxi/counterPageModel_Api_Manager.dart';
import 'package:taxi/direction_Status_Api_Manager.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/main.dart';


class Counter extends StatefulWidget {
  final Brightness theme;
  var changeStatus;
  var toogleValue;
  var userData;

  Counter({this.theme,this.changeStatus,this.userData,this.toogleValue});


  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  static var from = ["Yo'nalishni tanlang"];
  String fromValue =  from.first;
  int fromIndex = 0;
  var fromCheckBoxList = [];
  bool showToDirection = false;
  bool showFromDirection = false;
  bool fromCheckBoxAll = false;
  bool toCheckBoxAll = false;
  var toCheckBoxList = [];
  var fromDirectionList = [];
  var toDirectionList = [];
  bool checkDirectionVal = false;

  static var to = ["Yo'nalishni tanlang",];
  int toIndex = 0;
  String toValue =  to.first;


  var directionBool = true;
  Future <CounterModel> counterPageModel;
  bool renderComponent = false;
  bool toogleVal = false;

  var driverData;
  int counter = 0;
  var token;

  @override
  void initState() {
    to = [];
    from = [];
    super.initState();
    readToken();
  }


  readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString("id");
    var data = await prefs.getString("token");
    var url = Uri.parse('$Url/api/region/all');

    token = data;
    counterPageModel = CounterPageModel_Api_Manager().getDirections(url, data);
    setState(() {
      toogleVal = !toogleVal;
    });
  }

  Future saveCounter() async {

    SharedPreferences counterSave = await SharedPreferences.getInstance();
    await counterSave.setString("counter", counter.toString());
    var result = await widget.changeStatus(fromDirectionList,toDirectionList);

    if (result["success"]) {
      await Fluttertoast.showToast(
          msg: "Saqlandi",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 18.0
      );
      widget.toogleValue(true);
    }
    else {
      return await Fluttertoast.showToast(
          msg: 'Xatolik yuz berdi',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 18.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => widget.toogleValue(),
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(15)
                ),

                child: Text("Orqaga", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Center(
                    child: Text("Mening joriy yo'lovchilarim", style: TextStyle(
                        fontSize: size.width / 21,
                        fontWeight: FontWeight.w500
                    ),),),
                  SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 256,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.orange),
                      ),
                      child: Row(
                        children: [
                          Container(
                              width: 62,
                              height: 50,
                              color: theme == Brightness.dark
                                  ? Colors.white
                                  : Color(
                                  0xffD8D8D8),
                              child: IconButton(
                                icon: Icon(Icons.remove, color: theme ==
                                    Brightness.dark
                                    ? Colors.black
                                    : null),
                                onPressed: () {
                                  setState(() {
                                    if (counter < 1) {
                                      return counter = 0;
                                    }
                                    counter = counter - 1;
                                  });
                                },
                              )),
                          Container(
                            width: 130,
                            height: 50,
                            child: Center(
                                child: Text(
                                  counter.toString() + " ta", style: TextStyle(

                                    fontSize: 18
                                ),)),
                          ),
                          Container(
                            width: 62,
                            height: 48,
                            child: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  counter = counter + 1;
                                });
                              },
                            ),
                            color: Color(0xffF7931E),
                          )
                        ],
                      ),

                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      FutureBuilder <CounterModel>(
                        future: counterPageModel,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data.data;
                            if (directionBool == true) {
                              addDirectionsToArray(data);
                              directionBool = false;
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  child: Text("Jo'nash manzili", style: TextStyle(
                                      fontSize: 20
                                  ),),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 45,
                                  width: 300,
                                  child:  dropDownFromDirection(),
                                  decoration: BoxDecoration(
                                      border : Border.all(color: theme == Brightness.light ? Orange :Colors.transparent,),
                                    color: theme == Brightness.light ? Colors.white:BoxColor,
                                    borderRadius: BorderRadius.circular(10)
                                  ),


                                ),
                                SizedBox(height: 10,),
                              showFromDirection ?  Container(
                                  child: Column(
                                    children: [
                                    Row(
                                    mainAxisAlignment: MainAxisAlignment
                                    .start,
                                    children: [
                                      Checkbox(activeColor: Colors.orange,value: fromCheckBoxAll,onChanged: (bool value) => tickAllFromCheckBox(value,snapshot.data.data[fromIndex].districts),),
                                      Container(
                                        child: Text(
                                              "Barcha yo'nalishlarni tanlash",
                                          style: TextStyle(
                                              fontSize: size.width / 26
                                          ),),

                                      ),


                                    ],),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: snapshot.data.data[fromIndex]
                                              .districts.length,
                                          itemBuilder: (context, index) {
                                            fromCheckBoxList.add(false);
                                            return Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .start,
                                              children: [
                                                Checkbox(activeColor: Colors.orange,
                                                    value: fromCheckBoxList[index],
                                                    onChanged: (value) =>
                                                        handleCheckBox(value, index,
                                                            snapshot.data
                                                                .data[fromIndex]
                                                                .districts[index].id,
                                                            "fromCheckBox",snapshot.data.data[fromIndex].districts.length)),
                                                Container(
                                                  child: Text(
                                                    snapshot.data.data[fromIndex]
                                                        .districts[index].name.uz,
                                                    style: TextStyle(
                                                        fontSize: size.width / 26
                                                    ),),

                                                ),


                                              ],);
                                          }),
                                    ],
                                  ),
                                  width: 300,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: theme == Brightness.light ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 13,
                                          offset: Offset(0.5,4.0)
                                      )
                                      ]:null,
                                      color: theme == Brightness.light ? Colors.white:BoxColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ):Container(),
                                SizedBox(height: 5,),
                                Container(
                                  child: Text("Borish manzili",style: TextStyle(
                                    fontSize: 20
                                  ),),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child:dropDownToDirection(),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  height: 45,
                                  width: 300,
                                  decoration: BoxDecoration(
                                     border : Border.all(color: theme == Brightness.light ? Orange :Colors.transparent,),
                                      color: theme == Brightness.light ? Colors.white:BoxColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                                SizedBox(height: 20,),
                              showToDirection ?  Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Checkbox(activeColor: Colors.orange,value: toCheckBoxAll,onChanged: (bool value) => tickAllToCheckBox(value, snapshot.data.data[toIndex].districts)),
                                          Container(
                                            child: Text(
                                              "Barcha yo'nalishlarni tanlash",
                                              style: TextStyle(
                                                  fontSize: size.width / 26
                                              ),),

                                          ),


                                        ],),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          itemCount: snapshot.data.data[toIndex]
                                              .districts.length,
                                          itemBuilder: (context, index) {
                                            toCheckBoxList.add(false);
                                            return Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .start,
                                                children: [
                                                  Checkbox(activeColor: Colors.orange,
                                                      value: toCheckBoxList[index],
                                                      onChanged: (value) =>
                                                          handleCheckBox(value, index,
                                                              snapshot.data
                                                                  .data[toIndex]
                                                                  .districts[index]
                                                                  .id, "toCheckBox",snapshot.data.data[toIndex].districts.length)),
                                                  Container(
                                                    child: Text(
                                                      snapshot.data.data[toIndex]
                                                          .districts[index].name.uz,
                                                      style: TextStyle(
                                                          fontSize: size.width / 26
                                                      ),),
                                                  ),



                                                ],),
                                            );
                                          }),
                                    ],
                                  ),
                                  width: 300,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      boxShadow: theme == Brightness.light ? [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 13,
                                          offset: Offset(0.5,4.0)
                                      )
                                      ]:null,
                                      color: theme == Brightness.light ? Colors.white:BoxColor,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                ):Container(),

                              ],
                            );
                          }
                          else {
                            return Center(
                              child: Column(
                                children: [
                                  SizedBox(height: 25,),
                                  CircularProgressIndicator(),
                                  SizedBox(height: 25,)
                                ],
                              ),
                            );
                          }
                        },),
                    ],
                  ),

                  SizedBox(height: 20,),
                  Container(
                    width: 270,
                    height: 38,
                    decoration: BoxDecoration(
                    ),
                    child: RaisedButton(

                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(child: Text("Saqlash", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ))),
                        color: Color(0xffF7931E),
                        onPressed: () {

                         toDirectionList.length > 0 && fromDirectionList.length > 0  ? saveData():EasyLoading.showError("Yo'nalishni to'liq kiriting");
                        }),)
                ],

              ),
            ),

          ]
      ),
    );
  }


 saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var clientCount = await prefs.setString('count', counter.toString());

    saveCounter();
  }

  dropDownFromDirection() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        value: fromValue,
        selectedItemBuilder: (_) {
          return  from
              .map((e) =>
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  e,
                ),
              ))
              .toList();
        },
        dropdownColor: theme == Brightness.light ? Colors.white:BoxColor,
        hint: Container(
            alignment: Alignment.centerLeft,
            child: Text("Yo'nalishni tanlang")),
        items:  from.map(
                (item) => DropdownMenuItem(child: Text(item), value: item,)
        ).toList(),

        onChanged: (value) {
          setState(() {
            fromIndex = from.indexOf(value);
            fromValue = value.toString();
            fromCheckBoxList = [];
            fromDirectionList = [];
            showFromDirection = true;

          });
        },

      ),
    );
  }

  dropDownToDirection() {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        isExpanded: true,
        value: toValue,
        selectedItemBuilder: (_) {
          return  to
              .map((e) =>
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  e,
                ),
              ))
              .toList();


        },
        hint: Container(
            alignment: Alignment.centerLeft,
            child: Text("Yo'nalishni tanlang")),
        dropdownColor: theme == Brightness.light ? Colors.white:BoxColor,
        items: to.first != null ? to.map(
                (item) => DropdownMenuItem(child: Text(item), value: item,)
        ).toList() :null,
        onChanged: (value,) {
          setState(() {
            toIndex = to.indexOf(value);
            toValue = value.toString();
            toCheckBoxList = [];
            toDirectionList = [];
            showToDirection = true;


          });
        },

      ),
    );
  }

  addDirectionsToArray(data) {
    for (int i = 0; i < data.length; i++) {
        to.add(data[i].name.uz.toString());
        from.add(data[i].name.uz.toString());
    }


  }
  handleCheckBox(bool value, index, id, type,districtLength) {

    if (type == 'fromCheckBox') {
      if (value) {
        setState(() {
          fromDirectionList.add(id);
        });
        if(fromDirectionList.length == districtLength){
          setState(() {
            fromCheckBoxAll = true;
          });
        }
      }
      else {
        setState(() {
          fromDirectionList.remove(id);
        });
        if(fromDirectionList.length != districtLength){
          setState(() {
            fromCheckBoxAll = false;
          });
        }
      }
      setState(() {
        fromCheckBoxList[index] = value;
      });
    }
    if(type == 'toCheckBox') {
      if (value) {
        setState(() {
          toDirectionList.add(id);
        });
        if(toDirectionList.length == districtLength){
          setState(() {
            toCheckBoxAll = true;
          });
        }
      }
      else {
        setState(() {
          toDirectionList.remove(id);
        });
        if(toDirectionList.length != districtLength){
          setState(() {
            toCheckBoxAll = false;
          });
        }
      }

      setState(() {
        toCheckBoxList[index] = value;
      });
    }
  }
  tickAllFromCheckBox(value,districts) {

   if(value){
     fromDirectionList =  [];
    for(int i = 0; i<districts.length; i++){
      fromCheckBoxList[i] = value;
      fromDirectionList.add(districts[i].id);
    }
    setState(() {
      fromCheckBoxAll = value;
      print(fromDirectionList);
    });
   }
   else {
     for(int i = 0; i<districts.length; i++){
       fromCheckBoxList[i] = value;
       fromDirectionList = [];
     }
     setState(() {
       fromCheckBoxAll = value;
       print(fromDirectionList);
     });
   }
  }
  tickAllToCheckBox(value,districts) {
    if(value){
      toDirectionList = [];
      for(int i = 0; i<districts.length; i++){
        toCheckBoxList[i] = value;
        toDirectionList.add(districts[i].id);
      }
      setState(() {
        toCheckBoxAll = value;
        print(toDirectionList);
      });
    }
    else {
      for(int i = 0; i<districts.length; i++){
        toCheckBoxList[i] = value;
        toDirectionList = [];
      }
      setState(() {
        toCheckBoxAll = value;
        print(toDirectionList);
      });
    }
  }

}

