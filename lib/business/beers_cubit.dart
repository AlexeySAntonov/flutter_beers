import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/list_state.dart';
import 'package:flutter_beers/business/mapper.dart';
import 'package:flutter_beers/data/provider/api/api_constants.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'list_state.dart';
import 'package:flutter_beers/data/repository/beers_repository.dart';

class BeersCubit extends Cubit<ListState> {
  BeersCubit({required this.repository}) : super(Initial()) {
    fetchBeers();
  }

  final BeersRepository repository;

  void fetchBeers() async {
    try {
      emit(Loading());
      final items = await repository.initialData();
      emit(Data(items.map((model) => model.item()).toList()..add(PaginationLoadingItem())));
    } on Exception {
      emit(Error());
    }
  }

  void loadMore() async {
    try {
      final currentBeers = _currentBeers().where((element) => element is BeerItem); // TODO: The non-optimal solution, need to improve
      final newBeers = await repository.loadMore(offset: currentBeers.length);
      final List<ListItem> resultItems = List.from(currentBeers)..addAll(newBeers.map((model) => model.item()));
      if (newBeers.length == DEFAULT_LIMIT) {
        resultItems.add(PaginationLoadingItem());
      }
      emit(Data(resultItems));
    } on Exception {
      emit(Error());
    }
  }

  List<ListItem> _currentBeers() => (state is Data) ? (state as Data).items : List.empty();

}
