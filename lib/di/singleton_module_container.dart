import 'package:dio/dio.dart';
import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/provider/api/beers_api_provider.dart';
import 'package:flutter_beers/data/provider/api/ibeers_api_provider.dart';
import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class SingletonModuleContainer {
  static Injector? _instance;

  static Injector get() {
    if (_instance == null) {
      _instance = Injector()
        ..map((injector) => Dio(), isSingleton: true)
        ..map<IBeersApiDataProvider>((injector) => BeersApiDataProvider(client: injector.get<Dio>()), isSingleton: true)
        ..map((injector) => BeersDatabase(), isSingleton: true)
        ..map<IBeersDbDataProvider>((injector) => BeersDbDataProvider(db: injector.get<BeersDatabase>()), isSingleton: true);
    }
    return _instance!;
  }
}
