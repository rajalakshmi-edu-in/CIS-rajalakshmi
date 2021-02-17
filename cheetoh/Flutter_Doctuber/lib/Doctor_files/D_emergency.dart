import 'package:doctorapp/Doctor_files/DoctorA.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/services/auth.dart';

class DEmergency extends StatefulWidget {
  static const String id = 'D_Emergency';
  @override
  _DEmergencyState createState() => _DEmergencyState();
}

class _DEmergencyState extends State<DEmergency> {
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
                auth.signOut();
                Navigator.pushNamed(context, DoctorA.id);
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'An emergency has occurred in your locality, Would you like to go there?',
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Material(
            color: Colors.red[300],
            borderRadius: BorderRadius.circular(5.0),
            child: MaterialButton(
              onPressed: null,
              child: Text(
                'Yes',
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Material(
            color: Colors.red[300],
            borderRadius: BorderRadius.circular(5.0),
            child: MaterialButton(
              onPressed: null,
              child: Text(
                'No',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
