import 'package:flutter_beers/data/provider/beers_api_provider.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class BeersRepository {
  final BeersApiDataProvider apiProvider;

  BeersRepository({required this.apiProvider});

  Future<List<BeerModel>> initialData() async {
    return apiProvider.initialData();
  }

  Future<List<BeerModel>> loadMore({required int offset}) async {
    return apiProvider.loadMore(offset: offset);
  }
}
