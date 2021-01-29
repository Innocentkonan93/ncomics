import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/screen/add_point.dart';
import 'package:ncomics/widget/cart_item_list.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'card-screen';
  final bool close;
  CartScreen({this.close});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int userPt = 0;
  String userNam = '';

  void getUserInfos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    if (userPoint != null) {
      print(userPoint);
      print(userName);
      setState(() {
        userPt = int.parse(userPoint);
        userNam = userName;
      });
      return;
    }
  }

  void showD(BuildContext context) {
    showDialog(
        context: context,
        builder: (contxt) {
          return AlertDialog(
            title: Text(
              '⚠️ Points insuffisant',
              style: GoogleFonts.roboto(
                color: Theme.of(context).errorColor,
              ),
            ),
            content: Container(
              width: 200,
              height: 40,
              child: Text(
                  'Points sont insuffisant pour effectuer la transaction '),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('Annuler'),
              ),
              RaisedButton(
                color: Colors.green,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddPoints(),
                    ),
                  );
                },
                child: Text('Ajouter des points'),
              ),
            ],
            actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
          );
        });
  }

  @override
  void initState() {
    getUserInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Votre Panier'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Chip(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  label: Row(
                    children: [
                      Text('Solde :'),
                      Spacer(),
                      Text('$userPt', style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                            ),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Chip(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      label: Row(
                        children: [
                          Text('Total :'),
                          Spacer(),
                          Text(
                            cart.totalAmount.toString(),
                            style: GoogleFonts.quicksand(
                              fontSize: 16,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Acheter',
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    color: Theme.of(context).errorColor,
                    shape: StadiumBorder(),
                    onPressed: cart.items.length == 0 ? null : () {
                      if (cart.totalAmount > userPt) {
                        showD(context);
                      } else {
                        Provider.of<Orders>(context, listen: false).addOrder(
                          cart.items.values.toList(),
                          cart.totalAmount,
                        );
                        print(cart.totalAmount);
                        cart.clearCart();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) => CartItemList(
                    cart.items.keys.toList()[i],
                    cart.items.values.toList()[i].id,
                    cart.items.values.toList()[i].title,
                    cart.items.values.toList()[i].price,
                    cart.items.values.toList()[i].quantity,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.close),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
