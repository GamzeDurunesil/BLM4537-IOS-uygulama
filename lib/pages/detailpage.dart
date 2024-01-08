import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/pages/recipedetail.dart';

void main() {
  runApp(new MaterialApp(home: new detailpage()));
}

class detailpage extends StatefulWidget {
  @override
  _detailpageState createState() => _detailpageState();
}

class _detailpageState extends State<detailpage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(235, 235, 235, 10),
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(235, 235, 235, 10),
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.all(70),
              child: Text(
                "Tariflerim",
                style: TextStyle(
                    color: Color.fromRGBO(154, 82, 26, 1), fontSize: 25),
              ),
            ),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: detail(), //AppBars

      //BottomNavigationBAr
    ); //Scaffold
  }
}
