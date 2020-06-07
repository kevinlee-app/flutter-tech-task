import 'dart:convert';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:tech_task/shared/util/constants.dart';

class RecipeAPI {
  Future<List<RecipeModel>> getRecipes(String params) async {
    var client = http.Client();
    List<RecipeModel> recipes;

    String url = kLunchBaseURL + '/recipes?ingredients=' + params;
    var headers = {'Content-Type': 'application/json'};

    final response = await client.get(url, headers: headers);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List<dynamic>;

      recipes = result.map((item) {
        return RecipeModel.fromJson(item);
      }).toList();

      return recipes;
    } else {
      return Future.error('Something went wrong.');
    }
  }
}
