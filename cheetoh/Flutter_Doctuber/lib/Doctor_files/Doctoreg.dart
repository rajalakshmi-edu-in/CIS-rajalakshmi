import 'dart:io';
import 'package:doctorapp/Doctor_files/DoctorA.dart';
import 'package:doctorapp/services/Location.dart' as location;
import 'package:flutter/material.dart';
import 'package:doctorapp/services/auth.dart' as auth;
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class Doctoreg extends StatefulWidget {
  static const String id = 'Doctoreg';
  @override
  _DoctoregState createState() => _DoctoregState();
}

class _DoctoregState extends State<Doctoreg> {
  FilePickerResult _paths;
  void _openFileExplorer() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['pdf', 'jpg', 'jpeg'],
      ));
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
  }

  Future<void> uploadFileWithMetadata(File file) async {
    // Create your custom metadata.
    if (file == null) {
      NullThrownError();
    }
    firebase_storage.StorageMetadata metadata =
        firebase_storage.StorageMetadata(
      customMetadata: <String, String>{
        'userId': _kUEmail,
      },
    );

    try {
      // ignore: await_only_futures
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(_kUPhoneNumber)
          .putFile(file, metadata);
    } on firebase_core.FirebaseException catch (e) {
      print(e.toString());
    }
  }

  String get _kUEmail => _uEmailController.text;
  String get _kUPassword => _uPasswordController.text;
  String get _kUPhoneNumber => _uPhoneController.text;
  String get _kUName => _uNameController.text;
  String get _kUAddress => _uAddressController.text;
  bool _uAvailable = false;

  bool _load = false;
  final _firestore = FirebaseFirestore.instance;

  void _submit() async {
    try {
      setState(() {
        _load = true;
      });
      print('Alert Emergency Triggered');
      await auth.auth.createUserWithEmailAndPassword(_kUEmail, _kUPassword);
      location.Location userLoc = await location.location.getCurrentLocation();

      _firestore.collection('doctor_id').doc(_kUPhoneNumber).set({
        'address': _kUAddress,
        'name': _kUName,
        'phoneno': _kUPhoneNumber,
        'email': _kUEmail,
        "isAvailable": _uAvailable,
        "longitude": userLoc.kLongitude,
        "latitude": userLoc.kLatitude,
      });
      if (_paths != null) {
        File filePath = File(_paths.files.first.path);
        uploadFileWithMetadata(filePath);
      }
      print('Doctor Registered');
      setState(() {
        _load = false;
      });
      Navigator.pushNamed(context, DoctorA.id, arguments: _kUPhoneNumber);
    } catch (e) {
      print(e.toString());
    }
  }

  final TextEditingController _uEmailController = TextEditingController();
  final TextEditingController _uPasswordController = TextEditingController();
  final TextEditingController _uPhoneController = TextEditingController();
  final TextEditingController _uNameController = TextEditingController();
  final TextEditingController _uAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor App'),
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
                padding: EdgeInsets.all(20.0),
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
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.emailAddress,
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
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  autofocus: true,
                  cursorColor: Colors.amber,
                  keyboardType: TextInputType.emailAddress,
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
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                child: Material(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(5.0),
                  child: MaterialButton(
                    onPressed: _openFileExplorer,
                    child: Text(
                      'Upload File For Verification',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 60.0),
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
