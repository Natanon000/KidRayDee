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

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('Asset/Phadthai.jpg'),
                radius: 180,
              ),
              Container(
                margin: EdgeInsets.all(30.0),
                child: Text(
                  'Phad Thai',
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
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Column(
            children: [
              Text('Select Kcal'),
              Text('50 Kcal'),
              Slider(
                value: 50,
                min: 0,
                max: 100,
                divisions: 5,
                label: 50.round().toString(),
                onChanged: (double value) {
                  print(value);
                },
              ),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              Text('Nationally'),
              DropdownButton<String>(
                value: "Thai",
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.orange),
                underline: Container(
                  height: 2,
                  color: Colors.orange,
                ),
                onChanged: (String? newValue) {
                  print(newValue);
                },
                items: <String>['Thai', 'Japan', 'Western', 'Chinese']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),

          //child: Text('Nationally'),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 100.0),
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.shuffle,
              color: Colors.black87,
              size: 50.0,
            ),
            label: Text(
              'Random Food',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            onPressed: () {
              print('Random Food');
            },
            style: ElevatedButton.styleFrom(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
