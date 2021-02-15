import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditPassWord extends StatelessWidget {
  final String idUser;
  EditPassWord(this.idUser);
  final _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {},
              child: Text(
                'Modifier',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Nouveau mot de passe'),
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Email
class EditEmail extends StatelessWidget {
  final String idUser;
  EditEmail(this.idUser);

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<List> editUserEmail() async {
      final resp = await http
          .post('http://bad-event.com/ncomic/dataHandling/editUser.php', body: {
        'emailUser': _emailController.text,
        'idUser': idUser,
      });

      if (resp.statusCode == 200) {
        _emailController.clear();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: 'Modification réussie',
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 2,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
            onPressed: () {
              editUserEmail();
            },
            child: Text(
              'Modifier',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Nouvelle adresse mail'),
              controller: _emailController,
            ),
          ],
        ),
      ),
    );
  }
}

// Edit Number
class EditNumber extends StatelessWidget {
  final String idUser;
  EditNumber(this.idUser);
  final _numbController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future editUserNumber() async {
      final resp = await http.post(
          'http://bad-event.com/ncomic/dataHandling/editUserNum.php',
          body: {
            'numUser': _numbController.text,
            'idUser': idUser,
          });

      print(_numbController.text);
      print(idUser);
      if (resp.statusCode == 200) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: 'Modification réussie',
          backgroundColor: Colors.green,
          timeInSecForIosWeb: 2,
        );
        _numbController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                editUserNumber();
              },
              child: Text(
                'Modifier',
                style: TextStyle(
                  color: Colors.white,
                ),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Nouveau numero',
              ),
              controller: _numbController,
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
