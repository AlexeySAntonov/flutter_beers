import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/data/provider/db/ibeers_db_provider.dart';

class BeersDbDataProvider extends IBeersDbDataProvider {
  final BeersDatabase _db;

  BeersDbDataProvider({required BeersDatabase db}) : _db = db;

  @override
  Stream<List<BeerModel>> beersStream(int limit, int offset) {
    return _db.watchBeers(limit, offset);
  }

  @override
  Stream<List<BeerModel>> favoriteBeersStream() {
    return _db.watchFavoriteBeers();
  }

  @override
  Future<void> insertBeers(List<BeerModel> models) {
    return _db.insertBeers(models);
  }

  @override
  Future<void> setFavorite({required int id, required bool favorite}) {
    return _db.setFavorite(id: id, favorite: favorite);
  }
}
