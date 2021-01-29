import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ncomics/screen/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //Confetti
  ConfettiController _confettiController;
  // TextEditingController _emailController = TextEditingController();

  var _isLogin = true;

  bool isLoggedIn = false;

  String message = '';
  String name = '';
  String idUser = '';
  String emailUser = '';
  String pointUser = '';
  String numUser = '';
  String paysUser = '';
  String naissanceUser = '';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    autoLogIn();
    _confettiController = ConfettiController(
      duration: Duration(seconds: 5),
    );
    super.initState();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userPoint = prefs.getString('userpoint');
    final String userName = prefs.getString('username');
    if (userPoint != null) {
      print(userPoint);
      print(userName);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return TabScreen();
      }));

      return;
    }
  }

  Future<List> loginUser() async {
    if (_formKey.currentState.validate()) {
      final response = await http.post(
          'http://bad-event.com/ncomic/dataHandling/loginUsers.php',
          body: {
            'numUser': _numberController.text,
            'passUser': _passwordController.text,
          });

      var dataUser = json.decode(response.body);

      if (dataUser.length == 1) {
        message = 'Connexion réussie';
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', dataUser[0]['nomUser']);

        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('userpoint', dataUser[0]['pointUser']);

        final SharedPreferences pref2 = await SharedPreferences.getInstance();
        pref2.setString('userid', dataUser[0]['idUser']);
        final SharedPreferences pref3 = await SharedPreferences.getInstance();

        pref3.setString('usernumber', dataUser[0]['numUser']);
        final SharedPreferences pref4 = await SharedPreferences.getInstance();

        pref4.setString('userpays', dataUser[0]['paysUser']);
        final SharedPreferences pref5 = await SharedPreferences.getInstance();

        pref5.setString('usernaissance', dataUser[0]['naissanceUSer']);
        final SharedPreferences pref6 = await SharedPreferences.getInstance();

        pref6.setString('emailUser', dataUser[0]['emailUser']);

        setState(() {
          name = dataUser[0]['nomUser'];
          pointUser = dataUser[0]['pointUser'];
          idUser = dataUser[0]['idUser'];
          numUser = dataUser[0]['numUser'];
          paysUser = dataUser[0]['paysUser'];
          naissanceUser = dataUser[0]['naissanceUser'];
          emailUser = dataUser[0]['emailUser'];
          message = 'Connexion réussie';
          isLoggedIn = true;
        });
        print(idUser);
        print(name);
        print(pointUser);
        print(numUser);
        print(paysUser);
        print(naissanceUser);
        print(emailUser);
        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);
        _nameController.clear();
        _numberController.clear();
        _passwordController.clear();
      } else {
        setState(() {
          message = 'Identifiants incorrects';
          isLoggedIn = false;
        });
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  void addUser() async {
    if (_formKey.currentState.validate()) {
      final response = await http.post(
        'http://bad-event.com/ncomic/dataHandling/addUsers.php',
        body: {
          'nomUser': _nameController.text,
          'numUser': _numberController.text,
          'passUser': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        message = 'Inscription réussie';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              shape: RoundedRectangleBorder(),
              content: Text(
                'Félicitation ! Inscription Réussie',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              backgroundColor: Colors.green),
        );
        print(response);
        _confettiController.play();
      }
      _nameController.clear();
      _numberController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.3),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.3),
        child: SingleChildScrollView(
          child: ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            numberOfParticles: 30,
            emissionFrequency: 0.05,
            shouldLoop: false,
            colors: [
              Colors.red,
              Colors.green,
              Colors.orangeAccent,
              Colors.yellowAccent,
            ],
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Container(
                          //   height: 180,
                          //   width: 180,
                          //   padding: EdgeInsets.all(15),
                          //   child: Image.asset(
                          //     'assets/images/logo.JPG',
                          //     height: 140,
                          //     width: 140,
                          //   ),
                          // ),

                          if (!_isLogin)
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).errorColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: EdgeInsets.only(bottom: 1),
                              child: Container(
                                  child: textForm(
                                'Name',
                                'Champ obligatoire',
                                'userName',
                                _nameController,
                              )),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).errorColor,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              padding: EdgeInsets.only(bottom: 1),
                              child: textForm(
                                'Phone number',
                                'Numero incorrect',
                                'phoneNum',
                                _numberController,
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // height: 50,
                            decoration: BoxDecoration(
                              color: Theme.of(context).errorColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            padding: EdgeInsets.only(bottom: 1),
                            child: textForm(
                              'Password',
                              'Mot de passe court',
                              'passWord',
                              _passwordController,
                              password: true,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          if (isLoggedIn == true)
                            Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          if (isLoggedIn == false)
                            Row(
                              children: [
                                Expanded(
                                  child: RaisedButton(
                                    color: Theme.of(context).errorColor,
                                    onPressed: () {
                                      setState(() {
                                        isLoggedIn = true;
                                      });
                                      _isLogin ? loginUser() : addUser();
                                    },
                                    child: Text(
                                      _isLogin ? 'Connexion' : 'Inscription',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(15),
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            message,
                          ),
                          Column(
                            children: [
                              FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLogin = !_isLogin;
                                  });
                                },
                                child: Text(
                                  !_isLogin
                                      ? 'Déjà un compte ?'
                                      : 'Créer un compte',
                                  style: GoogleFonts.comfortaa(
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.10,
                  ),
                  if (!_isLogin)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            'CGU',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container();
                              },
                            );
                          },
                        ),
                        FlatButton(
                          child: Text(
                            'CGV',
                            style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return Container();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textForm(
    String hintText,
    String errorText,
    String keyText,
    TextEditingController controller, {
    bool password = false ?? true,
  }) {
    return Container(
      child: Container(
        child: TextFormField(
          decoration: InputDecoration(
              errorStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
              filled: true,
              fillColor: Colors.white,
              hintText: hintText,
              hintStyle: GoogleFonts.comfortaa()),
          validator: (value) {
            if (value.isEmpty || value.length < 5) {
              return errorText;
            }
            return null;
          },
          controller: controller,
          key: ValueKey(keyText),
          obscureText: password,
        ),
      ),
    );
  }
}
