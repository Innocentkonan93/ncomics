import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/helper/bdhelper.dart';
import 'package:http/http.dart' as http;
import 'package:ncomics/helper/cathelper.dart';

import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/cat_provider.dart';
import 'package:ncomics/widget/category_list.dart';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: Duration(seconds: 10),
      ),
    );
  }

  _getBds() async {
    var provider = Provider.of<BdProvider>(context, listen: false);
    var response = await APIHelper.getBandeDessinees();
    if (response.isSuccesful) {
      provider.setBdList(response.data);
    } else {
      _showSnackbar(response.message, bgColor: Colors.red);
    }
    provider.setIsProcessing(false);
  }

  _getCategory() async {
    var provide = Provider.of<CatProvider>(context, listen: false);
    var resp = await CATHelpler.getCategory();
    if (resp.isSuccesful) {
      provide.setCategoryList(resp.data);
    } else {
      //_showSnackbar(resp.message);
    }
    provide.setIsProcessing(false);
  }

  Future<List> getCat() async {
    final res = await http.get(
        "http://bad-event.com/ncomic/dataHandling/getCategory.php");
    return json.decode(res.body);
  }

  @override
  void initState() {
    _getBds();
    _getCategory();
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
                    style: GoogleFonts.comfortaa(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
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
                    style: GoogleFonts.comfortaa(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Consumer<CatProvider>(
                  builder: (context, catPrvider, child) {
                    return catPrvider.isProcessing
                        ? CircularProgressIndicator()
                        : CategoryList();
                  },
                ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommandations',
                    style: GoogleFonts.comfortaa(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: !isGrid
                        ? Icon(
                            Icons.grid_view,
                            size: 22,
                            color: Theme.of(context).errorColor,
                          )
                        : Icon(
                            Icons.view_list,
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
