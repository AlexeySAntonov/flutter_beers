import 'package:flutter_beers/data/provider/beers_api_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersRepository {
  final BeersApiDataProvider apiProvider;

  BeersRepository({this.apiProvider});

  Future<List<BeerModel>> data() async {
    return apiProvider.data();
  }
}