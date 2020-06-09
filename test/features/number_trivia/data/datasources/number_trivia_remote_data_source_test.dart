import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:numbertrivia/core/error/exception.dart';
import 'package:numbertrivia/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:matcher/matcher.dart';
import '../../../../core/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl remoteDataSource;
  MockHttpClient httpClient;

  setUp(() {
    httpClient = MockHttpClient();
    remoteDataSource = NumberTriviaRemoteDataSourceImpl(client: httpClient);
  });

  group('getNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'Should preform a get request with specific number on the number trivia API',
        () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => await http.Response(fixture('trivia.json'), 200));

      remoteDataSource.getNumberTrivia(tNumber);

      verify(httpClient.get('$NUMBER_API_BASE_URL$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return number trivia when the status code is 200', () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => await http.Response(fixture('trivia.json'), 200));

      final result = await remoteDataSource.getNumberTrivia(tNumber);

      expect(result, tNumberTriviaModel);
    });

    test('should throw server exception if status code is not 200', () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => await http.Response('something went wrong', 404));

      expect(() => remoteDataSource.getNumberTrivia(tNumber),
          throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
    NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'Should preform a get request with random number on the number trivia API',
            () async {
          when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
                  (_) async => await http.Response(fixture('trivia.json'), 200));

          remoteDataSource.getRandomNumberTrivia();

          verify(httpClient.get('${NUMBER_API_BASE_URL}random',
              headers: {'Content-Type': 'application/json'}));
        });

    test('should return a random number trivia when the status code is 200', () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => await http.Response(fixture('trivia.json'), 200));

      final result = await remoteDataSource.getRandomNumberTrivia();

      expect(result, tNumberTriviaModel);
    });

    test('should throw server exception if status code is not 200', () async {
      when(httpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
              (_) async => await http.Response('something went wrong', 404));

      expect(() => remoteDataSource.getRandomNumberTrivia(),
          throwsA(TypeMatcher<ServerException>()));
    });
  });
}
