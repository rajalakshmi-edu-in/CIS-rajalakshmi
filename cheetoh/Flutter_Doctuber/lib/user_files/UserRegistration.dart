import 'package:doctorapp/user_files/UserLogin.dart';
import 'package:doctorapp/services/Location.dart' as location;
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/services/auth.dart';

class UserRegistration extends StatefulWidget {
  static const String id = 'UserRegistration';
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String get _kUEmail => _uEmailController.text;
  String get _kUPassword => _uPasswordController.text;
  String get _kUPhoneNumber => _uPhoneController.text;
  String get _kUEmergencyContact => _uEmergencyController.text;
  String get _kUAddress => _uAddressController.text;
  String get _kUName => _uNameController.text;
  bool _load = false;
  bool _uVain = false;
  final _firestore = FirebaseFirestore.instance;

  void _submit() async {
    try {
      setState(() {
        _load = true;
      });
      print('Alert Emergency Triggered');
      await auth.createUserWithEmailAndPassword(_kUEmail, _kUPassword);
      location.Location userLoc = await location.location.getCurrentLocation();
      _firestore.collection('user_id').doc(_kUPhoneNumber).set({
        'address': _kUAddress,
        'emergencycontact': _kUEmergencyContact,
        'phoneno': _kUPhoneNumber,
        'email': _kUEmail,
        'name': _kUName,
        'latitude': userLoc.kLatitude,
        'longitude': userLoc.kLongitude,
        'isInVain': _uVain,
      });
      print('User Registered');
      Navigator.pushNamed(context, UserLogin.id);
      setState(() {
        _load = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  final TextEditingController _uEmailController = TextEditingController();
  final TextEditingController _uPasswordController = TextEditingController();
  final TextEditingController _uPhoneController = TextEditingController();
  final TextEditingController _uEmergencyController = TextEditingController();
  final TextEditingController _uAddressController = TextEditingController();
  final TextEditingController _uNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User App'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _load,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _uEmailController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: _uPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  controller: _uNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.center,
                  controller: _uPhoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  controller: _uEmergencyController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Emergency Contact',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.streetAddress,
                  textAlign: TextAlign.center,
                  controller: _uAddressController,
                  decoration: InputDecoration(
                    hintText: 'Enter your Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(
                        color: Colors.amber,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 60),
                child: Material(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(5.0),
                  child: MaterialButton(
                    onPressed: _submit,
                    child: Text(
                      'Register',
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
        ),
      ),
    );
  }
}
