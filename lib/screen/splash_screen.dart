import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:ncomics/screen/login/login_screen.dart';
import 'package:ncomics/screen/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInternet {
  var internetStatus = "Unknown";
  var contentmessage = "Unknown";
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var d = Duration(seconds: 2);

  StreamSubscription<DataConnectionStatus> listener;

  @override
  void initState() {
    autoLogIn();
    checked();
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

  checked() async {
    DataConnectionStatus status = await checkIntenet();
    if (status == DataConnectionStatus.connected) {
      Future.delayed(d, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return LoginScreen();
          }),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.wifi,
                color: Colors.white,
                size: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Internet non disponible',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  // verification de la connexion
  checkIntenet() async {
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          Future.delayed(d, () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return LoginScreen();
              }),
            );
          });
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.wifi,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Vous êtes deconnecté d\'internet',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.red,
              duration: Duration(hours: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          );
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }

  @override
  void dispose() {
    var listener;
    //listener.cancel();
    listener?.dispose();
    super.dispose();
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
                height: 95,
                child: Image.asset('assets/images/logo.JPG'),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            // ),
            // CircularProgressIndicator(
            //   backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
