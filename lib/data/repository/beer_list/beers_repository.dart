import 'package:flutter_beers/data/provider/api/ibeers_api_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';
import 'package:flutter_beers/data/repository/beer_list/ibeers_repository.dart';

class BeersRepository extends IBeersRepository {
  final IBeersApiDataProvider _apiProvider;
  final IBeersDbDataProvider _dbProvider;

  BeersRepository({required IBeersApiDataProvider apiProvider, required IBeersDbDataProvider dbProvider})
      : _apiProvider = apiProvider,
        _dbProvider = dbProvider;

  @override
  Stream<List<BeerModel>> beersStream({required int limit, required int offset}) {
    return _dbProvider.beersStream(limit, offset);
  }

  @override
  Future<void> initialData() async {
    return _dbProvider.insertBeers(await _apiProvider.initialData());
  }

  @override
  Future<void> loadMore({required int offset}) async {
    return _dbProvider.insertBeers(await _apiProvider.loadMore(offset: offset));
  }

  @override
  Future<void> setFavorite({required int id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
