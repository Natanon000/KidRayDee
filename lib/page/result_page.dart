import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kindraidee/model/food.dart';
import 'package:kindraidee/model/food.dart';
import '../model/food.dart';

class ResultPage extends StatelessWidget {
  final Food resultfood;
  ResultPage(this.resultfood);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Kin Rai Dee')),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: resultfood.img.length != 0
                  ? CircleAvatar(
                      radius: 150,
                      backgroundImage: FileImage(File(resultfood.img)),
                    )
                  : CircleAvatar(
                      radius: 150,
                      backgroundImage: AssetImage('Asset/image/A.jpg'),
                    ),
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                resultfood.foodName,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            )
          ],
        ),
      ),

      //body: MainPage(),
    );
  }
}
