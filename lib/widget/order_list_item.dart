import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ncomics/providers/orders.dart';
import 'dart:math';

class OrderListItem extends StatefulWidget {
  final OrderItem order;

  OrderListItem(this.order);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('${widget.order.amount}'),
            subtitle: Text(
                DateFormat('dd MM yyyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
            ),
          ),
          if (isExpanded) Divider(),
          if (isExpanded)
            Container(
              color: Colors.blue.withOpacity(0.12),
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: min(widget.order.products.length * 20.0 + 10, 180),
              child: ListView(
                children: widget.order.products
                    .map(
                      (prod) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            prod.title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${prod.quantity} x ${prod.price}',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      ),
                    )
                    .toList(),
              ),
            )
        ],
      ),
    );
  }
}
