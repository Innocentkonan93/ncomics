import 'package:flutter/material.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var d = Duration(seconds: 3);

  @override
  void initState() {
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }),
        (route) => false,
      );
    });
    //autoLogIn();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Center(
              child: Container(
                height: 185,
                child: Image.asset('assets/images/logo.JPG'),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
