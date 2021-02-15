import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/widget/products_list_item.dart';
import 'package:provider/provider.dart';
import 'product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  bool isGrid = true;

  ProductsGrid(this.isGrid);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BdProvider>(context);
    final products = productsData.listbd;
    return isGrid
        ? Scrollbar(
            child: GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 25,
              ),
              itemCount: products.length,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: ProductGridItem(),
              ),
            ),
          )
        : ListView.builder(
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: products[index],
              child: ProductListItem(),
            ),
            itemCount: products.length,
          );
  }
}
