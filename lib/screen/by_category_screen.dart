import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/widget/badge.dart';
import 'package:ncomics/widget/product_cat_grid.dart';
import 'package:ncomics/widget/products_grid.dart';
import 'package:provider/provider.dart';

class ByCategroyScreen extends StatelessWidget {
  static const routeName = 'by-cat';
  @override
  Widget build(BuildContext context) {
    final cat = Provider.of<Cart>(context);
    final catRouteData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final idCat = catRouteData['categorieId'];
    final catName = catRouteData['categories'];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Spacer(),
                        Consumer<Cart>(
                          builder: (context, cart, ch) => Badge(
                            child: ch,
                            value: cart.itemCount.toString(),
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.add_shopping_cart_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                CartScreen.routeName,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'La categorie',
                            style: GoogleFonts.nunitoSans(fontSize: 30),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Text(
                              catName,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Consumer<BdProvider>(
                builder: (context, bdProvider, child) {
                  return bdProvider.isProcessing
                      ? CircularProgressIndicator()
                      : ProductCatGrid(idCat);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
