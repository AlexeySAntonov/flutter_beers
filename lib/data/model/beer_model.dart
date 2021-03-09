import 'package:dataclass/dataclass.dart';

@dataClass
class BeerModel {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  BeerModel({this.id, this.name, this.description, this.imageUrl});
}