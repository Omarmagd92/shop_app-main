import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              child:
                  Image(image: AssetImage('assests/images/shopapplogo.png'))),
          SizedBox(
            height: 10,
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: 'SHOP',
                style: TextStyle(
                    color: Colors.purple.shade200,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            TextSpan(
                text: 'App',
                style: TextStyle(
                    color: Colors.purple.shade200,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ])),
          Text(
            'EXPECT THE UNEXPECTED',
            style: TextStyle(fontSize: 10),
          ),
        ],
      )),
    );
  }
}
