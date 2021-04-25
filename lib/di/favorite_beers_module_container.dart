import 'package:flutter/material.dart';
import 'package:flutter_beers/business/cubit_favorites.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';
import 'package:flutter_beers/data/repository/favorites/favorites_repository.dart';
import 'package:flutter_beers/ui/favorites/favorite_beers_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class FavoriteBeersModuleContainer {
  static Widget getScreenComposition(Injector singletonInjector) {
    return CubitProvider<FavoritesCubit>(
      create: (context) => FavoritesCubit(
        repository: FavoritesRepository(
          dbProvider: singletonInjector.get<IBeersDbDataProvider>(),
        ),
      ),
      child: FavoriteBeersWidget(),
    );
  }
}
