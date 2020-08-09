import 'package:flutter/material.dart';
import 'package:msa/pages/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Wordy',
        home: Start(),
      ),
    );
  }
}
/*
    MaterialApp(
      title: 'Wordy',
      home: Start(),
    ),
 */