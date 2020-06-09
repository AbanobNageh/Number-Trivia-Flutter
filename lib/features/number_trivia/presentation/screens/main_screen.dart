import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numbertrivia/features/number_trivia/presentation/provider/trivia_provider.dart';
import 'package:numbertrivia/features/number_trivia/presentation/widgets/error_state.dart';
import 'package:numbertrivia/features/number_trivia/presentation/widgets/initiali_state.dart';
import 'package:numbertrivia/features/number_trivia/presentation/widgets/loading_state.dart';
import 'package:numbertrivia/features/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:numbertrivia/features/number_trivia/presentation/widgets/trivia_state.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Selector<TriviaProvider, TriviaPageStatus>(
              builder: (context, data, child) {
                if (data == TriviaPageStatus.initial) {
                  return InitialState();
                } else if (data == TriviaPageStatus.working) {
                  return TriviaState();
                } else if (data == TriviaPageStatus.loading) {
                  return LoadingState();
                } else {
                  return ErrorState();
                }
              },
              selector: (context, triviaProvider) {
                return triviaProvider.currentPageStatus;
              },
            ),
            TriviaControls(),
          ],
        ),
      ),
    );
  }
}
