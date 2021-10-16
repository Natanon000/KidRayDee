import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kindraidee/model/food.dart';
import 'package:kindraidee/db_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'food_view_page.dart';
import 'fooddetail_page.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  // declare _foodList as future list
  Future<List<Food>>? _foodList;
  // count number of food records in the database
  int _count = 0;

  initState() {
    super.initState();
    _foodList = _getFoodRecords();
  }

  Future<List<Food>> _getFoodRecords() async {
    return await DatabaseHelper.instance.queryAllFood();
  }

  Future<void> _showConfirmDialog(Food food) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletion Confirmation'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('You are about to delete ${food.id} from the database?'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                onPrimary: Colors.white,
              ),
              child: Text('Yes'),
              onPressed: () {
                DatabaseHelper.instance.deleteFood(food.id!);
                Navigator.of(context).pop();
                setState(() {
                  _foodList = _getFoodRecords();
                  print('refresh after delete');
                });
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Food List')),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // prepare the food data to be inserted
                    int num = _count + 1;
                    String name = 'New food $num';
                    // If num is even, this food is meal. Otherwise, dessert
                    FoodType type =
                        num % 2 == 0 ? FoodType.meal : FoodType.dessert;

                    Food f = await DatabaseHelper.instance.insert(new Food(
                        name,
                        type,
                        900,
                        'Thai',
                        'default food',
                        'Asset/image/A.jpg'));

                    print('The inserted food is ${f.foodName}');
                    _foodList = _getFoodRecords();
                    setState(() {
                      print('refresh foodList after inserted');
                      print(_foodList); // to print foodList on the console
                    });
                  },
                  child: Text('Insert Food'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.instance.deleteAllFood();
                    setState(() {
                      _foodList = _getFoodRecords();
                      print('refresh after delete');
                    });
                  },
                  child: Text('Delete Food'),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Food>>(
                future: _foodList,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.done:
                      if (snapshot.hasData) {
                        List<Food> foodList = snapshot.data!;
                        _count = foodList.length;
                        if (foodList.isEmpty) {
                          return _buildNoDataCard();
                        } else {
                          return _buildFoodListView(foodList);
                        }
                      } else {
                        return _buildLoadingScreen();
                      }
                    default:
                      return _buildLoadingScreen();
                  }
                },
              ), // End FutureBuilder
            ), // End Expanded
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailPage(),
            ),
          );
          setState(() {
            _foodList = _getFoodRecords();
            print('refresh add new custom food');
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildLoadingScreen() {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNoDataCard() {
    return SizedBox(
      child: new Card(
        child: Center(child: Text('NO FOOD DATA')),
      ),
      width: double.infinity,
    );
  }

  Widget _buildFoodListView(List<Food> foodList) {
    return ListView.builder(
      itemCount: foodList.length,
      itemBuilder: (BuildContext context, int index) {
        Food item = foodList[index];
        return new Slidable(
          actionPane: SlidableDrawerActionPane(),
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => FoodView(item))),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              //leading: CircleAvatar(
              //  radius: 28,
              //  backgroundImage: AssetImage(item.img),
              //),
              leading: Hero(
                tag: item,
                child: item.img.length == 0
                    ? CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('Asset/image/A.jpg'),
                      )
                    : CircleAvatar(
                        radius: 28,
                        backgroundImage: FileImage(File(item.img)),
                      ),
              ),

              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.id != null ? item.id.toString() : ''),
                  Text(
                    item.foodName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(item.foodType.toString()),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              icon: Icons.create_sharp,
              caption: 'EDIT',
              color: Colors.blue,
              closeOnTap: false,
              onTap: () async {
                print("Edit ${item.id} is Clicked");
                final value = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailPage(item),
                  ),
                );
                setState(() {
                  _foodList = _getFoodRecords();
                  print('refresh edit food');
                });
              },
            )
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              icon: Icons.delete,
              color: Colors.red,
              caption: 'Delete',
              closeOnTap: false, //list will not close on tap
              onTap: () {
                print("Delete ${item.id} is Clicked");
                _showConfirmDialog(item);
              },
            ),
          ],
        );
      },
    );
  }
}
