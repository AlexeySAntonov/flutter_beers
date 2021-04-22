import 'package:flutter_beers/data/model/beer_model.dart';

abstract class IBeersApiDataProvider {
  Future<List<BeerModel>> initialData();

  Future<List<BeerModel>> loadMore({required int offset});
}
