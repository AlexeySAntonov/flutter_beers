import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/ui/beer_item.dart';

final String _placeholderUrl = "https://drive.google.com/uc?export=download&id=17tSQNYHDL3ZghLEflmPG5VrOsvm6T1Gz";

extension BeerModelExtension on BeerModel {
  BeerItem item() => BeerItem(
      id: this.id,
      name: this.name,
      description: this.description,
      imageUrl: (this.imageUrl == null) ? _placeholderUrl : this.imageUrl!
  );
}
