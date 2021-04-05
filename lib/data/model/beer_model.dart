
class BeerModel {
  final int id;
  final String name;
  final String description;
  final String? imageUrl;
  final bool favorite;

  BeerModel({required this.id, required this.name, required this.description, required this.imageUrl, required this.favorite});
}