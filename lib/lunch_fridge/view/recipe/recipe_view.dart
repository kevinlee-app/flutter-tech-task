import 'package:flutter/material.dart';
import 'package:tech_task/lunch_fridge/api/recipe_api.dart';
import 'package:tech_task/lunch_fridge/model/ingredient_model.dart';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';
import 'package:tech_task/lunch_fridge/view/recipe/recipe_list_view.dart';
import 'package:tech_task/shared/widget/connection_widget.dart';
import 'package:tech_task/shared/widget/empty_data_widget.dart';
import 'package:tech_task/shared/widget/loading_widget.dart';
import 'package:http/http.dart' as http;

class RecipeView extends StatefulWidget {
  final List<IngredientModel> selectedIngredients;

  RecipeView({this.selectedIngredients});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  Future<List<RecipeModel>> futureRecipes;

  @override
  void initState() {
    super.initState();

    futureRecipes = _getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarWidget(),
      body: _bodyWidget(),
    );
  }

  /* START METHODS */

  Future<List<RecipeModel>> _getRecipes() {
    String params = "";
    for (int i = 0; i < widget.selectedIngredients.length; i++) {
      params += widget.selectedIngredients[i].title + ",";
    }
    params = params.substring(0, params.lastIndexOf(','));

    return RecipeAPI().getRecipes(params, http.Client());
  }

  /* END METHODS */

  /* START WIDGETS */

  Widget _appBarWidget() {
    return AppBar(
      title: Text(
        'Recipes',
      ),
      centerTitle: true,
    );
  }

  Widget _bodyWidget() {
    return FutureBuilder<List<RecipeModel>>(
      future: futureRecipes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RecipeModel> recipes = List();
          for (var ingredient in widget.selectedIngredients) {
            for (var recipe in snapshot.data) {
              if (recipe.ingredients.contains(ingredient.title) &&
                  !recipes.contains(recipe)) {
                recipes.add(recipe);
              }
            }
          }

          return recipes.length > 0
              ? RecipesListView(
                  selectedIngredients: widget.selectedIngredients,
                  recipes: recipes,
                )
              : EmptyDataWidget(
                  text: 'No Recipe found',
                );
        } else if (snapshot.hasError) {
          return ConnectionWidget(onPressed: () {
            setState(() {
              futureRecipes = _getRecipes();
            });
          });
        } else {
          return LoadingWidget(text: '');
        }
      },
    );
  }
  /* END WIDGETS */
}
