import 'package:flutter/material.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String userPt = '';
  String userNam = '';
  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('username', null);
    prefs.setString('userpoint', null);
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    // setState(() {
    //   name = '';
    //   isLoggedIn = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    getUserInfos();
  }

  void getUserInfos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    if (userPoint != null) {
      print(userPoint);
      print(userName);
      setState(() {
        userPt = userPoint;
        userNam = userName;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Text(
              //       'Mon profil',
              //       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    child: Text('Image'),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(userNam),
                      subtitle: Text('$userPt points'),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                title: Text('Mes achats'),
                subtitle: Text('...'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
             
              Divider(),
              ListTile(
                title: Text('Username'),
                subtitle: Text('...'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Divider(),
              ListTile(
                title: Text('Paramètres'),
                subtitle: Text('...'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    color: Theme.of(context).errorColor,
                    child: Text(
                      'Deconnexion',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: StadiumBorder(),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Confirmez'),
                          content: Text('Vous allez vous deconnecter !'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text('Non'),
                            ),
                            FlatButton(
                              onPressed: () {
                                logout();
                              },
                              child: Text('oui'),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

// void _showProfilModel(String name, Function logout, bool isEditing) {
//     showModalBottomSheet(
//       context: context,
//       builder: (contex) {
//         return Scaffold(
//           backgroundColor: Color.fromRGBO(255, 254, 229, 1),
//           body: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   height: 160,
//                   width: double.infinity,
//                   color: Color(0xFF0A161C),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           CircleAvatar(
//                             radius: 60,
//                             child: Icon(
//                               Icons.person_outline_rounded,
//                               size: 70,
//                             ),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 name,
//                                 style: TextStyle(
//                                     fontSize: 40, color: Colors.yellow),
//                               ),

//                               Text(
//                                 point + ' points',
//                                 style: TextStyle(
//                                     fontSize: 30,
//                                     color: Colors.yellow,
//                                     fontWeight: FontWeight.w100),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ListTile(
//                       trailing: Text(
//                         'Deconnexion',
//                         style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue),
//                       ),
//                       onTap: () {
//                         print('yesss');
//                         setState(() {
//                           isEditing = !isEditing;
//                         });
//                       },
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     ListTile(
//                       leading: Icon(Icons.lock),
//                       title: Text('Mot de passe'),
//                       subtitle: Text('*******'),
//                       trailing: IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {},
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     RaisedButton.icon(
//                       elevation: 10,
//                       onPressed: () {
//                         Navigator.pushNamed(context, AddPoints.routeName);
//                       },
//                       icon: Icon(Icons.add, color: Colors.white,),
//                       label: Text('Ajouter des points', style: TextStyle(color: Colors.white),),
//                       color: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20)),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//       isScrollControlled: false,
//     );
//   }
//
}
