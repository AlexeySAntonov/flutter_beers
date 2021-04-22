import 'package:flutter_beers/data/provider/api/beers_api_provider.dart';
import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersRepository {
  final BeersApiDataProvider _apiProvider;
  final BeersDbDataProvider _dbProvider;

  BeersRepository({required BeersApiDataProvider apiProvider, required BeersDbDataProvider dbProvider})
      : _apiProvider = apiProvider,
        _dbProvider = dbProvider;

  Stream<List<BeerModel>> beersStream({required int limit, required int offset}) {
    return _dbProvider.beersStream(limit, offset);
  }

  Future<void> initialData() async {
    return _dbProvider.insertBeers(await _apiProvider.initialData());
  }

  Future<void> loadMore({required int offset}) async {
    return _dbProvider.insertBeers(await _apiProvider.loadMore(offset: offset));
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
