import 'package:flutter/material.dart';

class statistics extends StatefulWidget {
  final Brightness theme;
  statistics({Key key,this.theme}):super(key:key);

  @override
  _statisticsState createState() => _statisticsState();
}

class _statisticsState extends State<statistics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text("Statistika",style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),),
            )
          ],
        ),
      ),
    );
  }
}
