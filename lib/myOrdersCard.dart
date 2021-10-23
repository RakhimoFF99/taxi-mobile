import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxi/DetailOrders.dart';
import 'package:taxi/main.dart';

class MyOrdersCard extends StatefulWidget {
  final Brightness theme;

  final toogleFunction;
  final data;

  MyOrdersCard({Key key,this.theme,this.data,this.toogleFunction}):super(key:key);

  @override

  _MyOrdersCardState createState() => _MyOrdersCardState();
}

class _MyOrdersCardState extends State<MyOrdersCard> {
  bool toogle = false;
  var toogler;
  orderRender() {
setState(() {
  toogler = !toogler;
});
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context) => DetailOrders(theme1: widget.theme,data: widget.data,toogler: widget.toogleFunction,)));
      },
      child: Container(
      width: 370,
      padding: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          boxShadow: theme ==Brightness.light ? [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 13,
              offset: Offset(0.5,4.0)
            )
          ] : null,
          color: theme == Brightness.dark  ? Color(0xff252831):Colors.white,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 15,left: 10),
                      child: Text(widget.data.to.region.name.uz.toString(),style: TextStyle(
                          color: Color(0xffF7931E),
                          fontSize: size.width / 33
                      ),
                      overflow: TextOverflow.visible,
                      ) ),
                  Container(
                    width:size.width/3,
                    padding: EdgeInsets.only(top: 8,left: 10),
                    child: Text(widget.data.to.name.uz.toString(),style: TextStyle(
                        fontSize: size.width / 25
                    ),
                    overflow: TextOverflow.visible,
                    ),)

                ],
              ),
              Container(
                  margin: EdgeInsets.only(top:15,left: 5,right: 5),
                  child: SvgPicture.asset('icons/arrow_forward.svg',width: size.width/15,)
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top:15,left: 10),
                    child: Text(widget.data.datumDo.region.name.uz.toString(),style: TextStyle(
                        color: Color(0xffF7931E),
                        fontSize: size.width / 33
                    ),overflow: TextOverflow.visible),
                  ),
                  Container(
                    width:size.width/3,
                    padding: EdgeInsets.only(top: 8,left: 10),
                    child: Text(widget.data.datumDo.name.uz,style: TextStyle(
                        fontSize: size.width / 25
                    ),
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
                padding: EdgeInsets.only(top: 15,right: 12,),
                child: Text(formatTime(widget.data.time),style: TextStyle(
                    fontSize: size.width / 35
                ),),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 11),
                    child: Text(widget.data.num.toString(),style: TextStyle(
                      fontSize: 16
                    ),)),
                  Container(
                    padding: EdgeInsets.only(top: 11,right: 3),
                    child: SvgPicture.asset('icons/carbon_person.svg',width: size.width/20,),)
                ],
              )
            ],
          )
        ],
      ),
    ),);
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
