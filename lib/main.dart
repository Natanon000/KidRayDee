import 'package:flutter/material.dart';
import 'package:kindraidee/page/welcome_page.dart';
import 'page/result_page.dart';
import 'page/input_page.dart';
import 'page/launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kin Rai Dee',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: WelcomePage(),
    );
  }
}
