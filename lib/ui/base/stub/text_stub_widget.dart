import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextStubWidget extends StatelessWidget {

  TextStubWidget({required this.stubText});

  final String stubText;

  @override
  Widget build(BuildContext context) => Align(alignment: Alignment.center, child: Text(stubText));
}
