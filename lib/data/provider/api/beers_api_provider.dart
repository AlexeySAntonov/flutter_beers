import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_beers/data/provider/api/api_constants.dart';
import 'package:flutter_beers/data/provider/api/ibeers_api_provider.dart';

class BeersApiDataProvider extends IBeersApiDataProvider {
  final Dio _client;

  BeersApiDataProvider({required Dio client}) : _client = client;

  @override
  Future<List<BeerModel>> initialData() async {
    try {
      final url = "$BASE_URL$BEERS_GET$PAGE=1&$LIMIT=$DEFAULT_LIMIT";
      final response = await _client.get(url);
      final beers = List<BeerModel>.of(
        response.data.map<BeerModel>((json) => BeerModel(
              id: json['id'],
              name: json['name'],
              description: json['description'],
              imageUrl: json['image_url'],
              favorite: false,
            )),
      );
      return beers;
    } catch (e) {
      throw (e);
    }
  }

  @override
  Future<List<BeerModel>> loadMore({required int offset}) async {
    try {
      final int nextPage = offset ~/ DEFAULT_LIMIT + 1;
      final url = "$BASE_URL$BEERS_GET$PAGE=$nextPage&$LIMIT=$DEFAULT_LIMIT";
      final response = await _client.get(url);
      final beers = List<BeerModel>.of(
        response.data.map<BeerModel>((json) => BeerModel(
              id: json['id'],
              name: json['name'],
              description: json['description'],
              imageUrl: json['image_url'],
              favorite: false,
            )),
      );
      return beers;
    } catch (e) {
      throw (e);
    }
  }
}
