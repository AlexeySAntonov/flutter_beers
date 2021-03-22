// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beers/business/beers_cubit.dart';
import 'package:flutter_beers/data/repository/beers_repository.dart';
import 'package:flutter_beers/data/provider/beers_api_provider.dart';
import 'package:flutter_beers/ui/home_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beerka',
      theme: ThemeData(primaryColor: Colors.white),
      home: CubitProvider<BeersCubit>(
        create: (context) => BeersCubit(
          repository: BeersRepository(
            apiProvider: BeersApiDataProvider(
              client: Dio(),
            ),
          ),
        ),
        child: HomeWidget(),
      ),
    );
  }
}
