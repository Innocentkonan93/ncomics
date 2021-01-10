import 'package:flutter/material.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/providers/cart.dart';
import 'package:ncomics/screen/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductGridItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductGridItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<BandeDessinees>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          
        ]),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              print(product.idBd);

              Navigator.of(context).pushNamed(
                ProductDetailScreen.routeName,
                arguments: {
                  'idBd': product.idBd,
                  'titleBd': product.titleBd,
                  'prixBd': product.prixBd,
                  'imageBd': product.imageBd,
                },
              );
            },
            child: Image.network(
              'http://192.168.64.2/Projects/ncomic/uploads/${product.imageBd}',
              fit: BoxFit.cover,
            ),
          ),
          footer: Container(
            height: 45,
            child: GridTileBar(
              // leading: IconButton(
              //   icon: product.isFavorite
              // ? Icon(Icons.favorite)
              //       : Icon(Icons.favorite_outline),
              //   onPressed: () {
              //     product.favoriteToggle();
              //   },
              // ),
              backgroundColor: Colors.black87.withOpacity(0.4),
              title: Text(
                product.titleBd,
                textAlign: TextAlign.center,
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_bag,
                    size: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Scaffold.of(context).hideCurrentSnackBar();
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produit ajouté'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.black.withOpacity(0.8),
                        action: SnackBarAction(
                          label: 'Annuler',
                          onPressed: () {
                            cart.removeSingleItem(product.idBd);
                          },
                          textColor: Theme.of(context).errorColor,
                        ),
                      ),
                    );

                    cart.addItem(
                      product.idBd,
                      product.prixBd,
                      product.titleBd,
                    );
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
