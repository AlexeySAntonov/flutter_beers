import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Divider(
    color: Colors.grey[400],
    height: 1.0,
    thickness: 0.2,
    indent: 16.0,
    endIndent: 16.0,
  );
}
