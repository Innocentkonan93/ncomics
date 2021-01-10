import 'package:flutter/material.dart';

import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/categories.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/screen/add_point.dart';
import 'package:ncomics/screen/bd_screen.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:ncomics/screen/orders_screen.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:ncomics/screen/show_image.dart';
import 'package:ncomics/screen/splash_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:ncomics/widget/categorie_list_item.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider.value(
          value: BandeDessinees(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Categories(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
      child: MaterialApp(
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
          ShowIamge.routeName: (ctx) => ShowIamge(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          TabScreen.routeName: (ctx) => TabScreen(),

        },
      ),
    );
  }
}
