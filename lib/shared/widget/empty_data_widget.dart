import 'package:flutter/material.dart';
import 'package:tech_task/shared/util/constants.dart';

class EmptyDataWidget extends StatelessWidget {
  final String text;
  EmptyDataWidget({this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      text,
      style: textStyle_Normal.copyWith(
        color: Colors.grey,
      ),
    ));
  }
}
