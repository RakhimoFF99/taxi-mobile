
import 'package:flutter/material.dart';
import 'package:taxi/Constants.dart';

class infoCard extends StatelessWidget {
  final Brightness theme;
  final driver;
  final data;

  infoCard({this.theme,this.driver,this.data});



  @override




  Widget build(BuildContext context) {
   String imgUrl = driver.profilePhoto;
      return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: theme ==Brightness.light ? [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 13,
                  offset: Offset(0.5,4.0)
              )
            ] : null,
            borderRadius: BorderRadius.circular(10),
            color: theme == Brightness.dark ? Color(0xff252831):Colors.white ,
          ),
          width: 343,
          height: 160,
          child: Column(
            children: [
              SizedBox(height: 13),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: theme == Brightness.light ? Orange :Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(Url + imgUrl),
                        fit: BoxFit.cover
                    )

                ),
                width: 98.0,
                height: 81.0,

              ),
              SizedBox(height: 15),
              Text(data.name,style: TextStyle(
                  fontSize: 18
              ),),
              SizedBox(height: 5),
              Center(child: Text("ID: " + driver.number.toString(),style: TextStyle(
                  fontSize: 14

              ),),),

            ],
          ),


        ),
        SizedBox(height: 25),
      ],
    );
  }
}
