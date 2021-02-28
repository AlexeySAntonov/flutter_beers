import 'package:flutter/material.dart';

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
      body: _buildList(),
    );
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

  Widget _buildList() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider();
          return _buildRow();
        });
  }

  Widget _buildRow() {
    return ListTile(
      title: Text(
        "Test",
        style: _font,
      ),
      trailing: Icon(
        Icons.favorite,
        color: Colors.red,
      ),
    );
  }
}
