import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';

import '../../data/data_reader.dart';

void main() {
  test('should convert JSON to valid recipe model', 
  () async {
    final List<dynamic> jsonData = json.decode(data('recipes.json'));

    final result = RecipeModel.fromJson(jsonData[0] as Map<String, dynamic>);

    expect(result, isA<RecipeModel>());
  });
}