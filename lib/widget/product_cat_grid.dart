import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/widget/product_grid_item.dart';
import 'package:provider/provider.dart';

class ProductCatGrid extends StatelessWidget {
  final String idCat;
  ProductCatGrid(this.idCat);
  @override
  Widget build(BuildContext context) {
    final bdprovider = Provider.of<BdProvider>(context);
    final product = bdprovider.bycatprod(idCat);

    return GridView.builder(
      itemCount: product.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductGridItem()
      ),
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
