import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/features/number_trivia/presentation/provider/trivia_provider.dart';

class TriviaState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              '${GetIt.I.get<TriviaProvider>().currentTrivia.number}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${GetIt.I.get<TriviaProvider>().currentTrivia.text}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
