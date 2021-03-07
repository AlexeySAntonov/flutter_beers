import 'package:equatable/equatable.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

abstract class BeersState extends Equatable {}

class Data extends BeersState {
  Data(this.beers);

  final List<BeerModel> beers;

  @override
  List<Object> get props => [beers];
}

class Initial extends BeersState {
  @override
  List<Object> get props => [];
}

class Loading extends BeersState {
  @override
  List<Object> get props => [];
}

class Error extends BeersState {
  @override
  List<Object> get props => [];
}