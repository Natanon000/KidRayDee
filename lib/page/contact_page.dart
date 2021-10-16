import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Contact')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('Asset/image/GangMassaman.jpg'),
            radius: 100,
          ),
          //Image(image: AssetImage('Asset/image/GangMassaman.jpg')),
          Text(
            'Natchanon  Trakonpisit',
            style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          Text(
            'Prince of Songkla University',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
          Container(
            color: Colors.orange,
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 80.0,
            ),
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.email_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'jetnatchanon@gmail.com',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.orange,
            margin: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 80.0,
            ),
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  Icons.email_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'jetnatchanon',
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
