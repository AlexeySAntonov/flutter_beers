import 'package:flutter/material.dart';
import 'package:flutter_beers/business/cubit_beers.dart';
import 'package:flutter_beers/data/provider/api/ibeers_api_provider.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';
import 'package:flutter_beers/data/repository/beer_list/beers_repository.dart';
import 'package:flutter_beers/ui/beer_list/beer_list_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class BeerListModuleContainer {
  static Widget getScreenComposition(Injector singletonInjector) {
    return CubitProvider<BeersCubit>(
      create: (context) => BeersCubit(
        repository: BeersRepository(
          apiProvider: singletonInjector.get<IBeersApiDataProvider>(),
          dbProvider: singletonInjector.get<IBeersDbDataProvider>(),
        ),
      ),
      child: BeerListWidget(),
    );
  }
}
