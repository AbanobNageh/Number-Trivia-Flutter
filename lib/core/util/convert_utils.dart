import 'package:dartz/dartz.dart';
import 'package:numbertrivia/core/error/failures.dart';

class ConverterUtils {
  Either<Failure, int> stringToUnsignedInteger(String inputString) {
    if (int.tryParse(inputString) == null) {
      return Left(InvalidInputFailure());
    }

    int parsedNumber = int.parse(inputString);

    if (parsedNumber < 0) {
      return Left(InvalidInputFailure());
    }

    return Right(parsedNumber);
  }
}