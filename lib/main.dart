import 'package:flutter/material.dart';
import 'package:tech_task/lunch_fridge/view/home/home_view.dart';
import 'package:tech_task/shared/util/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: kThemeColor,
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: kThemeColor,
        appBarTheme: AppBarTheme(
          color: kThemeColor,
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: TextTheme(headline6: textStyle_Title),
        ),
      ),
      home: HomeView(),
    );
  }
}
