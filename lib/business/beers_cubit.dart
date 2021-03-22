import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/list_state.dart';
import 'package:flutter_beers/business/mapper.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
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
      emit(Data(items.map((model) => model.item()).toList()));
    } on Exception {
      emit(Error());
    }
  }

  void loadMore() async {
    try {
      final currentBeers = _currentBeers();
      final newBeers = await repository.loadMore(offset: currentBeers.length);
      emit(Data(List.from(currentBeers)..addAll(newBeers.map((model) => model.item()))));
    } on Exception {
      emit(Error());
    }
  }

  List<ListItem> _currentBeers() => (state is Data) ? (state as Data).items : List.empty();

  // List<ListItem> _currentBeers() {
  //   if (state is Data) {
  //     return (state as Data).items;
  //   } else {
  //     return List.empty();
  //   }
  // }
}
