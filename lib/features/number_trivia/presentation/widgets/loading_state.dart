import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Container(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
