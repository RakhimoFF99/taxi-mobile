import 'package:taxi/Constants.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  final Brightness theme;
  final userData;
  Balance({Key key,this.theme,this.userData}):super(key:key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  bool toogle = false;

  @override
  initState() {

    toogleValue();
    super.initState();
  }
  toogleValue () {
    setState(() {
      toogle = !toogle;
    });
  }
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 344,
          height: 65,
          child: Center(child: Text("Balans  : "+ widget.userData.balance.toString() + " so'm",style: TextStyle(
            fontSize: 22,
          ),),),
          decoration: BoxDecoration(
            border: Border.all(color: widget.theme ==Brightness.light ? Orange : Colors.transparent),
              color: widget.theme == Brightness.dark ? Color(0xFF252831) : Colors.transparent,
              borderRadius: BorderRadius.circular(10)

          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

}
