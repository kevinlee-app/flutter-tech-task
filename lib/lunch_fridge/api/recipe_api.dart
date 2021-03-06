import 'dart:convert';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';
import 'package:http/http.dart' as http;
import 'package:tech_task/shared/util/constants.dart';

class RecipeAPI {
  Future<List<RecipeModel>> getRecipes(
      String params, http.Client client) async {
    List<RecipeModel> recipes;

    String url = kLunchBaseURL + '/recipes?ingredients=' + params;
    var headers = {'Content-Type': 'application/json'};

    http.Response response;

    try {
      response = await client.get(url, headers: headers);
    } catch (ex) {
      return Future.error('');
    }

    if (response != null) {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body) as List<dynamic>;

        recipes = result.map((item) {
          return RecipeModel.fromJson(item);
        }).toList();

        return recipes;
      } else {
        return Future.error('Something went wrong.');
      }
    } else {
      return List();
    }
  }
}
