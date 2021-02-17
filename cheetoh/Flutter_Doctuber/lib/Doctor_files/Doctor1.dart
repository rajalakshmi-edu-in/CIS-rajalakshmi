import 'package:flutter/material.dart';
import 'DoctorLogin.dart';
import 'Doctoreg.dart';

class Doctor1 extends StatefulWidget {
  static const String id = 'Doctor1';
  @override
  _Doctor1State createState() => _Doctor1State();
}

class _Doctor1State extends State<Doctor1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15),
            child: Material(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(5.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {});
                  print('Changing to Doctor Registration');
                  Navigator.pushNamed(context, Doctoreg.id);
                },
                child: Text(
                  'Doctor\nRegistration',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Material(
              color: Colors.red[300],
              borderRadius: BorderRadius.circular(5.0),
              child: MaterialButton(
                onPressed: () {
                  setState(() {});
                  print('Changing to Doctor Login');
                  Navigator.pushNamed(context, DoctorLogin.id);
                },
                child: Text(
                  'Doctor Login',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
