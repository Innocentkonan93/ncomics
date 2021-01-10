import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ncomics/helper/bdhelper.dart';
import 'package:http/http.dart' as http;

import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/cat_provider.dart';
import 'package:ncomics/widget/categorie_list_item.dart';

import 'package:ncomics/widget/products_grid.dart';
import 'package:ncomics/widget/slider_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String point = '';
  bool isGrid = true;

  _showSnackbar(String message, {Color bgColor}) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
      ),
    );
  }

  _getBds() async {
    var provider = Provider.of<BdProvider>(context, listen: false);
    var response = await APIHelper.getBandeDessinees();
    if (response.isSuccesful) {
      provider.setBdList(response.data);
    } else {
      _showSnackbar(response.message);
    }
    provider.setIsProcessing(false);
  }

  Future<List> getCat() async {
    final res = await http.get(
        "http://192.168.64.2/Projects/ncomic/dataHandling/getCategory.php");
    return json.decode(res.body);
  }

  @override
  void initState() {
    _getBds();
    //_getCategory();
    autoLogIn();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    if (userPoint != null) {
      print(userPoint);
      setState(() {
        point = userPoint;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Text(
                    'Nouveautés',
                    style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
              ],
            ),
            Consumer<BdProvider>(
              builder: (_, image, ___) => SliderItem(),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: FutureBuilder<List>(
                future: getCat(),
                builder: (ctx, ss) {
                  if (ss.hasError) {
                    print("Erreur");
                  }
                  if (ss.hasData) {
                    return GestureDetector(
                      // onTap: () {
                      //   Navigator.pushNamed(
                      //     context,
                      //     routeName,
                      //   );
                      // },
                      child: Container(
                        height: 40,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: ss.data.length,
                          itemBuilder: (context, i) {
                            return CategorieListItem(ss.data[i]['categories']);
                          },
                        ),
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommandations',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: !isGrid
                        ? Icon(
                            Icons.apps_rounded,
                            size: 25,
                            color: Theme.of(context).errorColor,
                          )
                        : Icon(
                            Icons.list,
                            size: 25,
                            color: Theme.of(context).errorColor,
                          ),
                    onPressed: () {
                      setState(() {
                        isGrid = !isGrid;
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 500,
              child: Consumer<BdProvider>(
                builder: (_, bdProvider, __) {
                  return bdProvider.isProcessing
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ProductsGrid(isGrid);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
