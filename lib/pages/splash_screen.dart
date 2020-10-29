import 'package:firebase_login/constants/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: CustomColors.primaryColor,
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blue[50],
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
