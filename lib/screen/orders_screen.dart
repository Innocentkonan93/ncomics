import 'package:flutter/material.dart';
import 'package:ncomics/providers/orders.dart';
import 'package:ncomics/widget/appDrawer.dart';
import 'package:ncomics/widget/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/order-screen';
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: orderData.orders.isNotEmpty
          ? ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, i) => OrderListItem(orderData.orders[i]),
            )
          : Center(
            child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Aucun achat effectué'),
                ],
              ),
          ),
    );
  }
}
