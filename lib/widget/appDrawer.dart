import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/screen/add_point.dart';

import 'package:ncomics/screen/orders_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String userPt = '';
  String userNam = '';

  void getUserInfos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    if (userPoint != null) {
      setState(() {
        userPt = userPoint;
        userNam = userName;
      });
      return;
    }
  }

  @override
  void initState() {
    getUserInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            color: Theme.of(context).errorColor,
            child: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'NComics',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.comfortaa(
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_bag_outlined,
              size: 25,
              color: Theme.of(context).errorColor,
            ),
            title: Text(
              'Accueil',
              style: GoogleFonts.comfortaa(
                  fontSize: 14, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, TabScreen.routeName);
            },
          ),
          Consumer<Orders>(
            builder: (context, orders, child) => ListTile(
              leading: Icon(
                Icons.payment,
                size: 23,
                color: Theme.of(context).errorColor,
              ),
              title: Text(
                'Vos BD (${orders.orders.length.toString()})',
                style: GoogleFonts.comfortaa(
                    fontSize: 14, fontWeight: FontWeight.bold),
              ),
              // subtitle: Text('${orders.orders.length.toString()}'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ),
          Spacer(),
          ListTile(
            leading: Icon(
              FontAwesomeIcons.wallet,
              size: 20,
              color: Theme.of(context).errorColor,
            ),
            title: Row(
              children: [
                Text(
                  'Soldes',
                  style: GoogleFonts.comfortaa(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  userPt + ' pt',
                  style: GoogleFonts.quicksand(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              Icons.add_circle_outline,
              color: Colors.green,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, AddPoints.routeName);
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
