import 'dart:async';

import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/list_state.dart';
import 'package:flutter_beers/business/mapper.dart';
import 'package:flutter_beers/data/provider/api/api_constants.dart';
import 'package:flutter_beers/data/model/beer_model.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'list_state.dart';
import 'package:flutter_beers/data/repository/beers_repository.dart';

class BeersCubit extends Cubit<ListState> {
  BeersCubit({required this.repository}) : super(Initial()) {
    initialData();
  }

  final BeersRepository repository;

  StreamSubscription<List<BeerModel>>? beersStreamSubscription;

  void initialData() async {
    try {
      emit(Loading());
      await repository.initialData();
      beersStreamSubscription = repository.beersStream(limit: DEFAULT_LIMIT, offset: 0).listen((models) {
        emit(Data(models.map((model) => model.item()).toList()..add(PaginationLoadingItem())));
      });
    } on Exception {
      emit(Error());
    }
  }

  void loadMore() async {
    try {
      final currentBeers = _currentBeers().where((element) => element is BeerItem); // TODO: The non-optimal solution, need to improve
      await repository.loadMore(offset: currentBeers.length);
      beersStreamSubscription?.cancel();
      beersStreamSubscription = repository.beersStream(limit: DEFAULT_LIMIT + currentBeers.length, offset: 0).listen((models) {
        emit(Data(models.map((model) => model.item()).toList()..add(PaginationLoadingItem())));
      });
    } on Exception {
      emit(Error());
    }
  }

  void setFavorite({required int id, required bool favorite}) async {
    repository.setFavorite(id: id, favorite: favorite);
  }

  List<ListItem> _currentBeers() => (state is Data) ? (state as Data).items : List.empty();
}
