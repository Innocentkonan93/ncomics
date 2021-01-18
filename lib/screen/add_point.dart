import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/widget/appDrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AddPoints extends StatefulWidget {
  static const routeName = '/add-point';
  @override
  _AddPointsState createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  String userPt = '';
  String userNam = '';
  String userPays = '';
  String userNaiss = '';
  String userEmail = '';
  String userNumb = '';

  @override
  void initState() {
    super.initState();
    getUserInfos();
  }

  void getUserInfos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    final String userNaissance = prefs.getString('usernaissance');
    final String userMail = prefs.getString('emailUser');
    final String userNum = prefs.getString('usernumber');
    if (userPoint != null) {
      print(userPoint);
      print(userName);
      setState(() {
        userPt = userPoint;
        userNam = userName;
        userNaiss = userNaissance;
        userNam = userName;
        userEmail = userMail;
        userNumb = userNum;
      });
      return;
    }
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Impossible d'ouvrir le lien";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solde'),
        backgroundColor: Theme.of(context).errorColor,
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text(
                      'Solde Actuel : ',
                      style: TextStyle(fontSize: 19),
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '$userPt points',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Theme.of(context).errorColor),
                      ),
                    ),
                    child: Text(
                      'Ajouter des points',
                      style: GoogleFonts.comfortaa(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 400,
                child: CarouselSlider(
                  items: [
                    carousselItem('12', 500, Colors.purple),
                    carousselItem('12', 500, Colors.deepOrange),
                    carousselItem('12', 500, Colors.brown),
                  ],
                  options: CarouselOptions(
                    height: 300,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 10),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget carousselItem(String point, int prix, Color color) {
  return Card(
    elevation: 20,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.centerRight,
              colors: [color, color.withOpacity(0.4)])),
      width: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                point,
                style: GoogleFonts.robotoCondensed(
                  fontSize: 95,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'points',
                style: GoogleFonts.comfortaa(
                  color: Colors.white,
                  fontSize: 22,
                  // decoration: TextDecoration.underline
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                prix.toString() + ' Fr CFA',
                style: GoogleFonts.robotoCondensed(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () async {
              String telephoneUrl = "https://www.orange.ci";

              if (await canLaunch(telephoneUrl)) {
                await launch(telephoneUrl);
              } else {
                throw "Can't phone that number.";
              }
            },
            shape: StadiumBorder(),
            child: Text('Payer'),
          )
        ],
      ),
    ),
  );
}
