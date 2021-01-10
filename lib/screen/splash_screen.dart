
import 'package:flutter/material.dart';
import 'package:ncomics/screen/login/login_screen.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var d = Duration(seconds: 2);
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) {
          return LoginScreen();
        }),
        (route) => false,
      );
    });
    super.initState();
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
              child:  Container(
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