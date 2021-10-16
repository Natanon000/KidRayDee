import 'dart:math';

import 'db_helper.dart';
import 'model/food.dart';
import 'page/input_page.dart';

class AppMagic {
  AInputPageState inputSelected = new AInputPageState();

  List<Food> foodList = <Food>[];
  List<Food> foodSlected = <Food>[];
  List<Food> none = <Food>[];

  Future<Food> randomFoodByCriteria(
      FoodType? type, int kcal, String nationality) async {
    List<Food> found = await DatabaseHelper.instance
        .queryFoodByCriteria(type, kcal, nationality);

    print('found ' + found.length.toString() + ' dishes');
    if (found.length > 0) {
      Random random = new Random();
      int randNum = random.nextInt(found.length);
      return found[randNum];
    } else {
      return new Food("Not found", FoodType.meal, 0, "",
          "Cannot find any food that matches your criteria", "");
    }
  }

  AppMagic() {
    foodList = [
      new Food('Gang Massaman', FoodType.meal, 325, 'Thai', 'good',
          'Asset/image/GangMassaman.jpg'),
      new Food('Pad Thai', FoodType.meal, 616, 'Thai', 'good',
          'Asset/image/PadThai.jpg'),
      new Food('Onigiri', FoodType.meal, 203, 'Japan', 'good',
          'Asset/image/Onigiri.jpg'),
      new Food('Thai Coconut Pancakes', FoodType.dessert, 210, 'Thai', 'good',
          'Asset/image/ThaiCoconutPancakes.jpg'),
      new Food('Dorayaki', FoodType.dessert, 190, 'Japan', 'good',
          'Asset/image/Dorayaki.jpg'),
      new Food('Thai Tapioca Dumplings', FoodType.dessert, 51, 'Thai', 'good',
          'Asset/image/ThaiTapiocaDumplings.jpg'),
    ];

    none = [
      new Food('No match Food ', FoodType.meal, 0, 'Thai', 'oops',
          'Asset/image/none.png')
    ];
  }

  Food getTotallyRandomFood1() {
    for (int i = 0; i < foodList.length; i++) {
      Food temp = foodList[i];
      if (temp.foodType == inputSelected.selectedFoodType &&
          temp.calories.round() <= inputSelected.maxKcal &&
          temp.nationality == inputSelected.selectedNationality) {
        foodSlected.add(temp);
        print(foodSlected);
      } else {
        //foodSlected.add(temp);
      }
    }
    Random random = new Random();
    int randomNumber = random.nextInt(foodSlected.length); // number from 0 to 2
    return foodSlected[randomNumber];
  }

  Food getTotallyRandomFood(FoodType? a, int b, String c) {
    for (int i = 0; i < foodList.length; i++) {
      Food temp = foodList[i];
      if (temp.foodType == a &&
          temp.calories.round() <= b &&
          temp.nationality == c) {
        foodSlected.add(temp);
        print(foodSlected);
      }
    }

    if (foodSlected.length == 0) {
      return none[0];
    } else {
      Random random = new Random();
      int randomNumber =
          random.nextInt(foodSlected.length); // number from 0 to 2
      return foodSlected[randomNumber];
    }
  }
}
