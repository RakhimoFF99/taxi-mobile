import 'package:flutter/material.dart';
class myOrders extends StatelessWidget {
  final Brightness theme;
  myOrders({Key key,this.theme}):super(key:key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        Container(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Mening buyurtmalarim",style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18
              ),),
              SizedBox(height: 15,),
              Divider(height: 0,thickness: 1,color: Colors.orange[900],)

            ],
          ),),

    ]);

  }
}
