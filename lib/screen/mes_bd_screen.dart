import 'package:flutter/material.dart';
import 'package:ncomics/providers/bd_provider.dart';
import 'package:ncomics/screen/read_bd_screen.dart';
import 'package:provider/provider.dart';

class MesBdScreen extends StatefulWidget {
  @override
  _MesBdScreenState createState() => _MesBdScreenState();
}

class _MesBdScreenState extends State<MesBdScreen> {
  @override
  Widget build(BuildContext context) {
    final bdData = Provider.of<BdProvider>(context).listbd;
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
        ),
        itemCount: bdData.length,
        itemBuilder: (ctx, i) => Card(
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ReadBdScreen.routeName,
                arguments: bdData[i].idBd,
              );
            },
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: Image.network(
                  'http://bad-event.com/ncomic/uploads/${bdData[i].imageBd}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
