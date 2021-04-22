import 'package:flutter_beers/data/model/beer_model.dart';

abstract class IBeersDbDataProvider {
  Stream<List<BeerModel>> beersStream(int limit, int offset);

  Stream<List<BeerModel>> favoriteBeersStream();

  Future<void> insertBeers(List<BeerModel> models);

  Future<void> setFavorite({required int id, required bool favorite});
}
