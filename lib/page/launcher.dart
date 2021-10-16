import 'package:flutter/material.dart';
import 'package:kindraidee/page/contact_page.dart';
import 'package:kindraidee/page/foodlist_page.dart';
import 'package:kindraidee/page/input_page.dart';

class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  int _selectedIndex = 0;

  List<Widget> _pageWidget = <Widget>[
    InputPage(),
    FoodListPage(),
    ContactPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cantact',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
