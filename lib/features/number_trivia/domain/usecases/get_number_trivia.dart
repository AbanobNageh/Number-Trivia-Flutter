import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecases/usecase..dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:meta/meta.dart';

class GetNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({this.number});

  @override
  List<Object> get props => [number];
}