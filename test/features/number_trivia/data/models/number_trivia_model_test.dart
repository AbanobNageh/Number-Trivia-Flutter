import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../core/fixtures/fixture_reader.dart';

void main() {
  final tNumberTriviaModel = NumberTriviaModel(text: 'Text Test', number: 1);

  test('should be a subclass of number trivia entity', () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group('from json', () {
    test('should return a valid model when the json number is an integer', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });

    test('should return a valid model when the json number is a double', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia_double.json'));

      final result = NumberTriviaModel.fromJson(jsonMap);

      expect(result, tNumberTriviaModel);
    });
  });
  
  group('to json', () {
    test('should return a json map containg the proper data', () async {
      final result = tNumberTriviaModel.toJson();

      final expectedMap ={
        "text": "Text Test",
        "number": 1
      };

      expect(result, expectedMap);
    });
  });
}
