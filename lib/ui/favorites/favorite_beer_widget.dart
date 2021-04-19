import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beers/business/cubit_favorites.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class FavoriteBeerWidget extends StatelessWidget {
  FavoriteBeerWidget({required this.item});

  final BeerItem item;

  final _titleFont = TextStyle(fontSize: 16.0);
  final _subtitleFont = TextStyle(fontSize: 14.0);

  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.fromLTRB(12.0, 8.0, 16.0, 8.0),
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
          fit: BoxFit.contain,
        ),
        title: Text(
          item.name,
          style: _titleFont,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Text(
            item.description,
            style: _subtitleFont,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
        trailing: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(item.favorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red[400],
              constraints: BoxConstraints(maxWidth: 24.0, maxHeight: 24.0),
              padding: EdgeInsets.all(0.0),
              splashRadius: 24.0,
              onPressed: () {
                context.cubit<FavoritesCubit>().setFavorite(id: item.id, favorite: !item.favorite);
              },
            ),
          ],
        ),
        onTap: () {
          // TODO: Goto details
        },
      );
}
