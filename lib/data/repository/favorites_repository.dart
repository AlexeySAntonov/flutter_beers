import 'package:flutter_beers/data/provider/db/beers_db_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class FavoritesRepository {
  final BeersDbDataProvider dbProvider;

  FavoritesRepository({required this.dbProvider});

  Stream<List<BeerModel>> favoritesBeersStream() {
    return dbProvider.favoriteBeersStream();
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return dbProvider.setFavorite(id: id, favorite: favorite);
  }
}
