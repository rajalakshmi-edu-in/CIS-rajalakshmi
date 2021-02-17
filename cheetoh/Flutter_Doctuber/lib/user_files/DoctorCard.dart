import 'package:flutter/material.dart';

const doctorCardHeading = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
const doctorCardText = TextStyle(
  fontSize: 18.0,
  color: Colors.white,
);

class DoctorCard extends StatelessWidget {
  DoctorCard(
      {@required this.phonenumber,
      @required this.name,
      @required this.email,
      @required this.address,
      @required this.onTap,
      @required this.color});
  final String phonenumber;
  final String name;
  final String email;
  final String address;
  final Function onTap;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Name: ',
                      style: doctorCardHeading,
                    ),
                    Text('$name', style: doctorCardText),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone No: ',
                      style: doctorCardHeading,
                    ),
                    Text('$phonenumber', style: doctorCardText),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'E-Mail: ',
                      style: doctorCardHeading,
                    ),
                    Text('$email', style: doctorCardText),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Address: ',
                      style: doctorCardHeading,
                    ),
                    Text('$address', style: doctorCardText),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
