import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kindraidee/model/food.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../db_helper.dart';

class FoodDetailPage extends StatefulWidget {
  final Food? updateFood;
  FoodDetailPage([this.updateFood]);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState(updateFood);
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  Food? updateFood;
  _FoodDetailPageState(this.updateFood);

  final _formkey = GlobalKey<FormState>();
  final _foodNameController = TextEditingController();
  final _foodDescriptionController = TextEditingController();
  final _foodCalController = TextEditingController();
  FoodType _selectedFoodType = FoodType.meal;
  String _selectedNationality = 'Thai';
  String _selectedImage = '';

  void initState() {
    if (updateFood != null) {
      _foodNameController.text = updateFood!.foodName;
      _foodDescriptionController.text = updateFood!.description;
      _selectedFoodType = updateFood!.foodType;
      _foodCalController.text = updateFood!.calories.toString();
      _selectedNationality = updateFood!.nationality;
      _selectedImage = updateFood!.img;
    }
    super.initState();
  }

  Future<void> onPickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File tmpFile = File(image.path);
      // Get the path to the apps directory so we can save the file to it.
      Directory appDocDir = await getApplicationDocumentsDirectory();
      final String path = appDocDir.path;
      final String fileName = basename(image.path); // Filename
      // Save the file by copying it to the new location on the device.
      tmpFile = await tmpFile.copy('$path/$fileName');

      setState(() {
        _selectedImage = tmpFile.path;
      });
    }
  }

  submitFoodData(BuildContext context) async {
    if (updateFood != null) {
      // update food
      Food food = new Food.f(
          updateFood!.id,
          _foodNameController.text,
          _selectedFoodType,
          double.parse(_foodCalController.text),
          _selectedNationality,
          _foodDescriptionController.text,
          _selectedImage);

      await DatabaseHelper.instance.update(food);
    } else {
      // insert new food
      Food food = new Food(
          _foodNameController.text,
          _selectedFoodType,
          double.parse(_foodCalController.text),
          _selectedNationality,
          _foodDescriptionController.text,
          _selectedImage);

      await DatabaseHelper.instance.insert(food);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (widget.updateFood == null)
            ? Text('Add Your New Favorite Food')
            : Text('Edit Food'),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Name'),
                controller: _foodNameController,
                validator: (val) {
                  if (val == null || val.length == 0) {
                    return 'Please add food name';
                  }
                  return null;
                },
                onFieldSubmitted: (value) =>
                    {if (_formkey.currentState!.validate()) {}},
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Description'),
                controller: _foodDescriptionController,
                validator: (val) {
                  if (val == null || val.length == 0) {
                    return 'Please add food name';
                  }
                  return null;
                },
                onFieldSubmitted: (value) =>
                    {if (_formkey.currentState!.validate()) {}},
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 10.0, left: 10.0),
                child: Text(
                  'Select Food Type',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text('Meal'),
                        leading: Radio<FoodType>(
                          value: FoodType.meal,
                          groupValue: _selectedFoodType,
                          onChanged: (FoodType? value) {
                            setState(() {
                              _selectedFoodType = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Dessert'),
                        leading: Radio<FoodType>(
                          value: FoodType.dessert,
                          groupValue: _selectedFoodType,
                          onChanged: (FoodType? value) {
                            setState(() {
                              _selectedFoodType = value ?? FoodType.dessert;
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100.0,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                  decoration: InputDecoration(labelText: 'Food Calories'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: _foodCalController,
                  validator: (val) {
                    if (val == null || val.length == 0) {
                      return 'Please add food calories number';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) =>
                      {if (_formkey.currentState!.validate()) {}},
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                    child: Text(
                      'Select Food Nationality    ',
                      style: TextStyle(
                        fontSize: 18.0,
                        //color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: _selectedNationality,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                    underline: Container(
                      height: 2,
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (String? newValue) {
                      print(newValue);
                      setState(() {
                        _selectedNationality = newValue!;
                      });
                    },
                    // Thai - th, Japanese - jp, Chinese - cn, Western - us
                    items: <String>['Thai', 'Japanese', 'Chinese', 'Western']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Picture",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: _selectedImage.length != 0
                            ? CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    FileImage(File(_selectedImage)),
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage:
                                    AssetImage('Asset/image/A.jpg'),
                              ),
                        onTap: () {
                          onPickImage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    print('Submit');
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formkey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                      submitFoodData(context);
                    }
                  },
                  child:
                      (widget.updateFood == null) ? Text('Save') : Text('Edit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
