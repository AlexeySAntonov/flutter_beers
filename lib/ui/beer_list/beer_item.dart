import 'package:dataclass/dataclass.dart';
import 'package:flutter_beers/ui/base/list_item.dart';

@dataClass
class BeerItem extends ListItem {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  BeerItem({required this.id, required this.name, required this.description, required this.imageUrl});
}