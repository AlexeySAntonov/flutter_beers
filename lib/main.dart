// @dart=2.9
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beers/business/cubit_beers.dart';
import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/repository/beer_list/beers_repository.dart';
import 'package:flutter_beers/data/provider/api/beers_api_provider.dart';
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
            dbProvider: BeersDbDataProvider(
              db: BeersDatabase(),
            ),
          ),
        ),
        child: HomeWidget(),
      ),
    );
  }
}
