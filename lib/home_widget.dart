import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_beers/business/beers_cubit.dart';
import 'package:flutter_beers/business/beers_state.dart';
import 'package:flutter_beers/data/model/beer_model.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  final _titleFont = TextStyle(fontSize: 16.0);
  final _subtitleFont = TextStyle(fontSize: 14.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Beers 😍"),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushFavorites)],
      ),
      body: CubitBuilder<BeersCubit, BeersState>(builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is Error) {
          return _buildTextStub('Error occurred...');
        }
        if (state is Data) {
          return _buildList(state.beers);
        }
        return Container();
      }),
    );
  }

  Widget _buildTextStub(String text) => Align(alignment: Alignment.center, child: Text(text));

  Widget _buildList(List<BeerModel> data) => ListView.separated(
      // padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) => _buildRow(data[i]),
      separatorBuilder: (context, index) => Divider(color: Colors.grey),
      itemCount: data.length);

  Widget _buildRow(BeerModel item) => ListTile(
        contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
        leading: CachedNetworkImage(
          imageUrl: item.imageUrl,
          placeholder: (context, url) => Center(
            child: SizedBox(
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
          width: 64.0,
          height: 64.0,
        ),
        title: Text(
          item.name,
          style: _titleFont,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          item.description,
          style: _subtitleFont,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Icon(
          Icons.favorite,
          color: Colors.red[400],
        ),
      );

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
