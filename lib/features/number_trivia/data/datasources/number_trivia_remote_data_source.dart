import 'dart:convert';

import 'package:numbertrivia/core/error/exception.dart';
import 'package:numbertrivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

const NUMBER_API_BASE_URL = "http://numbersapi.com/";

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTrivia> getNumberTrivia(int number);

  Future<NumberTrivia> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl extends NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({@required this.client});

  @override
  Future<NumberTriviaModel> getNumberTrivia(int number) async {
    final result = await client.get('$NUMBER_API_BASE_URL$number',
        headers: {'Content-Type': 'application/json'});

    if (result.statusCode != 200) {
      throw ServerException();
    }
    
    return Future.value(NumberTriviaModel.fromJson(json.decode(result.body)));
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    final result = await client.get('${NUMBER_API_BASE_URL}random',
        headers: {'Content-Type': 'application/json'});

    if (result.statusCode != 200) {
      throw ServerException();
    }

    return Future.value(NumberTriviaModel.fromJson(json.decode(result.body)));
  }
}
