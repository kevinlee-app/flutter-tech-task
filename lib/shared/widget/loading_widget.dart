import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String text;
  LoadingWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(backgroundColor: Colors.white),
            SizedBox(height: 20),
            Text(
              text,
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
