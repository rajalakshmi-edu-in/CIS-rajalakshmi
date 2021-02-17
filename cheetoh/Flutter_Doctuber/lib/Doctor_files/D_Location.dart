import 'package:flutter/material.dart';
import 'package:doctorapp/services/auth.dart' as auth;

class DLocation extends StatefulWidget {
  static const String id = 'D_Location';
  @override
  _DLocationState createState() => _DLocationState();
}

class _DLocationState extends State<DLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor App'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: MaterialButton(
              onPressed: () {
                auth.auth.signOut();
                Navigator.pop(context);
              },
              child: Text(
                'Log Out',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your Location has been shared and if an urgency pops up, we will contact you',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
