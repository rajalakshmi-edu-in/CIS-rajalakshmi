import 'package:doctorapp/user_files/UserLogin.dart';
import 'package:doctorapp/user_files/UserRegistration.dart';
import 'Doctor_files/Doctor1.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const kMainTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 60.0,
  fontWeight: FontWeight.bold,
);

enum Hamburger { Doctor, User, Emergency }
// ignore: non_constant_identifier_names
Hamburger Page = Hamburger.Emergency;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Doctor Helper',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Doctor',
                          style: kMainTextStyle.copyWith(
                            fontSize: 40,
                          )),
                      Text('Helper',
                          style: kMainTextStyle.copyWith(
                            color: Colors.yellow,
                            fontSize: 40,
                          )),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[300],
                  ),
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.local_hospital),
                    title: Text('Doctor'),
                  ),
                  onTap: () {
                    setState(() {
                      Page = Hamburger.Doctor;
                      Navigator.pop(context);
                    });
                    Navigator.pushNamed(context, Doctor1.id);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.account_box),
                    title: Text('User Register'),
                  ),
                  onTap: () {
                    setState(() {
                      Page = Hamburger.User;
                      Navigator.pop(context);
                    });
                    Navigator.pushNamed(context, UserRegistration.id);
                  },
                ),
//              ListTile(
//                title: Text('Update User info'),
//              ),
                // GestureDetector(
                //   child: ListTile(
                //     leading: Icon(Icons.exit_to_app),
                //     title: Text('Logout'),
                //     onTap: () {
                //       setState(() {
                //         Page = Hamburger.Emergency;
                //         Alert(
                //           context: context,
                //           type: AlertType.warning,
                //           title: "Are You Sure You Want to Log Out?",
                //           style: AlertStyle(
                //             backgroundColor: Colors.white70,
                //             isCloseButton: false,
                //           ),
                //           buttons: [
                //             DialogButton(
                //               child: Text(
                //                 "LOGOUT",
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 20),
                //               ),
                //               onPressed: () => Navigator.pop(context),
                //               color: Colors.red,
                //             ),
                //             DialogButton(
                //               child: Text(
                //                 "CANCEL",
                //                 style: TextStyle(
                //                     color: Colors.white, fontSize: 20),
                //               ),
                //               onPressed: () => Navigator.pop(context),
                //               color: Colors.blue,
                //             ),
                //           ],
                //         ).show();
                //       });
                //     },
                //   ),
                // ),
              ],
            ),
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Material(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(5.0),
                      child: MaterialButton(
                        onPressed: () {
                          setState(() {});
                          print('Alert Emergency Triggerd');
                          Navigator.pushNamed(context, UserLogin.id);
                        },
                        child: Text(
                          'User Login',
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
            ],
          ),
        ),
      ),
    );
  }
}
