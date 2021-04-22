import 'package:flutter_beers/data/model/beer_model.dart';

abstract class IFavoritesRepository {
  Stream<List<BeerModel>> favoritesBeersStream();

  Future<void> setFavorite({required int id, required bool favorite});
}
