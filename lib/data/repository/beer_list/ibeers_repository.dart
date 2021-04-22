import 'package:flutter_beers/data/model/beer_model.dart';

abstract class IBeersRepository {
  Stream<List<BeerModel>> beersStream({required int limit, required int offset});

  Future<void> initialData();

  Future<void> loadMore({required int offset});

  Future<void> setFavorite({required int id, required bool favorite});
}
