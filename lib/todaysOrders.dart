import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi/Constants.dart';
import 'package:taxi/ordersModel.dart';
import 'package:taxi/orders_api_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi/todaysOrdersCard.dart';


class TodaysOrders extends StatefulWidget {
  final Brightness theme;

  bool renderComponent = false;
  TodaysOrders({Key key,this.theme}):super(key:key);

  @override
  _TodaysOrdersState createState() => _TodaysOrdersState();





}

class _TodaysOrdersState extends State<TodaysOrders> {
  Future <OrderModel> orderModel;
  void initState() {
    readToken();
    super.initState();
  }

  readToken ()  async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = await prefs.getString('id');
    var orderUri = Uri.parse('$Url/api/order/driver/all/$id');
    var data = await prefs.getString("token");
    prefs.setString('token', data);
    orderModel = Orders_api_manager().getOrders(orderUri, data);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return  Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 2),
              child: Text("Yakunlangan buyurtmalar",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              )),
            ),
            SizedBox(height: 25),
            FutureBuilder <OrderModel> (
                future: orderModel,
                builder: (context,snapshot)  {
              if(snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data.data.length,
                    itemBuilder: (context,index){

                      return snapshot.data.data[index].status == 'success' ? todaysOrdersCard(data: snapshot.data.data[index]):Container();
                    });
              }
              else {
              return
                Center(
                  heightFactor: 12,
                    child: CircularProgressIndicator(),

              );
              }

            }),



          ],
        ), ),);

}

}
