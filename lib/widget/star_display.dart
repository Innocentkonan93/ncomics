import 'package:flutter/material.dart';

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay(this.value);
    
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: Row(
        children: List.generate(5, (index) {
          return Icon(
            index < value * 5 ~/100 ? Icons.star : Icons.star_border,
            size: 15,
            color: Colors.yellow,
          );
        }),
      ),
    );
  }
}