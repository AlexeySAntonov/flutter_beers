// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter_beers/di/beer_list_module_container.dart';
import 'package:flutter_beers/di/singleton_module_container.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beerka',
      theme: ThemeData(primaryColor: Colors.white),
      home: BeerListModuleContainer.getScreenComposition(SingletonModuleContainer.get()),
    );
  }
}
