import 'package:flutter/material.dart';
import 'package:flutter_beers/ui/base/divider/divider_widget.dart';
import 'package:flutter_beers/ui/base/list_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_item.dart';
import 'package:flutter_beers/ui/base/pagination_loading/pagination_loading_widget.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'package:flutter_beers/ui/beer_list/beer_widget.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_beers/business/beers_cubit.dart';
import 'package:flutter_beers/business/list_state.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Beers 😍"),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushFavorites)],
      ),
      body: CubitBuilder<BeersCubit, ListState>(builder: (context, state) {
        switch (state.runtimeType) {
          case Loading:
            return Center(child: CircularProgressIndicator());
          case Error:
            return _buildTextStub('Error occurred...');
          case Data:
            return _buildList((state as Data).items);
          default:
            throw Exception("Unsupported state: $state");
        }
      }),
    );
  }

  Widget _buildTextStub(String text) => Align(alignment: Alignment.center, child: Text(text));

  Widget _buildList(List<ListItem> data) => NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            CubitProvider.of<BeersCubit>(context).loadMore(); // The same is context.cubit<BeersCubit>().loadMore();
            return true;
          }
          return false;
        },
        child: ListView.separated(
            itemBuilder: (context, i) => _buildRow(data[i]),
            separatorBuilder: (context, index) => DividerWidget(),
            itemCount: data.length),
      );

  Widget _buildRow(ListItem item) {
    switch (item.runtimeType) {
      case BeerItem:
        return BeerWidget(item: (item as BeerItem));
      case PaginationLoadingItem:
        return PaginationLoadingWidget();
      default:
        throw Exception("Unsupported item type: $item");
    }
  }

  void _pushFavorites() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text("Favorites"),
          ),
          body: ListView(children: List.empty()));
    }));
  }
}
