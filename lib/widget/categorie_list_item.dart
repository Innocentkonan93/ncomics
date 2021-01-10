import 'package:flutter/material.dart';

class CategorieListItem extends StatelessWidget {
  static const routeName = 'categories-item';
  final String title;
  CategorieListItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.blue),
      padding: EdgeInsets.all(10),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
