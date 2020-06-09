import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:numbertrivia/core/error/failures.dart';
import 'package:numbertrivia/core/usecases/usecase..dart';
import 'package:numbertrivia/core/util/convert_utils.dart';
import 'package:numbertrivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_number_trivia.dart';
import 'package:numbertrivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:meta/meta.dart';

enum TriviaPageStatus { initial, working, error, loading }

class TriviaProvider extends ChangeNotifier {
  final GetNumberTrivia getNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final ConverterUtils converterUtils;
  NumberTrivia currentTrivia;
  TriviaPageStatus currentPageStatus = TriviaPageStatus.initial;

  TriviaProvider({
    @required this.getNumberTrivia,
    @required this.getRandomNumberTrivia,
    @required this.converterUtils,
  });

  void getTrivia(String number) {
    final Either<Failure, int> inputEither =
        converterUtils.stringToUnsignedInteger(number);

    inputEither.fold(
      (failure) async {
        currentPageStatus = TriviaPageStatus.error;
        notifyListeners();
        return;
      },
      (number) async {
        currentPageStatus = TriviaPageStatus.loading;
        notifyListeners();

        final Either<Failure, NumberTrivia> errorOrTrivia =
            await getNumberTrivia(Params(number: number));

        errorOrTrivia.fold(
          (failure) async {
            currentPageStatus = TriviaPageStatus.error;
            notifyListeners();
            return;
          },
          (trivia) async {
            currentPageStatus = TriviaPageStatus.working;
            currentTrivia = trivia;
            notifyListeners();
            return;
          },
        );
      },
    );
  }

  void getRandomTrivia() async {
    currentPageStatus = TriviaPageStatus.loading;
    notifyListeners();

    final Either<Failure, NumberTrivia> errorOrTrivia =
        await getRandomNumberTrivia(NoParams());

    errorOrTrivia.fold(
      (failure) async {
        currentPageStatus = TriviaPageStatus.error;
        notifyListeners();
        return;
      },
      (trivia) async {
        currentPageStatus = TriviaPageStatus.working;
        currentTrivia = trivia;
        notifyListeners();
        return;
      },
    );
  }
}
