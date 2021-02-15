import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/widget/badge.dart';
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
    print('bd detail screen');
    final productId =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final idBd = productId['idBd'];
    final imageBd = productId['imageBd'];
    final titleBd = productId['titleBd'];
    final prixBd = productId['prixBd'];

    Future<List> getData() async {
      final res = await http.get(
          "http://192.168.64.2/Projects/ncomic/dataHandling/getImageBd.php?idBd=$idBd");
      return json.decode(res.body);
    }

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0.0,
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'http://192.168.64.2/Projects/ncomic/uploads/$imageBd'),
                fit: BoxFit.cover,
              )),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 40, 40, 10),
                    width: double.infinity,
                    height: 400,
                    color: Colors.black.withOpacity(0.2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 29,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              '$titleBd',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 40,
                              ),
                            ),
                            Spacer(),
                            Chip(
                              label: Text(
                                'FR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              backgroundColor: Colors.black.withOpacity(0.2),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            '$prixBd points',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer<Cart>(
                    builder: (context, cart, _) {
                      return RaisedButton(
                        child: Text('Ajouter au panier',
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
                              backgroundColor: Colors.black.withOpacity(0.8),
                              action: SnackBarAction(
                                label: 'Annuler',
                                onPressed: () {
                                  cart.removeSingleItem(idBd);
                                },
                                textColor: Theme.of(context).errorColor,
                              ),
                            ),
                          );

                          cart.addItem(
                            idBd,
                            prixBd,
                            titleBd,
                            imageBd,
                          );
                        },
                      );
                    },
                  ),
                  Consumer<BandeDessinees>(
                    builder: (context, prd, child) => IconButton(
                      icon: Icon(prd.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline),
                      color: Colors.red,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Aperçu',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                          return Container(
                            padding: EdgeInsets.all(10),
                            child: Image.network(
                                'http://192.168.64.2/Projects/ncomic/uploadedImage/${ss.data[i]['fileName']}'),
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
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Épisodes',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        height: 60,
                        width: 60,
                        color: Colors.red,
                      ),
                      title: Text('Episode ${i + 1}'),
                    ),
                    Divider()
                  ],
                );
              },
              itemCount: 10,
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.withOpacity(0.7),
        child: Consumer<Cart>(
          builder: (context, cart, ch) => Badge(
            child: ch,
            value: cart.itemCount.toString(),
          ),
          child: IconButton(
            icon: Icon(
              Icons.add_shopping_cart_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(
                CartScreen.routeName,
              );
            },
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
