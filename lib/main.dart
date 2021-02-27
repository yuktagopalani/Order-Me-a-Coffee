import 'package:flutter/material.dart';
import 'package:order_me_a_coffee/screens/home/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Wrapper(),
    );
  }
}

