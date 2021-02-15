import 'package:flutter/material.dart';
import 'package:ncomics/providers/download_provider.dart';
import 'package:provider/provider.dart';

class MyComics extends StatefulWidget {
  @override
  _MyComicsState createState() => _MyComicsState();
}

class _MyComicsState extends State<MyComics> {
  FileDownloaderProvider downloaderProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: GridView.builder(
          padding: const EdgeInsets.all(5.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 2.4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
          ),
          itemCount: 3,
          itemBuilder: (ctx, i) => Card(
            child: Card(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
