import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ncomics/screen/show_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BdScreen extends StatefulWidget {
  static const routeName = '/bd-screen';

  @override
  _BdScreenState createState() => _BdScreenState();
}

class _BdScreenState extends State<BdScreen> {
  String name = '';
  String point = '';
  bool isLoggedIn = false;

  @override
  void initState() {
    autoLogIn();
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');

    if (userPoint != null) {
      print(userPoint + 'ok');
      print(userName + 'ok');
      setState(() {
        isLoggedIn = true;
        point = userPoint;
        name = userName;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bandeDessinee =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final id = bandeDessinee['idBd'];
    final titleBd = bandeDessinee['titleBd'];
    final imageBd = bandeDessinee['imageBd'];
    final prixBd = bandeDessinee['prixBd'];
    final statutBd = bandeDessinee['statutBd'];

    Future<List> getData() async {
      final res = await http.get(
          "http://192.168.64.2/Projects/ncomic/dataHandling/getImageBd.php?idBd=$id");
      return json.decode(res.body);
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 254, 229, 1),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (ctx, ss) {
          if (ss.hasError) {
            print("Erreur");
          }
          if (ss.hasData) {
            return Container(
              child: Items(
                list: ss.data,
                imageBd: imageBd,
                titleBd: titleBd,
                prixBd: prixBd,
                statutBd: statutBd,
                point: point,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class Items extends StatelessWidget {
  List list;
  String imageBd;
  String titleBd;
  String prixBd;
  String statutBd;
  String point;
  Items({
    this.list,
    this.imageBd,
    this.prixBd,
    this.statutBd,
    this.titleBd,
    this.point,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(
            color: Colors.yellow, //change your color here
          ),
          expandedHeight: 100,
          backgroundColor: Color(0xFF0A161C),
          brightness: Brightness.dark,
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              color: Color(0xFF0A161C).withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      titleBd,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            background: Image.network(
              'http://192.168.64.2/Projects/ncomic/uploads/${imageBd}',
              fit: BoxFit.cover,
            ),
          ),
          pinned: true,
        ),
        SliverFillRemaining(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                elevation: 15,
                onPressed: () {
                  if (point != prixBd) {
                    print('acheter');
                  }
                },
                child: Text(
                  '$prixBd points',
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
              SizedBox(
                height: 10,
              ),
              Container(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, ShowIamge.routeName,
                        //     arguments: {
                        //       'fileName': list[i]['fileName'],
                        //       'prixBd': list[i]['prixBd'],
                        //     });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 0, 10),
                        height: 300,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: NetworkImage(
                              'http://192.168.64.2/Projects/ncomic/uploadedImage/${list[i]['fileName']}',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: list.length,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
