import 'package:flutter/material.dart';

class AddPoints extends StatefulWidget {
  static const routeName = '/add-point';
  @override
  _AddPointsState createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 229, 1),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white)
              ),
              child: FittedBox(
                child: Row(
                  children: [
                    Text(
                      '200 points /',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    Text(
                      ' 1000 francs CFA',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
