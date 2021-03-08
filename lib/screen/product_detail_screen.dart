import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';

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
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadProduct = Provider.of<BdProvider>(context, listen: false)
        .listbd
        .firstWhere((element) => element.idBd == productId);
    print(productId);
    Future<List> getData() async {
      final res = await http.get(
          "http://bad-event.com/ncomic/dataHandling/getImageBd.php?idBd=$productId");
      return json.decode(res.body);
    }

    Future<List> ratingPost() async {
      final resp = await http.post(
          'http://bad-event.com/ncomic/dataHandling/addRating.php',
          body: {
            'idBd': idBd,
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 35),
        child: AppBar(),
      ),
      body: Hero(
        tag: 'Bd-${loadProduct.idBd}',
        transitionOnUserGestures: true,
        child: Container(
          //color: Colors.black,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  'http://bad-event.com/ncomic/uploads/${loadProduct.imageBd}',
                ),
                alignment: Alignment.topCenter),
          ),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.black.withOpacity(0.3),
                            height: MediaQuery.of(context).size.height * 0.40,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  width: double.infinity,
                                  // padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                          if (loadProduct.resumeBd != null)
                            if (loadProduct.resumeBd != null)
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                color: Colors.white,
                                width: double.infinity,
                                child: Text(
                                  loadProduct.resumeBd,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.brown,
                                  ),
                                ),
                              ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Aperçu',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200,
                            color: Colors.white,
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
                                                'http://bad-event.com/ncomic/uploadedImage/${ss.data[i]['fileName']}'),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                  appBar: AppBar(
                                                    backgroundColor:
                                                        Colors.black,
                                                    elevation: 0.0,
                                                  ),
                                                  body:
                                                      PhotoViewGallery.builder(
                                                    loadingBuilder: (context,
                                                            event) =>
                                                        CircularProgressIndicator(),
                                                    scrollPhysics:
                                                        const BouncingScrollPhysics(),
                                                    builder:
                                                        (BuildContext context,
                                                            int index) {
                                                      return PhotoViewGalleryPageOptions(
                                                        imageProvider: NetworkImage(
                                                            'http://bad-event.com/ncomic/uploadedImage/${ss.data[index]['fileName']}'),
                                                        initialScale:
                                                            PhotoViewComputedScale
                                                                    .contained *
                                                                1,
                                                        minScale:
                                                            PhotoViewComputedScale
                                                                    .contained *
                                                                1,
                                                        maxScale:
                                                            PhotoViewComputedScale
                                                                    .covered *
                                                                2,
                                                        heroAttributes:
                                                            PhotoViewHeroAttributes(
                                                          tag: index,
                                                        ),
                                                      );
                                                    },
                                                    itemCount: ss.data.length,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            height: 700,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
