import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:dio/dio.dart';

class BeersApiDataProvider {
  BeersApiDataProvider({this.client});

  final Dio client;

  Future<List<BeerModel>> data() async {
    try {
      final url = 'https://api.punkapi.com/v2/beers?page=1&per_page=20&abv_gt=0.0&abv_lt=100.0&ibu_gt=0.0&ibu_lt=2000.0&ebc_gt=0.0&ebc_lt=800.0';
      final response = await client.get(url);
      final beers = List<BeerModel>.of(
        response.data.map<BeerModel>((json) => BeerModel(
              id: json['id'],
              name: json['name'],
              description: json['description'],
              imageUrl: json['image_url']
            )),
      );
      return beers;
    } catch (e) {
      throw (e);
    }
  }
}
