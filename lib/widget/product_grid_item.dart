import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:ncomics/widget/star_display.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductGridItem extends StatefulWidget {
  final String query;

  ProductGridItem({this.query});

  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  String idBd;
  Future<List> ratingPost() async {
    final resp = await http
        .post('http://bad-event.com/ncomic/dataHandling/addRating.php', body: {
      'idBd': idBd,
    });
  }

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
                    'http://bad-event.com/ncomic/uploads/${product.imageBd}',
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
                  width: 3,
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
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  product.prixBd == '0' ? 'Free' : product.prixBd + ' pts',
                  style: GoogleFonts.comfortaa(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).errorColor,
                  ),
                ),
                IconButton(
                  icon: Container(
                    height: 27,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 7),
                  decoration: BoxDecoration(
                    color: Theme.of(context).errorColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(
                      6,
                    ),
                  ),
                    child: Icon(
                      Icons.add_shopping_cart_sharp,
                      color: Colors.white,
                      size: 17,
                    ),
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
                Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Theme.of(context).errorColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(
                      6,
                    ),
                  ),
                  child: Text('')
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      idBd = product.idBd;
                    });
                    print(product.isRating);
                    ratingPost();
                    Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        title: "Vote",
                        duration: Duration(seconds: 5),
                        messageText: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Vote enregistré",
                              style: GoogleFonts.quicksand(
                                color: Colors.green,
                                fontSize: 18,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.white,
                              size: 33,
                            ),
                          ],
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        borderRadius: 8)
                      ..show(context);
                    // Fluttertoast.showToast(
                    //     msg: 'Note enregistré',
                    //     backgroundColor: Colors.black.withOpacity(0.7),
                    //     textColor: Colors.white,
                    //     timeInSecForIosWeb: 3,
                    //     toastLength: Toast.LENGTH_LONG,
                    //     fontSize: 13);
                  },
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
