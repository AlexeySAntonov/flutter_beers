import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersDbDataProvider {
  BeersDbDataProvider({required this.db});

  final BeersDatabase db;

  Stream<List<BeerModel>> beersStream(int limit, int offset) {
    return db.watchBeers(limit, offset);
  }

  Future<void> insertBeers(List<BeerModel> models) {
    return db.insertBeers(models);
  }

}
