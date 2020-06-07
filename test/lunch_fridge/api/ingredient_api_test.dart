
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:tech_task/lunch_fridge/api/ingredient_api.dart';
import 'package:tech_task/lunch_fridge/model/ingredient_model.dart';
import 'package:tech_task/shared/util/constants.dart';

import '../../data/data_reader.dart';

class MockClient extends Mock implements http.Client {}

main() {
  group('getIngredients', () {
    test('returns list of Ingredients if the http call completes successfully', () async {
      final client = MockClient();
      final url = kLunchBaseURL + "/ingredients";

      when(client.get(url))
          .thenAnswer((_) async => http.Response(data('ingredients.json'), 200));

      expect(await IngredientAPI().getIngredients(client), isA<List<IngredientModel>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      final url = kLunchBaseURL + "/ingredients";

      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(IngredientAPI().getIngredients(client), throwsException);
    });
  });
}