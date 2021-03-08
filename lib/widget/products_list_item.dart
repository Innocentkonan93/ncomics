import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';

import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:ncomics/widget/star_display.dart';

import 'package:provider/provider.dart';

class ProductListItem extends StatefulWidget {
  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<BandeDessinees>(context);
    final cart = Provider.of<Cart>(context);

    return GestureDetector(
      onTap: () {
        print(product.idBd);
        Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
            arguments: (product.idBd));
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.only(top: 10, right: 17, left: 17, bottom: 5),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Card(
                elevation: 7,
                child: Image.network(
                  'http://bad-event.com/ncomic/uploads/${product.imageBd}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(3),
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      spreadRadius: 2,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  product.titleBd,
                                  style: GoogleFonts.comfortaa(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(
                            'FR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: Colors.black.withOpacity(0.6),
                          padding: EdgeInsets.all(2),
                        ),
                      ],
                    ),
                    //Spacer(),
                    StarDisplay(
                      product.ratingBd == null
                          ? 0
                          : int.parse(product.ratingBd),
                    ),
                    Row(
                      children: [
                        Text('Dessinateur: ${product.nomAuteur}'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                product.prixBd == '0'
                                    ? Text(
                                        'Free',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : Text(
                                        product.prixBd + 'P',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          if (!cart.items.containsKey(product.idBd))
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Theme.of(context).errorColor,
                                //borderRadius: BorderRadius.circular(radius)
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.shopping_cart,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Produit ajouté',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      duration: Duration(seconds: 2),
                                      backgroundColor:
                                          Colors.black.withOpacity(0.8),
                                      action: SnackBarAction(
                                        label: 'Annuler',
                                        onPressed: () {
                                          cart.removeSingleItem(product.idBd);
                                        },
                                        textColor: Theme.of(context).errorColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  );
                                  cart.addItem(
                                    product.idBd,
                                    product.prixBd,
                                    product.titleBd,
                                    product.imageBd,
                                  );
                                },
                              ),
                            ),
                          if (cart.items.containsKey(product.idBd))
                            Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                color: Theme.of(context).errorColor,
                                //borderRadius: BorderRadius.circular(radius)
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.done,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          Expanded(
                            child: Container(
                              child: IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Theme.of(context).errorColor,
                                  size: 19,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
