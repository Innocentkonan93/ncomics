import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:provider/provider.dart';

class LikiesItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<BdProvider>(context).listbd;
    final productLikies = Provider.of<BdProvider>(context)
        .listbd
        .where((element) => element.isFavorite != null)
        .toList();

    return Container(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: productLikies.length == 0 ? 3 : productLikies.length,
        itemBuilder: (ctx, i) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              width: 130,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                        child: Image.asset(
                          'http://bad-event.com/ncomic/uploads/${product[i].imageBd}',
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(product[i].titleBd),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Categorie'),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 5,
                            ),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Ajouter'),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
