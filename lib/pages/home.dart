import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    //set background
    Random random = new Random();
    int day = random.nextInt(5);
    int night = random.nextInt(5) + 5;

    String bgImage = data['isDaytime'] ? '$day.jpg' : '$night.jpg';
    Color? bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 122, 0, 0),
            child: Column(
              children: <Widget>[
                OutlinedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location_outlined,
                    color: Colors.brown[800],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.brown[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 22.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data['location'],
                      style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 2.3,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 22),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 62.0,
                    color: Colors.amber[200],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
