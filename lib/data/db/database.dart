// These imports are only needed to open the database
import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:moor/ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:moor/moor.dart';
import 'dart:io';
import 'package:flutter_beers/data/db/entity/beer_entity.dart';
import 'package:flutter_beers/business/mapper.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [Beers],
)
class BeersDatabase extends _$BeersDatabase {
  // we tell the database where to store the data with this constructor
  BeersDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertBeers(List<BeerModel> models) async {
    // keep the favorites attribute
    final List<BeerEntity?> existent = await getBeers();
    await batch((batch) {
      batch.insertAll(
          beers,
          models
              .map((model) => model.entity(favorite: existent.firstWhere((entity) => entity?.id == model.id, orElse: () => null)?.favorite))
              .toList(),
          mode: InsertMode.insertOrReplace);
    });
  }

  Future<List<BeerEntity>> getBeers() {
    return (select(beers)).get();
  }

  // watches beers with limit and offset, emit new items whenever the underlying data changes.
  Stream<List<BeerModel>> watchBeers(int limit, int offset) {
    return (select(beers)..limit(limit, offset: offset)).map((entity) => entity.model()).watch();
  }

  // watches all favorite beers, emit new items whenever the underlying data changes.
  Stream<List<BeerEntity>> watchFavoriteBeers() {
    return (select(beers)..where((beer) => beer.favorite)).watch();
  }

  Future<void> toggleFavorite(int id) {
    return update(beers).write(BeersCompanion(id: Value(id), favorite: Value(true)));
  }

  Future<void> setFavorite({required int id, required bool favorite}) {
    return (update(beers)..where((t) => t.id.equals(id))).write(BeersCompanion(favorite: Value(favorite)));
  }
}
