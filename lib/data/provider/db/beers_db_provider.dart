import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersDbDataProvider {
  final BeersDatabase _db;

  BeersDbDataProvider({required BeersDatabase db}) : _db = db;

  Stream<List<BeerModel>> beersStream(int limit, int offset) {
    return _db.watchBeers(limit, offset);
  }

  Stream<List<BeerModel>> favoriteBeersStream() {
    return _db.watchFavoriteBeers();
  }

  Future<void> insertBeers(List<BeerModel> models) {
    return _db.insertBeers(models);
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return _db.setFavorite(id: id, favorite: favorite);
  }
}
