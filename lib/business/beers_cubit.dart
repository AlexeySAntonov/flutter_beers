import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/beers_state.dart';
import 'beers_state.dart';
import 'package:flutter_beers/data/repository/beers_repository.dart';

class BeersCubit extends Cubit<BeersState> {
  BeersCubit({this.repository}) : super(Initial()) {
    fetchBeers();
  }

  final BeersRepository repository;

  void fetchBeers() async {
    try {
      emit(Loading());
      final items = await repository.data();
      emit(Data(items));
    } on Exception {
      emit(Error());
    }
  }
}
