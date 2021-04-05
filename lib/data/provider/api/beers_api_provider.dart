import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_beers/data/provider/api/api_constants.dart';

class BeersApiDataProvider {
  BeersApiDataProvider({required this.client});

  final Dio client;

  Future<List<BeerModel>> initialData() async {
    try {
      final url = "$BASE_URL$BEERS_GET$PAGE=1&$LIMIT=$DEFAULT_LIMIT";
      final response = await client.get(url);
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

  Future<List<BeerModel>> loadMore({required int offset}) async {
    try {
      final int nextPage = offset ~/ DEFAULT_LIMIT + 1;
      final url = "$BASE_URL$BEERS_GET$PAGE=$nextPage&$LIMIT=$DEFAULT_LIMIT";
      final response = await client.get(url);
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
