import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';
import 'package:flutter_beers/data/repository/favorites/ifavorites_repository.dart';

class FavoritesRepository extends IFavoritesRepository {
  final IBeersDbDataProvider _dbProvider;

  FavoritesRepository({required IBeersDbDataProvider dbProvider}) : _dbProvider = dbProvider;

  @override
  Stream<List<BeerModel>> favoritesBeersStream() {
    return _dbProvider.favoriteBeersStream();
  }

  @override
  Future<void> setFavorite({required int id, required bool favorite}) {
    return _dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
