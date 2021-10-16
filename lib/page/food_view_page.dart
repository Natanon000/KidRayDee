import 'dart:io';

import 'package:flutter/material.dart';

import '../model/food.dart';

class FoodView extends StatelessWidget {
  final Food item;
  FoodView(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('KIN RAI DEE')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: item,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: item.img.length != 0
                  ? AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Image.file(File(item.img), fit: BoxFit.cover),
                    )
                  : AspectRatio(
                      aspectRatio: 3 / 2,
                      child:
                          Image.asset('Asset/image/A.jpg', fit: BoxFit.cover),
                    ),
            ),
          ),
          Text(
            item.foodName,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 50,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 10.0,
          ),
          Text(
            item.description,
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 10.0,
          ),
          Text(
            'Nationality: ${item.nationality}',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 10.0,
          ),
          Text(
            'Calories: ${item.calories}',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 10.0,
          ),
          Text(
            'Type: ${item.foodType.toString().split('.').last}',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}
