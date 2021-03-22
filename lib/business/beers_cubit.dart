import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/beers_state.dart';
import 'package:flutter_beers/business/mapper.dart';
import 'package:flutter_beers/ui/beer_item.dart';
import 'beers_state.dart';
import 'package:flutter_beers/data/repository/beers_repository.dart';

class BeersCubit extends Cubit<BeersState> {
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

  List<BeerItem> _currentBeers() {
    if (state is Data) {
      return (state as Data).beers;
    } else {
      return List.empty();
    }
  }
}
