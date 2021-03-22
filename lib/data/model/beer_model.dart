import 'package:dataclass/dataclass.dart';

@dataClass
class BeerModel {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;

  BeerModel({required this.id, required this.name, required this.description, required this.imageUrl});
}