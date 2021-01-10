import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/widget/products_list_item.dart';
import 'package:provider/provider.dart';
import 'product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  bool isGrid = true;

  ProductsGrid(this.isGrid);

  // ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BdProvider>(context);
    final products = productsData.listbd;
    return isGrid
        ? GridView.builder(
            padding: const EdgeInsets.all(20.0),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              // builder: (c) => products[i],
              value: products[i],
              child: ProductGridItem(
                  // products[i].id,
                  // products[i].title,
                  // products[i].imageUrl,
                  ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              // builder: (c) => products[i],
              value: products[index],
              child: ProductListItem(),),
            itemCount: products.length,
          );
  }
}
