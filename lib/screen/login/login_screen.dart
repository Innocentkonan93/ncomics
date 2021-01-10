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
  var _isLogin = true;
  bool isLoggedIn = false;
  String name = '';
  String idUser = '';
  String pointUser = '';
  String message = '';
  final _formKey = GlobalKey<FormState>();


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
      print(userPoint);
      print(userName);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return TabScreen();
      }));

      return;
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', null);

    setState(() {
      name = '';
      isLoggedIn = false;
    });
  }

  Future<List> loginUser() async {
    if (_formKey.currentState.validate()) {
      final response = await http.post(
          'http://192.168.64.2/Projects/ncomic/dataHandling/loginUsers.php',
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

        setState(() {
          name = dataUser[0]['nomUser'];
          pointUser = dataUser[0]['pointUser'];
          idUser = dataUser[0]['idUser'];
          isLoggedIn = true;
          message = 'Connexion réussie';
        });

        print(idUser);
        print(name);
        print(pointUser);

        Navigator.of(context).pushReplacementNamed(TabScreen.routeName);

        _nameController.clear();
        _numberController.clear();
        _passwordController.clear();
      } else {
        setState(() {
          message = 'Identifiants incorrects';
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
        'http://192.168.64.2/Projects/ncomic/dataHandling/addUsers.php',
        body: {
          'nomUser': _nameController.text,
          'numUser': _numberController.text,
          'passUser': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        message = 'Connexion réussie';
        Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print(response);
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
          child: SafeArea(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.06),
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
                            child: textForm('Password', 'Mot de passe court',
                                'passWord', _passwordController,
                                password: true)),
                        SizedBox(
                          height: 20,
                        ),

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).errorColor,
                                onPressed: () {
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
                                style: GoogleFonts.comfortaa(color: Colors.white),
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
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text(
                          'CGV',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
              ],
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