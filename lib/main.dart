import 'package:flutter/material.dart';

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
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Kin Rai Dee')),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
                child: Column(
              children: [
                Text('Food type'),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print('Meal card was pressed');
                        },
                        child: Card(
                          child: Icon(
                            Icons.set_meal,
                            size: 100,
                          ),
                          margin: EdgeInsets.all(25.0),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          print('Desert card was pressed');
                        },
                        child: Card(
                          child: Icon(
                            Icons.emoji_food_beverage,
                            size: 100,
                          ),
                          margin: EdgeInsets.all(25.0),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )

                //Text('Food type'),
                ),
            Card(
              child: Text('Kcal'),
            ),
            Card(
              child: Text('Nationally'),
            ),
            Card(
              child: Text('Random Food'),
            ),
          ],
        ),
      ),
    );
  }
}
