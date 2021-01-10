import 'package:flutter/material.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/widget/cart_item_list.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  static const routeName = 'card-screen';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Votre Panier'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(children: [
                
              ],),
              Row(
                children: [
                  Text(
                    'Mon panier',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:'),
                  Chip(
                    label: Text(cart.totalAmount.toString()),
                  ),
                  FlatButton(
                    child: Text('Acheter'),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      print(cart.totalAmount);
                      cart.clearCart();
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
