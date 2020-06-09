import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/util/convert_utils.dart';

void main() {
  ConverterUtils converterUtils;

  setUp(() {
    converterUtils = ConverterUtils();
  });

  group('stringToUnsignedInt', () {
    test('should return an integer when the input string represents an unsigned integer', () async {
      final String tString = "123";
      final result = converterUtils.stringToUnsignedInteger(tString);
      expect(result, Right(123));
    });

    test('should return failure when the string is not an integer', () async {
      final String tString = "abc";
      final result = converterUtils.stringToUnsignedInteger(tString);
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return failure when the string is a negative integer', () async {
      final String tString = "-123";
      final result = converterUtils.stringToUnsignedInteger(tString);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}