import 'package:flutter/material.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItemList extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(IconDataProperty),
      background: Container(
        padding: EdgeInsets.only(right: 22),
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          width: 1,
          color: Colors.black26,
        ))),
        child: ListTile(
          leading: Chip(
            label: Text(
              '$price',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(
              context,
            ).primaryColor,
          ),
          title: Text(title),
          subtitle: Text('Total : ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Confirmez'),
            content: Text('Etes-vous sûr de vouloir supprimer $title'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text('Non'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: Text('oui'),
              ),
            ],
          ),
        );
      },
    );
  }
}
