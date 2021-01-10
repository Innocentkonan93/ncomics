import 'package:flutter/material.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/screen/orders_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: true,
            title: Text('Votre menu'),
          ),

          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pushReplacementNamed(context, TabScreen.routeName);
            },
          ),

          Consumer<Orders>(
            builder: (context, orders, child) =>  ListTile(
              leading: Icon(Icons.payment),
              title: Text('Vos achats (${orders.orders.length.toString()})'),
              // subtitle: Text('${orders.orders.length.toString()}'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
