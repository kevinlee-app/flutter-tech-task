import 'package:flutter/material.dart';
import 'package:tech_task/shared/util/constants.dart';

class ConnectionWidget extends StatelessWidget {
  final Function onPressed;
  ConnectionWidget({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Something went wrong.\nPlease check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black87),
            ),
            SizedBox(height: 20),
            RaisedButton(
              color: kThemeColor,
              onPressed: onPressed,
              child: Text(
                'Try Again',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
