import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi/DetailOrders.dart';
import 'package:taxi/Constants.dart';
import 'package:intl/intl.dart';
import 'package:taxi/main.dart';

class todaysOrdersCard  extends StatelessWidget {
  final data ;
  todaysOrdersCard({this.data});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>DetailOrders(data: data,))),
      child: Column(
        children: [
          Container(
            child:  Container(
              padding: EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                        child:Text(data.to.name.uz,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                        ),),
                        padding: EdgeInsets.only(left:10)
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                        child: new SvgPicture.asset("icons/arrow_forward.svg")
                    ),
                    Container(
                      child: Text(data.datumDo.name.uz,style: TextStyle(

                          fontSize: 16,
                          fontWeight: FontWeight.w400
                      ),),
                    )
                  ],
                ),

                Column(
                  children: [
                    Container(
                      child: Text(formatTime(data.time),style: TextStyle(
                          fontSize: 12
                      ),),

                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10,left: 5),
                          child: Text(data.num.toString(),style: TextStyle(
                              fontSize: 15
                          ),),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: SvgPicture.asset("icons/carbon_person.svg"),
                        ),


                      ],
                    )
                  ],)
              ],
            ),
            width: 360,

            decoration: BoxDecoration(
                border: Border.all(color: theme == Brightness.light ? Orange : Colors.transparent),
                borderRadius: BorderRadius.circular(5),
                color: theme == Brightness.dark ? BoxColor : null
            ),
          ),),

          SizedBox(height: 15)
        ],
      ),
    );
  }
  formatTime(time) {
    print(time);
    var hour = time / 3600;
    var rest = time % 3600;
    rest = rest / 60;
    print(hour.toStringAsFixed(0));

    return "${hour < 10 ? 0:""}${hour.toStringAsFixed(0)}:${rest <10 ? 0 :""}${rest.toStringAsFixed(0)}";
  }
}
