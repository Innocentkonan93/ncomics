
import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:provider/provider.dart';
import 'product_grid_item.dart';

class ProductsGrid extends StatelessWidget {
  bool isGrid = true;

  ProductsGrid(this.isGrid);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<BdProvider>(context);
    final products = productsData.listbd;
    return products.isNotEmpty
        ? Scrollbar(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(12.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 15,
              ),
              itemCount: 6,
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: products[i],
                child: ProductGridItem(),
              ),
            ),
          )
        : Center(
            child: Container(
            height: 200,
            width: 200,
            child: Image.asset('assets/images/404.png'),
          ));
  }
}
