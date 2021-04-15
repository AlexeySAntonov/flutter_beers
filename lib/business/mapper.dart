import 'package:flutter_beers/data/db/database.dart';
import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';

final String _beerPlaceholderUrl = "https://drive.google.com/uc?export=download&id=17tSQNYHDL3ZghLEflmPG5VrOsvm6T1Gz";

extension BeerModelExtension on BeerModel {
  ListItem item() => BeerItem(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: (this.imageUrl == null) ? _beerPlaceholderUrl : this.imageUrl!,
      );

  BeerEntity entity({required bool? favorite}) => BeerEntity(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: (this.imageUrl == null) ? _beerPlaceholderUrl : this.imageUrl!,
        favorite: (favorite == null) ? false : favorite,
      );
}

extension BeerEntityExtension on BeerEntity {
  BeerModel model() => BeerModel(
        id: this.id,
        name: this.name,
        description: this.description,
        imageUrl: this.imageUrl,
        favorite: this.favorite,
      );
}
