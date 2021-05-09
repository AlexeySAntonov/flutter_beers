import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_beers/ui/beer_list/beer_item.dart';
import 'package:flutter/material.dart';

class FavoriteBeerCardWidget extends StatelessWidget {
  FavoriteBeerCardWidget({required this.item});

  final BeerItem item;

  final _titleFont = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black87);
  final _subtitleFont = TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, color: Colors.grey[900]);

  static const double CARD_PADDING = 8.0;
  static const double IMAGE_HEIGHT = 200.0;
  static const double TITLE_HEIGHT_SUMMARY = 38.0; // 16 (padding) + 18 (fontSize * maxLines) + 4 (inner text padding)
  static const double DESCRIPTION_HEIGHT_SUMMARY = 26.0; // 8 (padding) + 28 (fontSize * maxLines) + 4 (inner text padding)
  static const double CARD_HEIGHT = CARD_PADDING * 2 + IMAGE_HEIGHT + TITLE_HEIGHT_SUMMARY + DESCRIPTION_HEIGHT_SUMMARY;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(CARD_PADDING),
          child: Column(
            children: <Widget>[
              CachedNetworkImage(
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
                height: IMAGE_HEIGHT,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.name,
                    style: _titleFont,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  item.description,
                  style: _subtitleFont,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      );
}
