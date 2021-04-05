import 'package:moor/moor.dart';

@DataClassName("BeerEntity")
class Beers extends Table {

  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get imageUrl => text()();
  BoolColumn get favorite => boolean().withDefault(const Constant(false))();
}