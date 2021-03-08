import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/cat_provider.dart';
import 'package:ncomics/providers/download_provider.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/screen/add_point.dart';
import 'package:ncomics/screen/by_category_screen.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:ncomics/screen/orders_screen.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:ncomics/screen/profil_screen.dart';
import 'package:ncomics/screen/splash_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:ncomics/widget/slider_item.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BdProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BandeDessinees(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: FileDownloaderProvider(),
        )
      ],
      child: MaterialApp(
        builder: EasyLoading.init(),
        debugShowCheckedModeBanner: false,
        title: 'Ncomis',
        theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.black,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (ctx) => SplashScreen(),
          AddPoints.routeName: (ctx) => AddPoints(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          TabScreen.routeName: (ctx) => TabScreen(),
          ByCategroyScreen.routeName: (ctx) => ByCategroyScreen(),
          ProfilScreen.routeName: (ctx) => ProfilScreen(),
        },
        //
      ),
    );
  }
}

class NewAcc extends StatefulWidget {
  @override
  _NewAccState createState() => _NewAccState();
}

class _NewAccState extends State<NewAcc> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //height: MediaQuery.of(context).size.height,
        color: Colors.black26,
        child: Column(
          children: [
            SizedBox(
              height: 33,
            ),
            SliderItem(),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.26,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.5,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 130,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: double.infinity,
                            child: ClipRRect(
                              child: Image.asset(
                                'assets/images/1.png',
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text('product[i].titleBd'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Categorie'),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.5,
                                      color: Colors.grey.shade300,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 5,
                                  ),
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Ajouter'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 6,
                ),
              ),
            ),
            SizedBox(
              height: 0,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 130,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/1.png',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text('product[i].titleBd'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Categorie'),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Ajouter'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: 6,
                  )),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 130,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/1.png',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text('product[i].titleBd'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Categorie'),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Ajouter'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: 6,
                  )),
            ),
            SizedBox(
              height: 6,
            ),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(
                  padding: EdgeInsets.all(16),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: 130,
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              width: double.infinity,
                              child: ClipRRect(
                                child: Image.asset(
                                  'assets/images/1.png',
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text('product[i].titleBd'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Categorie'),
                                    ],
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade300,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 5,
                                    ),
                                    width: double.infinity,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Ajouter'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    itemCount: 6,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
