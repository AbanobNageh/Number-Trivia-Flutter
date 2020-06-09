import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/exception.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  MockSharedPreferences sharedPreferences;
  NumberTriviaLocalDataSourceImpl localDataSource;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localDataSource =
        NumberTriviaLocalDataSourceImpl(sharedPreferences: sharedPreferences);
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));

    test('should return number trivia from shared preferences when it exists',
        () async {
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));

      final result = await localDataSource.getLastNumberTrivia();

      verify(sharedPreferences.getString(CACHED_TRIVIA_KEY));
      expect(result, tNumberTriviaModel);
    });

    test('should throw cache exception from when data is not cached', () async {
      when(sharedPreferences.getString(any)).thenReturn(null);

      expect(() => localDataSource.getLastNumberTrivia(),
          throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: 1);

    test('should call sharedPreferences to cache the data', () async {
      localDataSource.cacheNumberTrivia(tNumberTriviaModel);

      final expectedJsonString = json.encode(tNumberTriviaModel.toJson());

      verify(
          sharedPreferences.setString(CACHED_TRIVIA_KEY, expectedJsonString));
    });
  });
}
