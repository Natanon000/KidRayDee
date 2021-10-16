import 'package:flutter/material.dart';
import 'package:kindraidee/app_magic.dart';
import 'package:kindraidee/page/result_page.dart';
import 'result_page.dart';
import '../model/food.dart';

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  AInputPageState createState() => AInputPageState();
}

class AInputPageState extends State<InputPage> {
  FoodType? selectedFoodType = null;
  int maxKcal = 500;
  String selectedNationality = 'Thai';
  String selectedNationalityFlag = 'th';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        setState(() {
                          print('Meal card was pressed');
                          if (selectedFoodType == FoodType.meal) {
                            selectedFoodType = null;
                          } else {
                            selectedFoodType = FoodType.meal;
                          }
                        });
                      },
                      child: Card(
                        color: selectedFoodType == FoodType.meal
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
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
                        setState(() {
                          print('Desert card was pressed');
                          if (selectedFoodType == FoodType.dessert) {
                            selectedFoodType = null;
                          } else {
                            selectedFoodType = FoodType.dessert;
                          }
                        });
                      },
                      child: Card(
                        color: selectedFoodType == FoodType.dessert
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
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
                Text('Maximum Kcal'),
                Text(
                  '$maxKcal Kcal',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Slider(
                  value: maxKcal.toDouble(),
                  min: 100,
                  max: 2000,
                  divisions: 190,
                  onChanged: (double value) {
                    setState(() {
                      maxKcal = value.round();
                    });
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                          'icons/flags/png/$selectedNationalityFlag.png',
                          package: 'country_icons'),
                    ),
                    DropdownButton<String>(
                      value: selectedNationality,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.orange),
                      underline: Container(
                        height: 2,
                        color: Colors.orange,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNationality = newValue!;
                          switch (newValue) {
                            case 'Thai':
                              selectedNationalityFlag = 'th';
                              break;
                            case 'Japanese':
                              selectedNationalityFlag = 'jp';
                              break;
                            case 'Western':
                              selectedNationalityFlag = 'us';
                              break;
                            case 'Chinese':
                              selectedNationalityFlag = 'cn';
                              break;
                          }
                          print(newValue);
                        });
                      },
                      items: <String>['Thai', 'Japanese', 'Western', 'Chinese']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
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
              onPressed: () async {
                print('Random Food');
                AppMagic app = new AppMagic();
                Food f = await app.randomFoodByCriteria(
                  selectedFoodType,
                  maxKcal,
                  selectedNationality,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResultPage(f)),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ],
      ),

      //body: MainPage(),
    );
  }
}
