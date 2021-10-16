import 'package:enum_to_string/enum_to_string.dart';

enum FoodType {
  meal,
  dessert,
}

final String tableFood = 'tbFood';
final String columnId = 'id';
final String columnFoodName = 'foodName';
final String columnFoodType = 'foodType';
final String columnCalories = 'calories';
final String columnNationality = 'nationality';
final String columnDescription = 'description';
final String columnImg = 'img';
final List<String> nationalities = ['Thai', 'Japanese', 'Chinese', 'Western'];

class Food {
  int? id;
  final String foodName;
  final FoodType foodType;
  final double calories;
  final String nationality;
  final String description;
  final String img;

  Food(
    this.foodName,
    this.foodType,
    this.calories,
    this.nationality,
    this.description,
    this.img,
  );

  Food.f(
    this.id,
    this.foodName,
    this.foodType,
    this.calories,
    this.nationality,
    this.description,
    this.img,
  );

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnFoodName: foodName,
      columnFoodType: EnumToString.convertToString(foodType),
      columnCalories: calories,
      columnNationality: nationality,
      columnDescription: description,
      columnImg: img,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
