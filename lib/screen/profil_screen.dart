import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/edit_user_info.dart';

class ProfilScreen extends StatefulWidget {
  static const routeName = 'profil-screen';
  @override
  _ProfilScreenState createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String userId = '';
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
    setState(() {});
  }

  void getUserInfos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userID = prefs.getString('userid');
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    final String userNaissance = prefs.getString('usernaissance');
    final String userMail = prefs.getString('emailUser');
    final String userNum = prefs.getString('usernumber');
    if (userPoint != null) {
      print(userPoint);
      print(userName);
      print('user ID: $userID');
      setState(() {
        userId = userID;
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    //Navigator.pushNamedAndRemoveUntil(context, '/calendar', ModalRoute.withName('/'));
    // setState(() {
    //   name = '';
    //   isLoggedIn = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.red.withOpacity(0.02),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
                      radius: 55,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.3,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Profil',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  profilItem(
                    'Votre nom',
                    subTitle: userNam,
                  ),
                  profilItem(
                    'Votre email',
                    subTitle: userEmail == null ? 'Non renseignée' : userEmail,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.only(top: 24),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.3,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      'Compte',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  profilItemWithIcon(
                    'Solde',
                    Icons.payment_rounded,
                    subTitle: userPt,
                  ),
                  profilItemWithIcon(
                    'Mot de passe',
                    Icons.lock,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPassWord(userId),
                        ),
                      );
                    },
                    subTitle: '*********',
                    trailing: Icons.arrow_forward_ios,
                  ),
                  profilItemWithIcon(
                    'Email',
                    Icons.mail,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditEmail(userId),
                        ),
                      );
                      print(userId);
                    },
                    subTitle: '',
                    trailing: Icons.arrow_forward_ios,
                  ),
                  profilItemWithIcon(
                    'Numero',
                    Icons.call,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditNumber(userId),
                        ),
                      );
                    },
                    subTitle: userNumb,
                    trailing: Icons.arrow_forward_ios,
                  ),
                  profilItemWithIcon(
                    'Deconnexion',
                    Icons.lock_open_outlined,
                    //trailing: Icons.arrow_right,
                    subTitle: '',
                    onTap: () {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  profilItem(
    String title, {
    String subTitle,
    Function onTap,
    IconData icon,
    Widget trailing,
    Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 0.3,
            color: Colors.black.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
          ),
          Text(
            subTitle,
            style: GoogleFonts.quicksand(),
          ),
        ],
      ),
    );
  }

  profilItemWithIcon(
    String title,
    IconData icon, {
    Function onTap,
    String subTitle,
    IconData trailing,
    Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 0.3,
              color: Colors.black.withOpacity(0.3),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.grey[600],
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: GoogleFonts.quicksand(fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Text(subTitle, style: GoogleFonts.quicksand(fontSize: 16)),
            SizedBox(
              width: 5,
            ),
            Icon(
              trailing,
              size: 14,
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
