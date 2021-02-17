import 'package:flutter/material.dart';

class ULocation extends StatefulWidget {
  static const String id = 'U_Location';
  @override
  _ULocationState createState() => _ULocationState();
}

class _ULocationState extends State<ULocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor App'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Location has been sent and a Doctor will soon cater to you',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
