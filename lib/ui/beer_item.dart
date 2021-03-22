import 'package:dataclass/dataclass.dart';

@dataClass
class BeerItem {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  BeerItem({required this.id, required this.name, required this.description, required this.imageUrl});
}