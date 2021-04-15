import 'package:flutter_beers/data/provider/api/beers_api_provider.dart';
import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersRepository {
  final BeersApiDataProvider apiProvider;
  final BeersDbDataProvider dbProvider;

  BeersRepository({required this.apiProvider, required this.dbProvider});

  Stream<List<BeerModel>> beersStream({required int limit, required int offset}) {
    return dbProvider.beersStream(limit, offset);
  }

  Future<void> initialData() async {
    return dbProvider.insertBeers(await apiProvider.initialData());
  }

  Future<void> loadMore({required int offset}) async {
    return dbProvider.insertBeers(await apiProvider.loadMore(offset: offset));
  }
}
