import 'package:flutter/material.dart';
import 'package:tech_task/lunch_fridge/view/ingredient/ingredients_view.dart';
import 'package:tech_task/shared/util/constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  /* START METHODS */

  Future<Null> _showCalendar(BuildContext context) async {
    final DateTime dt = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (dt != null) {
      setState(() => _selectedDate = dt);
      _goToIngredientsView();
    }
  }

  void _goToIngredientsView() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IngredientsView(this._selectedDate),
        ));
  }

  /* END METHODS */

  /* START WIDGETS */

  Widget _appBarWidget() {
    return AppBar(
      title: Text(
        'Lunch Recipes',
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.fastfood,
            color: kThemeColor.withAlpha(180),
            size: 300.0,
          ),
          SizedBox(height: 60.0),
          Text(
            'Hi, Welcome!\nDo you want to prepare your lunch?',
            style: textStyle_Normal,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: kThemeColor,
            onPressed: () => _showCalendar(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Container(
              height: 50,
              width: 260,
              alignment: Alignment.center,
              child: Text(
                'Yes, i want to prepare it on ...',
                style: textStyle_Title,
              ),
            ),
          ),
          SizedBox(height: 50.0),
        ],
      ),
    );
  }

  /* END WIDGETS */

}
