import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'launcher.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        setState(() {
          print(controller.value);
        });
      });

    controller.forward();
    Timer(
      Duration(seconds: 5),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Launcher()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var tween = ColorTween(
      begin: Colors.pink,
      end: Colors.amber,
    ).animate(controller);

    return Scaffold(
      backgroundColor: Color(0xfffefaf1).withOpacity(controller.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: DefaultTextStyle(
                child: AnimatedTextKit(
                  isRepeatingAnimation: false,
                  animatedTexts: [WavyAnimatedText('Kin Rai Dee')],
                ),
                style: TextStyle(
                  fontSize: 45.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xfff6772a),
                ),
              ),
            ),
            Center(
              child: Transform.rotate(
                angle: controller.value *
                    6.28, // radians (1 radians = pi/180 degrees)
                child: Container(
                  margin: EdgeInsets.all(35.0),
                  child: Image.asset('Asset/image/logo.png'),
                  height: controller.value * 300,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
