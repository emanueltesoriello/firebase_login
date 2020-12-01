import 'package:firebase_login/constants/colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final Color progressIndicatorBackgroundColor;
  final Color progressIndicatorValueColor;

  SplashScreen(
      {this.progressIndicatorBackgroundColor = CustomColors.primaryColor,
      this.progressIndicatorValueColor = const Color(0xFFE3F2FD)});

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
                  backgroundColor: progressIndicatorBackgroundColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      progressIndicatorValueColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
