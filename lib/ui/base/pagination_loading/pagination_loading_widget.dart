import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginationLoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Center(
    child: SizedBox(
      width: 24.0,
      height: 24.0,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    ),
  );
}
