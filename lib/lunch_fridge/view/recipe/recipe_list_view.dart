import 'package:flutter/material.dart';
import 'package:tech_task/lunch_fridge/model/ingredient_model.dart';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';
import 'package:tech_task/shared/util/constants.dart';

class RecipesListView extends StatelessWidget {
  final List<IngredientModel> selectedIngredients;
  final List<RecipeModel> recipes;
  RecipesListView({this.selectedIngredients, this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(12.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  recipes[index].title,
                  style: textStyle_Title.copyWith(color: Colors.black87),
                ),
                SizedBox(height: 10.0),
                Wrap(
                  spacing: 12.0,
                  children: recipes[index].ingredients.map((ingTitle) {
                    final bool isSelection = selectedIngredients
                        .where((ingredient) => ingredient.title == ingTitle)
                        .toList()
                        .isNotEmpty;
                    return ActionChip(
                      backgroundColor: isSelection ? kThemeColor : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(
                              color: isSelection ? kThemeColor : Colors.black87)),
                      label: Text(ingTitle,
                          style:
                              textStyle_Normal.copyWith(color: isSelection ? Colors.white : Colors.black87)),
                      onPressed: () => {},
                    );
                  }).toList(),
                )
              ]),
        );
      },
    );
  }
}
