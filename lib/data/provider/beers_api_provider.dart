import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:dio/dio.dart';

final String _baseUrl = 'https://api.punkapi.com/v2/';
final String _beersGet = 'beers?';
final String _page = 'page';
final String _limit = 'per_page';
final int _defaultLimit = 20;

class BeersApiDataProvider {
  BeersApiDataProvider({required this.client});

  final Dio client;

  Future<List<BeerModel>> initialData() async {
    try {
      final url = "$_baseUrl$_beersGet$_page=1&$_limit=$_defaultLimit";
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

  Future<List<BeerModel>> loadMore({required int offset}) async {
    try {
      final int nextPage = offset ~/ _defaultLimit + 1;
      final url = "$_baseUrl$_beersGet$_page=$nextPage&$_limit=$_defaultLimit";
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
