import 'package:flutter/material.dart';

class ResetPwdStatusDialog extends StatelessWidget {
  double targetHeight;
  double targetWidth;

  final String title;
  final String description;

  ResetPwdStatusDialog({
    @required this.title,
    @required this.description,
  });

  Widget _appBar() {
    return Container(
      width: targetWidth,
      child: Center(
        child: Text(
          title ?? '_',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: targetHeight / 40,
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: targetWidth / 25,
            right: targetWidth / 25,
          ),
          child: Text(
            description ?? '_',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              height: 1.6,
              fontSize: targetHeight / 60,
            ),
          ),
        ),
        FlatButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Text('Close'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    targetHeight = MediaQuery.of(context).size.height;
    targetWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      content: Theme(
        data: ThemeData(
          brightness: Brightness.light,
        ),
        child: Container(
          height: targetHeight / 2.6,
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(flex: 18, child: _appBar()),
              Expanded(
                flex: 40,
                child: _body(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
