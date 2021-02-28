import 'package:flutter_beers/data/model/beer_model.dart';

class BeersApiDataProvider {
  Future<List<BeerModel>> data() async {
    // Read from DB or make network request etc...
    return List.filled(10, BeerModel(1, "Beer"));
  }
}