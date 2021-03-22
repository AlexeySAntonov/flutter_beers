import 'package:equatable/equatable.dart';
import 'package:flutter_beers/ui/beer_item.dart';

abstract class BeersState extends Equatable {}

class Data extends BeersState {
  Data(this.beers);

  final List<BeerItem> beers;

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