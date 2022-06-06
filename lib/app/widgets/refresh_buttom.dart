import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget refreshButton(VoidCallback refreshPage) {
  return Container(
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.only(right: 8),
    child: IconButton(
      icon: Icon(Icons.refresh),
      onPressed: refreshPage,
    ),
  );
}
