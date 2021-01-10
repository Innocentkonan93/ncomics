import 'package:flutter/material.dart';

class ShowIamge extends StatefulWidget {
  static const routeName = '/show-image';

  @override
  _ShowIamgeState createState() => _ShowIamgeState();
}

class _ShowIamgeState extends State<ShowIamge> {
  @override
  Widget build(BuildContext context) {
    final bdScreenRoute =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final imageUrl = bdScreenRoute['fileName'];

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 229, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Image.network(
              'http://192.168.64.2/Projects/ncomic/uploadedImage/$imageUrl',
            ),
            RaisedButton(
                onPressed: () {
                  // if (point != prixBd) {
                  //   print('acheter');
                  // }
                },
                child: Text(
                  'Acheter',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                color: Color(0xFF0A161C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 130, vertical: 15),
              ),
          ],
        ),
      ),
    );
  }
}
