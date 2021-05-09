import 'package:flutter/material.dart';
import 'package:flutter_beers/business/cubit_favorites.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_widget.dart';
import 'package:flutter_beers/ui/base/stub/text_stub_widget.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'package:flutter_beers/ui/favorites/favorite_beer_card_widget.dart';
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
            return _buildGrid((state as Data).items);
          default:
            throw Exception("Unsupported state: $state");
        }
      }),
    );
  }

  Widget _buildGrid(List<ListItem> data) {
    // No possibility to make GridView child's height wrap by its content for now
    // https://github.com/flutter/flutter/issues/29035
    final double screenWidth = MediaQuery.of(context).size.width;
    const double gridSpacing = 8.0;
    const int crossAxisCount = 2;
    final double itemWidth = screenWidth / crossAxisCount - gridSpacing * (crossAxisCount + 1);
    final double childAspectRatio = itemWidth / FavoriteBeerCardWidget.CARD_HEIGHT;

    return GridView.builder(
      padding: EdgeInsets.all(gridSpacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: gridSpacing,
        mainAxisSpacing: gridSpacing,
      ),
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        return _buildRow(data[index]);
      },
      physics: const AlwaysScrollableScrollPhysics(),
    );
  }

  Widget _buildRow(ListItem item) {
    switch (item.runtimeType) {
      case BeerItem:
        return FavoriteBeerCardWidget(item: (item as BeerItem));
      case PaginationLoadingItem:
        return PaginationLoadingWidget();
      default:
        throw Exception("Unsupported item type: $item");
    }
  }
}
