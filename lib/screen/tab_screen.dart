import 'package:flutter/material.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/screen/favory_screen.dart';
import 'package:ncomics/screen/home_screen.dart';
import 'package:ncomics/screen/login/login_screen.dart';

import 'package:ncomics/screen/profil_screen.dart';
import 'package:ncomics/widget/appDrawer.dart';
import 'package:ncomics/widget/badge.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabScreen extends StatefulWidget {
  static const routeName = '/orders';
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _page;
  int _selectedPageIndex = 0;
  bool searched = false;
  bool isEditing = false;
  bool close = false;

  String name;
  String point;
  @override
  void initState() {
    _page = [
      {'page': HomeScreen(), 'title': 'Accueil'},
      //{'page': FavoryScreen(), 'title': 'Favoris'},
      {'page': CartScreen(), 'title': 'Panier'},
      {'page': ProfilScreen(), 'title': 'Profil'},
    ];

    autoLogIn();

    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');

    if (userPoint != null) {
      setState(() {
        isEditing = true;
        point = userPoint;
        name = userName;
      });
      return;
    }
  }

  //

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );

    setState(() {
      // name = '';
      // isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).errorColor,
        brightness: Brightness.light,
        title: Text(
          _page[_selectedPageIndex]['title'],
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                searched = !searched;
              });
            },
          ),
          // Consumer<Cart>(
          //   builder: (context, cart, ch) => Badge(
          //     child: ch,
          //     value: cart.itemCount.toString(),
          //   ),
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.shopping_bag,
          //       color: Theme.of(context).accentColor,
          //     ),
          //     onPressed: () {
          //       Navigator.of(context).pushNamed(
          //         CartScreen.routeName,
          //       );
          //     },
          //   ),
          // ),
        ],
        bottom: searched
            ? PreferredSize(
                child: Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    height: 37,
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.grey),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(17)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Recherchez',
                              hintStyle: TextStyle(),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        IconButton(
                          icon: Icon(Icons.search,
                              size: 26, color: Colors.grey.withOpacity(0.4)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                preferredSize: Size(double.infinity, 50),
              )
            : null,
      ),
      body: _page[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite),
          //   label: 'Favoris',
          // ),
          BottomNavigationBarItem(
            icon: Consumer<Cart>(
              builder: (context, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
              ),
              child: Icon(
                Icons.shopping_cart,
              ),
            ),
            label: 'Panier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profil',
          )
        ],
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        elevation: 90,
        selectedItemColor: Theme.of(context).errorColor,
        unselectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }
}
