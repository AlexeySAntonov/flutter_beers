import 'package:equatable/equatable.dart';
import 'package:flutter_beers/ui/base/list_item.dart';

abstract class ListState extends Equatable {}

class Data extends ListState {
  Data(this.items);

  final List<ListItem> items;

  @override
  List<Object> get props => [items];
}

class Initial extends ListState {
  @override
  List<Object> get props => [];
}

class Loading extends ListState {
  @override
  List<Object> get props => [];
}

class Error extends ListState {
  @override
  List<Object> get props => [];
}