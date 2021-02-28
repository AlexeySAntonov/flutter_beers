import 'package:dataclass/dataclass.dart';

@dataClass
class BeerModel {
  final int id;
  final String name;

  BeerModel(this.id, this.name);
}