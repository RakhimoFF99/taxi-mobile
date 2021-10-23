import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter_svg/flutter_svg.dart";
import 'package:taxi/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:taxi/main.dart';

class DetailOrders extends StatefulWidget {
  Brightness theme1;
  var data;
  final toogler;
  final orderRender;
  DetailOrders({this.theme1, this.data, this.toogler, this.orderRender});
  @override
  _DetailOrdersState createState() => _DetailOrdersState();
}

class _DetailOrdersState extends State<DetailOrders> {
  bool toogle = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    EasyLoading.dismiss();
    return Scaffold(
      backgroundColor: theme == Brightness.dark ? Colors.black : Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          Center(
            child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: theme == Brightness.light
                          ? Orange
                          : Colors.transparent),
                  borderRadius: BorderRadius.circular(5),
                  color: theme == Brightness.dark
                      ? Color(0xff252831)
                      : Colors.white,
                ),
                margin: EdgeInsets.only(left: 15, right: 15, top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            width: 380,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 10),
                                            child: Text(
                                              widget.data.to.region.name.uz,
                                              style: TextStyle(
                                                  color: Color(0xffF7931E),
                                                  fontSize: size.width / 33),
                                              overflow: TextOverflow.visible,
                                            )),
                                        Container(
                                          width: size.width / 3,
                                          padding:
                                              EdgeInsets.only(top: 8, left: 10),
                                          child: Text(
                                            widget.data.to.name.uz,
                                            style: TextStyle(
                                                fontSize: size.width / 25),
                                            overflow: TextOverflow.visible,
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                        alignment: Alignment.topCenter,
                                        padding:
                                            EdgeInsets.only(right: 4, top: 25),
                                        child: SvgPicture.asset(
                                            'icons/arrow_forward.svg',
                                            width: size.width / 15)),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 15, left: 10),
                                          child: Text(
                                            widget.data.datumDo.region.name.uz,
                                            style: TextStyle(
                                                color: Color(0xffF7931E),
                                                fontSize: size.width / 33),
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                        Container(
                                          width: size.width / 3,
                                          padding:
                                              EdgeInsets.only(top: 8, left: 10),
                                          child: Text(
                                            widget.data.datumDo.name.uz,
                                            style: TextStyle(
                                                fontSize: size.width / 25),
                                            overflow: TextOverflow.visible,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 15,
                                        right: 12,
                                      ),
                                      child: Text(
                                        formatTime(widget.data.time),
                                        style: TextStyle(
                                            fontSize: size.width / 35),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(top: 11),
                                            child: Text(
                                              widget.data.num.toString(),
                                              style: TextStyle(fontSize: 16),
                                            )),
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: 11, right: 3),
                                            child: SvgPicture.asset(
                                              'icons/carbon_person.svg',
                                              width: size.width / 20,
                                            ))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          widget.data.status == "pending"
                              ? Column(
                                  children: [
                                    Divider(
                                        thickness: 1, color: Color(0xff939393)),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.person,
                                              color: Color(0xffF7931E)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 12),
                                          child: Text(
                                            widget.data.user.name,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1, color: Color(0xff939393)),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.date_range,
                                              color: Color(0xffF7931E)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 12),
                                          child: Text(
                                            formatDate(widget.data.date),
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    Divider(
                                        thickness: 1, color: Color(0xff939393)),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Icon(Icons.message,
                                              color: Color(0xffF7931E)),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            left: 12,
                                          ),
                                          child: Text(
                                            widget.data.comment,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )
                              : Container()
                        ],
                      ),
                    ),
                    widget.data.status == "payed" ||
                            widget.data.status == "success"
                        ? Column(
                            children: [
                              Divider(thickness: 1, color: Color(0xff939393)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.person,
                                        color: Color(0xffF7931E)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                      widget.data.user.name,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                              Divider(thickness: 1, color: Color(0xff939393)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.call,
                                        color: Color(0xffF7931E)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                      widget.data.user.phone,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                              Divider(thickness: 1, color: Color(0xff939393)),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Icon(Icons.date_range,
                                        color: Color(0xffF7931E)),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 12),
                                    child: Text(
                                      formatDate(widget.data.date),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  )
                                ],
                              ),
                              Divider(thickness: 1, color: Color(0xff939393)),
                              Row(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(left: 23),
                                      child: Icon(
                                        Icons.message,
                                        color: Colors.orange,
                                      )),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Text(
                                        widget.data.comment,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          )
                        : Container(),
                  ],
                )),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: widget.data.status == "pending"
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    onPressed: () {
                      createConfirmDialog(context, "Taqdilaysizmi?", "confirm");
                    },
                    child: Center(
                      child: Text(
                        "Qabul qilish",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : Container(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: widget.data.status == "pending"
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    onPressed: () {
                      createConfirmDialog(
                          context, "Bekor qilasizmi?", "cancel");
                    },
                    child: Center(
                      child: Text(
                        "Bekor qilish",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : Container(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: widget.data.status == "payed"
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    onPressed: () {
                      createConfirmDialog(context, "Yakunlaysizmi", "done");
                    },
                    child: Center(
                      child: Text(
                        "Yakunlash",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                : Container(),
          )
        ],
      )),
    );
  }

  closeDialog() {
    Navigator.pop(context);
  }

  createConfirmDialog(BuildContext context, text, action) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              text,
              style: TextStyle(),
            ),
            actions: [
              Container(
                height: 38,
                width: 70,
                color: Color(0xffeeeeee),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yo'q",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: 38,
                width: 70,
                color: Colors.orange,
                child: MaterialButton(
                  onPressed: () {
                    confirmOrder(action);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Ha",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          );
        });
  }

  Future confirmOrder(action) async {
    if (action == "done") {
      return completeOrder();
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString("id");
    var url = Uri.parse('$Url/api/driver/$action');
    var mapedData = {'driver': id, 'order': widget.data.id};
    try {
      http.Response response = await http.post(url, body: mapedData);
      var data = await jsonDecode(response.body);
      print(data);
      if (action == "confirm") {
        if (data["success"]) {
          EasyLoading.showSuccess("Tasdiqlandi");
          widget.toogler();
          Navigator.pop(context);
          setState(() {
            toogle = !toogle;
          });
        } else {
          EasyLoading.showError(data['data']['message']['uz']);
        }
      } else if (action == "cancel") {
        if (data["success"]) {
          EasyLoading.showSuccess("Bekor qilindi");
          Navigator.pop(context);
          widget.toogler();
          setState(() {
            toogle = !toogle;
          });
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future completeOrder() async {
    EasyLoading.show();
    var url = Uri.parse('$Url/api/driver/end');
    var mapedData = {'order': widget.data.id};
    try {
      http.Response response = await http.post(url, body: mapedData);
      var data = await jsonDecode(response.body);
      if (data["success"]) {
        EasyLoading.showSuccess("Buyurtma yakunlandi");
        widget.toogler();
        Navigator.pop(context);
        setState(() {
          toogle = !toogle;
        });
      } else {
        EasyLoading.showError(data["message"]);
      }
    } catch (e) {
      EasyLoading.showError("Xatolik yuz berdi");
      widget.toogler();
      Navigator.pop(context);
      setState(() {
        toogle = !toogle;
      });
    }
  }

  formatTime(time) {
    print(time);
    var hour = time / 3600;
    var rest = time % 3600;
    rest = rest / 60;
    print(hour.toStringAsFixed(0));

    return "${hour < 10 ? 0 : ""}${hour.toStringAsFixed(0)}:${rest < 10 ? 0 : ""}${rest.toStringAsFixed(0)}";
  }

  formatDate(date) {
    var dt = DateTime.parse(date.toString());
    // return "${hour < 10 ? 0:""}${hour.toStringAsFixed(0)}:${rest <10 ? 0 :""}${rest.toStringAsFixed(0)}";
    return DateFormat("dd-MM-yyyy").format(dt);
  }
}
