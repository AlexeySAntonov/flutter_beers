import 'package:flutter/material.dart';
import 'package:flutter_beers/home_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beerka',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: HomeWidget(),
    );
  }
}
