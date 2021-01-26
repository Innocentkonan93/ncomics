import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/bd_provider.dart';

import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/widget/badge.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailScreen extends StatefulWidget {
  static const routeName = 'product-detail';
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {

    String idBd = '';

    print('bd detail screen');
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadProduct = Provider.of<BdProvider>(context, listen: false)
        .listbd
        .firstWhere((element) => element.idBd == productId);
    print(productId);
    Future<List> getData() async {
      final res = await http.get(
          "http://192.168.64.2/Projects/ncomic/dataHandling/getImageBd.php?idBd=$productId");
      return json.decode(res.body);
    }

    Future<List> ratingPost() async {
      final resp = await http.post(
          'http://192.168.64.2/Projects/ncomic/dataHandling/addRating.php',
          body: {
            'idBd': idBd,
          });
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.90,
                                child: CartScreen(),
                              );
                            });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // row title;
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Text(
                              loadProduct.titleBd,
                              style: GoogleFonts.comfortaa(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          child: Container(
                            height: 450,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    'http://192.168.64.2/Projects/ncomic/uploads/${loadProduct.imageBd}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Chip(
                                        label: Text(
                                          'FR',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Auteur : '),
                          Text(
                            loadProduct.nomAuteur,
                            style:
                                GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loadProduct.prixBd == '0'
                                  ? 'Gratuit'
                                  : loadProduct.prixBd + ' pt',
                              style: GoogleFonts.notoSans(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<Cart>(
                              builder: (context, cart, _) {
                                return RaisedButton(
                                  child: Text('Ajouter',
                                      style: TextStyle(color: Colors.white)),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40)),
                                  color: Theme.of(context).errorColor,
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Produit ajouté'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor:
                                            Colors.black.withOpacity(0.8),
                                        action: SnackBarAction(
                                          label: 'Annuler',
                                          onPressed: () {
                                            cart.removeSingleItem(
                                                loadProduct.idBd);
                                          },
                                          textColor:
                                              Theme.of(context).errorColor,
                                        ),
                                      ),
                                    );
                                    cart.addItem(
                                      loadProduct.idBd,
                                      loadProduct.prixBd,
                                      loadProduct.titleBd,
                                    );
                                  },
                                );
                              },
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'votre note',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          loadProduct.isRating == '0'
                                              ? FontAwesomeIcons.thumbsUp
                                              : FontAwesomeIcons.thumbsUp,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            idBd = loadProduct.idBd;
                                          });
                                          print(loadProduct.isRating);
                                          ratingPost();
                                          Fluttertoast.showToast(
                                              msg: 'Note enregistré',
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.7),
                                              textColor: Colors.white,
                                              timeInSecForIosWeb: 3,
                                              toastLength: Toast.LENGTH_LONG,
                                              fontSize: 13);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          FontAwesomeIcons.thumbsDown,
                                          size: 15,
                                        ),
                                        onPressed: () {
                                          Fluttertoast.showToast(
                                              msg: 'Note enregistré',
                                              backgroundColor:
                                                  Colors.black.withOpacity(0.7),
                                              textColor: Colors.white,
                                              timeInSecForIosWeb: 3,
                                              toastLength: Toast.LENGTH_LONG,
                                              fontSize: 13);
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Aperçu',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        child: FutureBuilder<List>(
                          future: getData(),
                          builder: (ctx, ss) {
                            if (ss.hasError) {
                              print("Erreur");
                            }
                            if (ss.hasData) {
                              return Container(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: ss.data.length,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Image.network(
                                            'http://192.168.64.2/Projects/ncomic/uploadedImage/${ss.data[i]['fileName']}'),
                                      ),
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ImageViewer(
                                            image: ss.data[i]['fileName'],
                                            id: ss.data[i]['idImageBd'],
                                            length: ss.data.length,
                                          ),
                                        ));
                                      },
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Commentaire',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15,),
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white,
                        ),
                        child: Text('ghgdf'),
                      ),
                      // Container(
                      //   height: 500,
                      //   child: ListView(
                      //     children: [
                      //       for (var i = 0; i < 2; i++)
                      //         Container(
                      //           child: Row(
                      //             children: [
                      //               Container(
                      //                 margin: EdgeInsets.only(
                      //                     bottom: 20, left: 10, right: 10),
                      //                 height: 60,
                      //                 width: 60,
                      //                 color: Colors.grey,
                      //               ),
                      //               Container(
                      //                 child: Column(
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.center,
                      //                   children: [
                      //                     Text('Episode ${i + 1}'),
                      //                   ],
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String id;
  final String image;
  final int length;
  ImageViewer({this.image, this.id, this.length});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(
                  'http://192.168.64.2/Projects/ncomic/uploadedImage/$image'),
              initialScale: PhotoViewComputedScale.contained * 1,
              heroAttributes: PhotoViewHeroAttributes(tag: id),
            );
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
