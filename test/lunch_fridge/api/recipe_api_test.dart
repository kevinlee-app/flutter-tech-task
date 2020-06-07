import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tech_task/lunch_fridge/api/recipe_api.dart';
import 'package:tech_task/lunch_fridge/model/recipe_model.dart';
import 'package:tech_task/shared/util/constants.dart';

import '../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('getRecipes', () {
    final params = "Ham,Butter";
    final url = kLunchBaseURL + '/recipes?ingredients=' + params;
    test('returns list of Recipes if the http call completes successfully',
        () async {
      final client = MockClient();

      when(client.get(url))
          .thenAnswer((_) async => http.Response(data('recipes.json'), 200));

      expect(await RecipeAPI().getRecipes(params, client),
          isA<List<RecipeModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(RecipeAPI().getRecipes(params, client), throwsException);
    });
  });
}
