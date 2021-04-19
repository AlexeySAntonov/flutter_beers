import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersDbDataProvider {
  BeersDbDataProvider({required this.db});

  final BeersDatabase db;

  Stream<List<BeerModel>> beersStream(int limit, int offset) {
    return db.watchBeers(limit, offset);
  }

  Stream<List<BeerModel>> favoriteBeersStream() {
    return db.watchFavoriteBeers();
  }

  Future<void> insertBeers(List<BeerModel> models) {
    return db.insertBeers(models);
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return db.setFavorite(id: id, favorite: favorite);
  }

}
