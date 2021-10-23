import 'dart:convert';

import 'package:taxi/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:taxi/fillBill.dart";
import "package:taxi/Balance.dart";
import 'package:taxi/ordersModel.dart';
import 'package:taxi/orders_api_manager.dart';
import "package:taxi/settingPage.dart";
import "package:taxi/infoCard.dart";
import 'package:taxi/myOrders.dart';
import 'package:taxi/counter.dart';
import 'package:taxi/myOrdersCard.dart';
import 'package:taxi/todaysOrders.dart';
import 'package:taxi/theme_changer.dart';
import 'package:taxi/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:taxi/api_manager.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi/Model.dart';

void main() {
  runApp(Myapp());
}

var theme;
bool toogleButton = false;
int selectItem = 0;

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class Myapp extends StatelessWidget {
  const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeBuilder(
      builder: (context, _brightness, changeWindow, unrealChange) {
        print(_brightness);
        theme = _brightness;
        return MaterialApp(
          title: "SafarExpress - Driver",
          theme: ThemeData(primaryColor: Colors.blue, brightness: _brightness),
          debugShowCheckedModeBanner: false,
          home: changeWindow ? HomePage() : LoginPage(),
          builder: EasyLoading.init(),
        );
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  Future<Data> userModel;
  Future<OrderModel> orderModel;
  Dio dio = Dio();
  bool toogleVal = false;
  bool renderComponent = false;
  bool iconToogle = true;
  var tokenUri = Uri.parse('$Url/api/user/me');

  @override
  void initState() {
    readToken();
    super.initState();
  }

  didChangeDependencies() {
    super.didChangeDependencies();
    readToken();
  }

  toogler() {
    setState(() {
      toogleButton = false;
    });
    readToken();
  }

  readToken() async {
    EasyLoading.dismiss();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');

    print(id);
    var userToken = await prefs.getString("token");
    userModel = API_Manager().getNews(tokenUri, userToken);
    setState(() {
      renderComponent = !renderComponent;
    });
  }

  toogleValue(value) {
    if (value) {
      setState(() {
        toogleButton = !value;
      });
    } else {
      setState(() {
        toogleButton = !toogleButton;
      });
    }
  }

  Future changeStatus(fromDirection, toDirection) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    var token = await prefs.get("token");
    var countPeople = await prefs.get("count");
    var url = "$Url/api/driver/status/$id";

    Map body = {
      "person": countPeople,
      "to": fromDirection,
      "do": toDirection,
      "status": true.toString(),
    };
    try {
      var response = await dio.put(url, data: body);
      var data = await json.decode(jsonEncode(response.data));
      toogleValue(true);
      return data;
    } catch (e) {
      print(e);
    }
  }

  // ignore: must_call_super

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme == Brightness.dark ? Colors.black : Colors.white,
      body: SafeArea(
          child: FutureBuilder<Data>(
              future: userModel,
              builder: (context, snapshot) {
                print(snapshot.data);

                if (snapshot.hasData) {
                  var status = snapshot.data.driver.status;
                  var isActive = snapshot.data.driver.isActive;
                  var data = snapshot.data;

                  final List<Widget> _children = [
                    MainPage(
                      userData: data.driver,
                      data: data.data,
                      toogler: toogler,
                    ),
                    TodaysOrders(theme: theme),
                    SettingPage(
                      theme: theme,
                      userData: data.driver,
                      data: data.data,
                      toogler: toogler,
                    )
                  ];

                  return Container(
                      child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        !isActive
                            ? Text(
                                "Iltimos faol holatga o'ting",
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              )
                            : Container(),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: size.width,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topRight,
                                width: size.width,
                                child: _children[selectItem] == _children[0] &&
                                        toogleButton == false &&
                                        snapshot.data.driver.isActive
                                    ? AnimatedContainer(
                                        duration: Duration(milliseconds: 300),
                                        child: Stack(
                                          children: [
                                            AnimatedPositioned(
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeIn,
                                              left: snapshot.data.driver.status
                                                  ? 0.0
                                                  : 15.0,
                                              right: snapshot.data.driver.status
                                                  ? 15.0
                                                  : 0.0,
                                              child: InkWell(
                                                onTap: () async {
                                                  if (snapshot
                                                      .data.driver.status) {
                                                    createConfirmDialog(
                                                        context);
                                                  }

                                                  toogleValue(snapshot
                                                      .data.driver.status);
                                                },
                                                child: AnimatedSwitcher(
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    transitionBuilder:
                                                        (Widget child,
                                                            Animation<double>
                                                                animation) {
                                                      return RotationTransition(
                                                          child: child,
                                                          turns: animation);
                                                    },
                                                    child: iconToogle
                                                        ? Icon(Icons.circle,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            key: UniqueKey())
                                                        : Icon(Icons.circle,
                                                            color: Colors.white,
                                                            size: 22.0,
                                                            key: UniqueKey())),
                                              ),
                                            ),
                                          ],
                                        ),
                                        height: 21.0,
                                        width: 38.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(14.0),
                                            color: snapshot.data.driver.status
                                                ? Colors.green
                                                : Colors.red),
                                      )
                                    : null,
                              ),
                              SizedBox(height: 10),
                              toogleButton
                                  ? Counter(
                                      userData: data.driver.id,
                                      changeStatus: changeStatus,
                                      toogleValue: toogler,
                                      theme: theme,
                                    )
                                  : _children[selectItem]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: theme == Brightness.light
              ? [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 13,
                      offset: Offset(0.5, 4.0))
                ]
              : null,
        ),
        child: SizedBox(
            height: 56,
            child: toogleButton
                ? null
                : BottomNavigationBar(
                    selectedItemColor: Colors.red,
                    unselectedItemColor: Colors.white,
                    currentIndex: selectItem,
                    onTap: (index) {
                      setState(() {
                        toogler();
                        selectItem = index;
                      });
                    },
                    backgroundColor: theme == Brightness.light
                        ? Colors.white
                        : Color(0xff252831),
                    type: BottomNavigationBarType.fixed,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                            color: selectItem == 0
                                ? Color(0xffF7931E)
                                : Colors.greenAccent,
                          ),
                          label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.people,
                            color: selectItem == 1
                                ? Color(0xFFF7931E)
                                : Colors.greenAccent,
                          ),
                          label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.settings,
                            color: selectItem == 2
                                ? Color(0xFFF7931E)
                                : Colors.greenAccent,
                          ),
                          label: "")
                    ],
                  )),
      ),
    );
  }

  createConfirmDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Ishonchingiz komilmi ?"),
            actions: [
              Container(
                height: 38,
                width: 80,
                color: Color(0xffeeeeee),
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Orqaga",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                height: 38,
                width: 90,
                color: Colors.orange,
                child: MaterialButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    var userId = await prefs.getString("id");
                    var url = Uri.parse("$Url/api/driver/status/$userId");
                    http.Response response =
                        await http.put(url, body: {"status": "false"});
                    toogler();
                    Navigator.pop(context);
                  },
                  child: Text(
                    "O'chirish",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          );
        });
  }
}

class MainPage extends StatefulWidget {
  final userData;
  final data;
  final toogler;
  MainPage({this.userData, this.data, this.toogler});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool toogleVal = false;
  bool renderComponent = false;
  Future<OrderModel> orderModel;
  void initState() {
    super.initState();
    readToken();
  }

  toogle() {
    readToken();
  }

  readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    var orderUri = Uri.parse('$Url/api/order/driver/all/$id');
    var data = await prefs.getString("token");
    prefs.setString('token', data);

    orderModel = Orders_api_manager().getOrders(orderUri, data);

    setState(() {
      widget.toogler();
      renderComponent = !renderComponent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      infoCard(
        theme: theme,
        driver: widget.userData,
        data: widget.data,
      ),
      Balance(
        theme: theme,
        userData: widget.userData,
      ),
      fillBill(theme: theme),
      myOrders(theme: theme),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: FutureBuilder<OrderModel>(
                future: orderModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 10),
                          child: snapshot.data.data.length > 0
                              ? Text(
                                  "Yangi buyurtmalar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (context, index) {
                              SizedBox(
                                height: 20,
                              );
                              return snapshot.data.data[index].status ==
                                      "pending"
                                  ? Column(
                                      children: [
                                        MyOrdersCard(
                                          theme: theme,
                                          data: snapshot.data.data[index],
                                          toogleFunction: toogle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                      ],
                    );
                  } else {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: FutureBuilder<OrderModel>(
                future: orderModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 5),
                          child: snapshot.data.data.length > 0
                              ? Text(
                                  "Qabul qilingan buyurtmalar",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                )
                              : Container(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: snapshot.data.data.length,
                            itemBuilder: (context, index) {
                              SizedBox(
                                height: 20,
                              );
                              return snapshot.data.data[index].status == "payed"
                                  ? Column(
                                      children: [
                                        MyOrdersCard(
                                          theme: theme,
                                          data: snapshot.data.data[index],
                                          toogleFunction: toogle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Container();
                            }),
                      ],
                    );
                  } else {
                    return Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                }),
          ),
        ],
      )
    ]);
  }
}
