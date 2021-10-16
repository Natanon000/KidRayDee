import 'dart:io';
import 'package:flutter/material.dart';

import 'model/food.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _dbName = 'appDatabase.db';
  static final _dbVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database _database;

  Future<Database> get database async {
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    // default document directory
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    print('Creating a tableFood in appDatabase');
    await db.execute(''' CREATE TABLE $tableFood ( 
    $columnId integer primary key autoincrement, 
    $columnFoodName text not null, 
    $columnFoodType text not null, 
    $columnCalories double not null, 
    $columnNationality text not null, 
    $columnDescription text not null, 
    $columnImg text not null) ''');
  }

  //Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return new inserted record
  Future<Food> insert(Food food) async {
    print('Insert a new food record');
    Database db = await instance.database;
    food.id = await db.insert(tableFood, food.toMap());
    return food;
  }

  Future<List<Food>> queryAllFood() async {
    print('Query all food in the tableFood');
    Database db = await instance.database;
    List<Food> foods = [];
    List<Map> maps = await db.query(tableFood);
    if (maps.isNotEmpty) {
      maps.forEach((e) {
        FoodType foodType =
            EnumToString.fromString(FoodType.values, e[columnFoodType])!;

        foods.add(new Food.f(
            e[columnId],
            e[columnFoodName],
            foodType, //Enum
            e[columnCalories].toDouble(),
            e[columnNationality],
            e[columnDescription],
            e[columnImg]));
      });
    }
    return foods;
  }

  Future<void> deleteAllFood() async {
    Database db = await instance.database;
    await db.delete(tableFood);
  }

  Future<Food> update(Food food) async {
    Database db = await instance.database;
    food.id = await db.update(tableFood, food.toMap(),
        where: '$columnId = ?', whereArgs: [food.id!]);
    return food;
  }

  Future<void> deleteFood(int id) async {
    Database db = await instance.database;
    await db.delete(tableFood, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Food>> queryFoodByCriteria(
      FoodType? type, int kcal, String nationality) async {
    print('Query food by criteria');
    Database db = await instance.database;
    List<Food> foods = [];
    String where =
        ' $columnCalories < $kcal AND $columnNationality = "$nationality"';
    if (type != null) {
      where =
          where + ' AND $columnFoodType = "${type.toString().split('.').last}"';
    }
    print(where);
    List<Map> maps = await db.rawQuery('SELECT * FROM $tableFood WHERE $where');
    if (maps.isNotEmpty) {
      maps.forEach((e) {
        FoodType foodType =
            EnumToString.fromString(FoodType.values, e[columnFoodType])!;

        foods.add(new Food.f(
            e[columnId],
            e[columnFoodName],
            foodType, //Enum
            e[columnCalories].toDouble(),
            e[columnNationality],
            e[columnDescription],
            e[columnImg]));
      });
    }
    return foods;
  }
}
