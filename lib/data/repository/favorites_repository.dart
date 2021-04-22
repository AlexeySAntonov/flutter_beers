import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class FavoritesRepository {
  final BeersDbDataProvider _dbProvider;

  FavoritesRepository({required BeersDbDataProvider dbProvider}) : _dbProvider = dbProvider;

  Stream<List<BeerModel>> favoritesBeersStream() {
    return _dbProvider.favoriteBeersStream();
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
