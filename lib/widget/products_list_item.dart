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
        height: 156,
        margin: EdgeInsets.only(top: 20, right: 17, left: 17, bottom: 13),
        padding: EdgeInsets.only(top: 8, right: 8, left: 8, bottom: 8),
        child: Row(
          children: [
            Container(
              height: 156,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.network(
                'http://192.168.64.2/Projects/ncomic/uploads/${product.imageBd}',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.titleBd,
                          style: GoogleFonts.comfortaa(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Chip(
                          label: Text(
                            'FR',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          backgroundColor: Colors.black.withOpacity(0.6),
                        ),
                      ],
                    ),
                    Row(
                      children: [Text('Auteur: ${product.nomAuteur}')],
                    ),
                    SizedBox(height: 8),
                    StarDisplay(int.parse(product.ratingBd)),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              // Consumer<BandeDessinees>(
                              //   builder: (context, bd, child) => IconButton(
                              //     icon: Icon(FontAwesomeIcons.thumbsUp),
                              //     onPressed: () {
                              //       bd.incrementCounter();
                              //     },
                              //   ),
                              // ),
                              // Text(product.getCounter().toString(),
                              //     style: TextStyle(fontSize: 17)),

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(3)),
                                child: Text(
                                  product.prixBd == '0'
                                      ? 'Gratuit'
                                      : product.prixBd + ' pt',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: FlatButton(
                            padding: EdgeInsets.all(3),
                            child: Row(
                              children: [
                                Text(
                                  'Acheter',
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor),
                                ),
                                Icon(
                                  Icons.download_rounded,
                                  color: Theme.of(context).errorColor,
                                )
                              ],
                            ),
                            onPressed: () {
                              Scaffold.of(context).hideCurrentSnackBar();
                              Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Produit ajouté'),
                                  duration: Duration(seconds: 1),
                                  backgroundColor:
                                      Colors.black.withOpacity(0.8),
                                  action: SnackBarAction(
                                    label: 'Annuler',
                                    onPressed: () {
                                      cart.removeSingleItem(product.idBd);
                                    },
                                    textColor: Theme.of(context).errorColor,
                                  ),
                                ),
                              );
                              cart.addItem(
                                product.idBd,
                                product.prixBd,
                                product.titleBd,
                              );
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                color: Colors.grey.shade300,
              )
            ]),
      ),
    );
  }
}
