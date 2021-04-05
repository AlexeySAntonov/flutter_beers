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
  queries: {
    'getBeersByIds': 'SELECT * FROM beers WHERE id in (:ids)',
  },
)
class BeersDatabase extends _$BeersDatabase {
  // we tell the database where to store the data with this constructor
  BeersDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertBeers(List<BeerModel> models) async {
    // final existentBeers = await getBeersByIds(models.map((model) => model.id).toSet());
  }

  Future<List<BeerEntity>> getBeersByIds(Set<int> ids) {
    // return (select(beers)..where((beer) => ids.contains(beer.id))).get();
    return customSelect('SELECT * FROM beers WHERE id in (:$ids)', readsFrom: beers).map((rows) {
      
    });
  }

  // watches beers with limit and offset, emit new items whenever the underlying data changes.
  Stream<List<BeerModel>> watchBeers(int limit, int offset) {
    return (select(beers)..limit(limit, offset: offset)).map((entity) => entity.model()).watch();
  }

  // watches all favorite beers, emit new items whenever the underlying data changes.
  Stream<List<BeerEntity>> watchFavoriteBeers() {
    return (select(beers)..where((beer) => beer.favorite)).watch();
  }
}
