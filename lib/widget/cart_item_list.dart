import 'package:flutter/material.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemList extends StatefulWidget {
  final String productId;
  final String id;
  final String title;
  final double price;
  final int quantity;

  const CartItemList(
    this.productId,
    this.id,
    this.title,
    this.price,
    this.quantity,
  );

  @override
  _CartItemListState createState() => _CartItemListState();
}

class _CartItemListState extends State<CartItemList> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(widget.productId),
      background: Container(
        padding: EdgeInsets.only(right: 22),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(
          widget.productId,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.black26,
            ),
          ),
        ),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(Icons.delete_forever, color: Colors.orange[900],),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("❌ Suppression"),
                  content: Text(
                      'Etes-vous sûr de vouloir supprimer ${widget.title}'),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(false);
                      },
                      child: Text(
                        'Non',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop(true);

                        Provider.of<Cart>(context, listen: false).removeItem(
                          widget.productId,
                        );
                      },
                      child: Text('Oui'),
                    ),
                  ],
                ),
              );
            },
          ),
          title: Text(widget.title),
          subtitle: Text('prix : ${widget.price * widget.quantity}'),
          leading: Chip(
            label: Text(
              '${widget.price}',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(
              context,
            ).primaryColor,
          ),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("❌ Suppression"),
            content: Text('Etes-vous sûr de vouloir supprimer ${widget.title}'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text(
                  'Non',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('Oui'),
              ),
            ],
          ),
        );
      },
    );
  }
}
