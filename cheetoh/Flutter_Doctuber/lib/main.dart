import 'package:doctorapp/Doctor_files/DoctorA.dart';
import 'package:doctorapp/user_files/DoctorCardList.dart';
import 'Doctor_files/DoctorA.dart';
import 'Doctor_files/D_Location.dart';
import 'Doctor_files/D_emergency.dart';
import 'Doctor_files/DoctorLogin.dart';
import 'user_files/U_Location.dart';
import 'user_files/UserLogin.dart';
import 'package:flutter/material.dart';
import 'WelcomeScreen.dart';
import 'Doctor_files/Doctoreg.dart';
import 'user_files/UserRegistration.dart';
import 'Doctor_files/Doctor1.dart';
import 'user_files/UserEmergencyCall.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.red,
        appBarTheme: AppBarTheme(color: Colors.red[300]),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        UserLogin.id: (context) => UserLogin(),
        UserRegistration.id: (context) => UserRegistration(),
        UserEmergencyCall.id: (context) => UserEmergencyCall(),
        ULocation.id: (context) => ULocation(),
        Doctor1.id: (context) => Doctor1(),
        Doctoreg.id: (context) => Doctoreg(),
        DoctorLogin.id: (context) => DoctorLogin(),
        DLocation.id: (context) => DLocation(),
        DEmergency.id: (context) => DEmergency(),
        DoctorA.id: (context) => DoctorA(),
        DoctorList.id: (context) => DoctorList(),
      },
    );
  }
}
