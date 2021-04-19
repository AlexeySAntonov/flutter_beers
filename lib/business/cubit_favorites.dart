import 'package:cubit/cubit.dart';
import 'package:flutter_beers/business/list_state.dart';
import 'package:flutter_beers/business/mapper.dart';
import 'package:flutter_beers/data/repository/favorites_repository.dart';
import 'list_state.dart';

class FavoritesCubit extends Cubit<ListState> {
  FavoritesCubit({required this.repository}) : super(Initial()) {
    favoritesData();
  }

  final FavoritesRepository repository;

  void favoritesData() async {
    try {
      emit(Loading());
      repository.favoritesBeersStream().listen((models) {
        emit(Data(models.map((model) => model.item()).toList()));
      });
    } on Exception {
      emit(Error());
    }
  }

  void setFavorite({required int id, required bool favorite}) async {
    repository.setFavorite(id: id, favorite: favorite);
  }
}
