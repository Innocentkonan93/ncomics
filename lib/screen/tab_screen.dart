import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/cart_screen.dart';
import 'package:ncomics/screen/myComics_screen.dart';

import 'package:ncomics/screen/home_screen.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:ncomics/screen/product_detail_screen.dart';

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
      {'page': CartScreen(), 'title': 'Panier'},
      {'page': MyComics(), 'title': 'Mes BD'},
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
              FontAwesomeIcons.search,
              size: 17,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
              // setState(() {
              //   searched = !searched;
              // });
            },
          ),
        ],
      ),
      body: _page[_selectedPageIndex]['page'],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black, width: 0.09))),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                size: 20,
              ),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Consumer<Cart>(
                builder: (context, cart, ch) => Badge(
                  child: ch,
                  value: cart.itemCount.toString(),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  size: 24,
                ),
              ),
              label: 'Panier',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.book,
                size: 20,
              ),
              label: 'Mes BD',
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
          unselectedLabelStyle: GoogleFonts.comfortaa(),
          selectedLabelStyle: GoogleFonts.comfortaa(),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    final listBd = Provider.of<BdProvider>(context).listbd;
    final recentList = Provider.of<BdProvider>(context).listbd;
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final listBd = Provider.of<BdProvider>(context).listbd;
    final recentList = Provider.of<BdProvider>(context).listbd;
    final suggestionList = query.isEmpty
        ? recentList
        : listBd
            .where((element) => element.titleBd.toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: suggestionList[i].idBd,
            );
          },
          leading: Icon(Icons.book_outlined),
          title: RichText(
            text: TextSpan(
                text: suggestionList[i].titleBd.substring(0, query.length),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: suggestionList[i].titleBd.substring(query.length),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listBd = Provider.of<BdProvider>(context).listbd;
    final recentList = Provider.of<BdProvider>(context).listbd;
    final suggestionList = query.isEmpty
        ? recentList
        : listBd
            .where((element) => element.titleBd.toLowerCase().startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (ctx, i) {
        return ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: suggestionList[i].idBd,
            );
          },
          leading: Icon(
            Icons.book_outlined,
            color: Colors.black,
          ),
          title: RichText(
            text: TextSpan(
                text: suggestionList[i].titleBd.substring(0, query.length),
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: suggestionList[i].titleBd.substring(query.length),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  )
                ]),
          ),
        );
      },
    );
  }
}

// final productsData = Provider.of<BdProvider>(context);
//     final products = productsData.listbd;

//     final producths = productsData.listbd
//         .where((element) => element.titleBd.contains(query))
//         .toList();

//     return ListView.builder(
//       itemCount: producths.length,
//       itemBuilder: (context, index) => ListTile(
//         title: GestureDetector(
//           onTap: () {
//             Navigator.pushNamed(
//               context,
//               ProductDetailScreen.routeName,
//               arguments: products[index].idBd,
//             );
//           },
//           child: Text(products[index].titleBd),
//         ),
//       ),
//     );
