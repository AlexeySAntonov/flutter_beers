import 'dart:async';
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

  final _font = TextStyle(fontSize: 18.0);

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
      padding: EdgeInsets.all(16.0),
      itemBuilder: (context, i) => _buildRow(data[i]),
      separatorBuilder: (context, index) => Divider(color: Colors.black),
      itemCount: data.length);

  Widget _buildRow(BeerModel item) => ListTile(
        title: Text(
          item.name,
          style: _font,
        ),
        trailing: Icon(
          Icons.favorite,
          color: Colors.red,
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
