import 'package:flutter/material.dart';
import 'homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'alpine weather',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.lightBlue,
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        primaryIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.dark,
        primaryIconTheme: IconThemeData(
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black87,
        splashColor: Colors.black87,
      ),
      home: HomePage(),
    );
  }
}