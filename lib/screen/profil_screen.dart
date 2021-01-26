import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilScreen extends StatefulWidget {
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
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


  void showModal() {
    bool edit = false;
    showModalBottomSheet<void>(

      isDismissible: true,
      context: (context),
      builder: (context) {
        return SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 3,
                        width: 100,
                        color: Colors.black12,
                      ),
                      color: Colors.transparent,
                      elevation: 0.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          edit = !edit;
                        });
                      },
                      child: Text('Modifier'),
                    )
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              Divider(),
              ListTile(
                title: Text(
                  'Mes informations',
                  style: GoogleFonts.comfortaa(fontSize: 22),
                ),
              ),

              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(0.7),
                  child: Icon(Icons.person),
                ),
                title: Text(
                  userNam == null ? 'Non renseignée': userNam 
                ),
                trailing: Icon(Icons.edit),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(0.7),
                  child: Icon(Icons.mail),
                ),
                title: Text(userEmail == null ? 'Non renseignée': userEmail),
                trailing: Icon(Icons.edit),
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red.withOpacity(0.7),
                  child: Icon(Icons.tag),
                ),
                title: Text(userNumb.toString()),
                trailing: Icon(Icons.edit),
              ),
              Divider(),
              ListTile(
                title: Text('Paramètres'),
                // subtitle: Text('...'),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
                onTap: showModal,
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
}
