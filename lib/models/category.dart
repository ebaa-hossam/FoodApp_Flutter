//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//class that contains identification of single category

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, //default color
  });

  final String id;
  final String title;
  final Color color;
}