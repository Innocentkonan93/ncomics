import 'package:flutter/material.dart';
import 'package:ncomics/providers/category.dart';
import 'package:ncomics/screen/by_category_screen.dart';
import 'package:provider/provider.dart';

class CategoryListItem extends StatelessWidget {
  static const routeName = 'categories-item';
  final Color colors;
  CategoryListItem(this.colors);

  @override
  Widget build(BuildContext context) {
    final cat = Provider.of<Category>(context);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ByCategroyScreen.routeName, arguments: {
          'categorieId': cat.idCategorie,
          'categories': cat.categories,
        });
      },
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: colors,
              )),
          padding: EdgeInsets.all(10),
          child: Text(
            cat.categories,
          ),
        ),
      ),
    );
  }
}
