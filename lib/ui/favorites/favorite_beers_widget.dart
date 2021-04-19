import 'package:flutter/material.dart';
import 'package:flutter_beers/business/cubit_favorites.dart';
import 'package:flutter_beers/ui/base/divider/divider_widget.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_widget.dart';
import 'package:flutter_beers/ui/base/stub/text_stub_widget.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'package:flutter_beers/ui/favorites/favorite_beer_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_beers/business/list_state.dart';

class FavoriteBeersWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoriteBeersWidgetState();
}

class _FavoriteBeersWidgetState extends State<FavoriteBeersWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Beers ❤️"),
      ),
      body: CubitBuilder<FavoritesCubit, ListState>(builder: (context, state) {
        switch (state.runtimeType) {
          case Loading:
            return Center(child: CircularProgressIndicator());
          case Error:
            return TextStubWidget(stubText: "Error occurred...");
          case Data:
            return _buildList((state as Data).items);
          default:
            throw Exception("Unsupported state: $state");
        }
      }),
    );
  }

  Widget _buildList(List<ListItem> data) => ListView.separated(
        itemBuilder: (context, i) => _buildRow(data[i]),
        separatorBuilder: (context, index) => DividerWidget(),
        itemCount: data.length,
        // Possible ListView performance improvement
        // https://github.com/flutter/flutter/issues/22314
        physics: const AlwaysScrollableScrollPhysics(),
      );

  Widget _buildRow(ListItem item) {
    switch (item.runtimeType) {
      case BeerItem:
        return FavoriteBeerWidget(item: (item as BeerItem));
      case PaginationLoadingItem:
        return PaginationLoadingWidget();
      default:
        throw Exception("Unsupported item type: $item");
    }
  }
}
