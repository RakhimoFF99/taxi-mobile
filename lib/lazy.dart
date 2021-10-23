import 'package:flutter/material.dart';

class Lazy extends StatefulWidget {
  @override
  _LazyState createState() => _LazyState();
}

class _LazyState extends State<Lazy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
        ),
      ),
    );
  }
}
