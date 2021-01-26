import 'package:flutter/material.dart';
import 'package:ncomics/providers/cat_provider.dart';

import 'package:ncomics/widget/category_list_item.dart';
import 'package:provider/provider.dart';

class CategoryList extends StatelessWidget {
  final List<Color> _colors = <Color>[
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CatProvider>(context);
    final catData = category.categoryList;
    return Container(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catData.length,
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: catData[index],
          child: Container(
            margin: EdgeInsets.only(left: 20),
            child: CategoryListItem(),
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _colors[index])
            ),
          ),
        ),
      ),
    );
  }
}
