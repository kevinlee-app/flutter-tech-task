import 'package:flutter/material.dart';
import 'package:tech_task/lunch_fridge/model/ingredient_model.dart';
import 'package:tech_task/shared/util/constants.dart';

class IngredientsListView extends StatelessWidget {
  final List<IngredientModel> ingredients;
  final Function onPressed;

  IngredientsListView({this.ingredients, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wrap(
        spacing: 12.0,
        children: ingredients.map((ingredient) {
          return ActionChip(
            backgroundColor: ingredient.isExpired
                ? Colors.grey
                : ingredient.isSelected ? kThemeColor : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
                side: BorderSide(color: ingredient.isExpired ? Colors.grey : ingredient.isSelected ? kThemeColor : Colors.black87)),
            label: Text(ingredient.title,
                style: textStyle_Normal.copyWith(
                    color:
                        ingredient.isExpired ? Colors.white : ingredient.isSelected ? Colors.white : Colors.black87)),
            onPressed: () => onPressed(ingredient),
          );
        }).toList(),
      ),
    );
  }
}
