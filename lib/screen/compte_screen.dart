import 'package:flutter/material.dart';
import 'package:ncomics/screen/profil_screen.dart';

class CompteScreen extends StatefulWidget {
  static const routeName = 'compte-screen/';
  @override
  _CompteScreenState createState() => _CompteScreenState();
}

class _CompteScreenState extends State<CompteScreen> {
  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: _height * 0.1,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            decoration: BoxDecoration(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.monetization_on_outlined),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      '0',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Spacer(),
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        'Acheter',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.lightGreen[400],
                      elevation: 7,
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              decoration: BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.search,
                                  size: 25,
                                ),
                                Text(
                                  'Recherche',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 17,
                                    color: Colors.red[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      height: _height * 0.9,
                                      child: ProfilScreen(),
                                    );
                                  });
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.settings,
                                    size: 25,
                                  ),
                                  Text(
                                    'Paramètres',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      color: Colors.red[400],
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
