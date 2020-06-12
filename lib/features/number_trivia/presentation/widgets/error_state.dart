import 'package:flutter/material.dart';
import 'package:numbertrivia/core/localization/app_localization.dart';

class ErrorState extends StatelessWidget {
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
        child: Center(
          child: Text(
            AppLocalization.of(context).triviaError,
            style: TextStyle(
              fontSize: 22,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
