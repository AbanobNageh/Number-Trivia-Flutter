import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:numbertrivia/features/number_trivia/presentation/provider/trivia_provider.dart';

class TriviaControls extends StatefulWidget {
  @override
  _TriviaControlsState createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  final TextEditingController textController = TextEditingController();
  String input;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (newValue) {
                input = newValue;
              },
              controller: textController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'enter a number',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 5, top: 5, bottom: 5),
                    child: FlatButton(
                      onPressed: () async {
                        if (input == null || input.isEmpty) {
                          return;
                        }

                        GetIt.I.get<TriviaProvider>().getTrivia(input);
                        input = "";
                        textController.clear();
                        FocusScope.of(context).unfocus();
                      },
                      color: Colors.green,
                      child: Text('Search'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5, right: 0, top: 5, bottom: 5),
                    child: FlatButton(
                      color: Colors.grey.shade200,
                      onPressed: () async {
                        input = "";
                        textController.clear();
                        FocusScope.of(context).unfocus();
                        GetIt.I.get<TriviaProvider>().getRandomTrivia();
                      },
                      child: Text('Get random trivia'),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
