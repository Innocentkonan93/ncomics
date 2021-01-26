import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:ncomics/widget/star_display.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {

   final String query;

   ProductGridItem({this.query});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<BandeDessinees>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                print(product.idBd);
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: (product.idBd));
              },
              child: Container(
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.network(
                    'http://192.168.64.2/Projects/ncomic/uploads/${product.imageBd}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 30,
            child: Row(
              children: [
                Expanded(
                  child: FittedBox(
                    child: Text(
                      product.titleBd,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: StarDisplay(
                    product.ratingBd == null ? 0 : int.parse(product.ratingBd),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 25,
                  width: 60,
                  padding: EdgeInsets.fromLTRB(5, 5, 3, 5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).errorColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(
                      6,
                    ),
                  ),
                  child: Text(
                    product.prixBd == '0' ? 'Free' : product.prixBd + ' pts',
                    style: GoogleFonts.comfortaa(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart_sharp,
                    color: Theme.of(context).errorColor,
                  ),
                  iconSize: 20,
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produit ajouté'),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.black.withOpacity(0.8),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    FontAwesomeIcons.solidThumbsUp,
                    color: Colors.indigo,
                    size: 16,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
