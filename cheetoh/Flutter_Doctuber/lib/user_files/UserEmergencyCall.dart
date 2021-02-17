import 'package:doctorapp/user_files/DoctorCardList.dart';
import 'package:flutter/material.dart';
import 'package:doctorapp/services/auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/services/Location.dart' as location;

class UserEmergencyCall extends StatefulWidget {
  static const String id = 'UserEmergencyCall';
  @override
  _UserEmergencyCallState createState() => _UserEmergencyCallState();
}

class _UserEmergencyCallState extends State<UserEmergencyCall> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('user_id');
    final String args = ModalRoute.of(context).settings.arguments;

    Future<void> updateUserYes() async {
      location.Location userLoc = await location.location.getCurrentLocation();
      return users
          .doc(args)
          .update({
            'latitude': userLoc.kLatitude,
            'longitude': userLoc.kLongitude,
            'isInVain': true,
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    Future<void> updateUserNo() async {
      return users
          .doc(args)
          .update({
            'isInVain': false,
          })
          .then((value) => print("User Updated"))
          .catchError((error) => print("Failed to update user: $error"));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency App'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: MaterialButton(
              onPressed: () {
                updateUserNo();
                Navigator.pop(context);
              },
              child: Text(
                'Back to Safety',
                style: TextStyle(
                  color: Colors.white,
                  //backgroundColor: Colors.red,
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                child: Text(
                  'Please Tap the image to get a doctor\'s list',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
                child: Text(
                  'and simultaneously send an alert',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: MaterialButton(
                  onPressed: () async {
                    print('Alert Emergency Triggered');
                    await updateUserYes();
                    setState(() {});
                    Navigator.pushNamed(context, DoctorList.id);
                  },
                  child: Image.asset(
                    'images/Emergency1.png',
                    scale: 5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
