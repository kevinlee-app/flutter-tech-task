import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tech_task/lunch_fridge/api/ingredient_api.dart';
import 'package:tech_task/lunch_fridge/model/ingredient_model.dart';
import 'package:tech_task/lunch_fridge/view/ingredient/ingredients_list_view.dart';
import 'package:tech_task/lunch_fridge/view/recipe/recipe_view.dart';
import 'package:tech_task/shared/util/constants.dart';
import 'package:tech_task/shared/widget/loading_widget.dart';

class IngredientsView extends StatefulWidget {
  final DateTime selectedDate;

  IngredientsView(this.selectedDate);

  @override
  _IngredientsViewState createState() => _IngredientsViewState();
}

class _IngredientsViewState extends State<IngredientsView> {
  List<IngredientModel> ingredients = List();
  BuildContext _snackBarContext;

  Future<List<IngredientModel>> futureIngredients;

  @override
  void initState() {
    super.initState();

    futureIngredients = IngredientAPI().getIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _futureWidget(),
    );
  }

  /* START METHODS */

  void _toggleSelectedIng(IngredientModel ingredient) {
    setState(() {
      ingredient.isSelected = !ingredient.isSelected;
    });
  }

  void _goToRecipeView(List<IngredientModel> selectedIngredients) {
    if (selectedIngredients.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RecipeView(selectedIngredients: selectedIngredients),
          ));
    } else {
      var snackBar = SnackBar(
        content: Text('Please select ingredient'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      );
      
      Scaffold.of(_snackBarContext).showSnackBar(snackBar);
    }
  }

  /* END METHODS */

  /* START WIDGETS */

  Widget _appBarWidget() {
    return AppBar(
      title: Text(
        'Ingredients',
      ),
      centerTitle: true,
    );
  }

  Widget _futureWidget() {
    return ingredients.length == 0
        ? FutureBuilder<List<IngredientModel>>(
            initialData: List(),
            future: futureIngredients,
            builder: (BuildContext context,
                AsyncSnapshot<List<IngredientModel>> snapshot) {
                  this._snackBarContext = context;

              if (snapshot.hasData) {
                ingredients = snapshot.data;
                ingredients.sort((a, b) =>
                    DateTime.parse(b.useBy).compareTo(DateTime.parse(a.useBy)));

                for (int i = 0; i < ingredients.length; i++) {
                  ingredients[i].isExpired =
                      DateTime.parse(ingredients[i].useBy)
                          .isBefore(widget.selectedDate);
                }
                return _bodyWidget();
              } else if (snapshot.error) {
                return LoadingWidget(text: '');
              } else {
                return LoadingWidget(text: '');
              }
            },
          )
        : _bodyWidget();
  }

  Widget _bodyWidget() {
    List<IngredientModel> selectedIngredients =
        ingredients.where((ingredient) => ingredient.isSelected).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _lunchDateWidget(),
            SizedBox(height: 20),
            Text('Please select your available ingredients : ',
                style: textStyle_Normal),
            SizedBox(height: 20),
            IngredientsListView(
              ingredients: ingredients,
              onPressed: (ingredient) {
                _toggleSelectedIng(ingredient);
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: kThemeColor,
              onPressed: () => _goToRecipeView(selectedIngredients),
              child: Text(
                'Get Recipes',
                style: textStyle_Title,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lunchDateWidget() {
    return RichText(
      text: TextSpan(
        text: 'Lunch on: ',
        style: textStyle_Title.copyWith(color: Colors.black87),
        children: <TextSpan>[
          TextSpan(
            text:
                '${DateFormat('EEEE, MMM d, yyyy').format(widget.selectedDate)}',
            style: textStyle_Normal.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  /* END WIDGETS */
}
