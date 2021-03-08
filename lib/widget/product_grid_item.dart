import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductGridItem extends StatefulWidget {
  final String query;

  ProductGridItem({this.query});

  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {
  bool isFavorite = true;
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
    final cart = Provider.of<Cart>(context, listen: true);
    return Hero(
      tag: 'Bd-${product.idBd}',
      transitionOnUserGestures: true,
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print(product.idBd);
                  Navigator.of(context).pushNamed(
                    ProductDetailScreen.routeName,
                    arguments: (product.idBd),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  //elevation: 7,
                  child: Container(
                    width: double.infinity,
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
            ),
            Container(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        product.titleBd,
                        style: GoogleFonts.comfortaa(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container
          ],
        ),
      ),
    );
  }
}

// Flushbar(
//                           flushbarPosition: FlushbarPosition.TOP,
//                           title: "Vote",
//                           duration: Duration(seconds: 5),
//                           messageText: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 "Vote enregistré",
//                                 style: GoogleFonts.quicksand(
//                                   color: Colors.green,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                               Icon(
//                                 FontAwesomeIcons.checkCircle,
//                                 color: Colors.white,
//                                 size: 33,
//                               ),
//                             ],
//                           ),
//                           margin: EdgeInsets.symmetric(horizontal: 10),
//                           borderRadius: 8)
//                         ..show(context);
