import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ncomics/model/HTTPResponse.dart';
import 'package:ncomics/providers/category.dart';


class CATHelpler {
  static Future<HTTPResponse<List<Category>>> getCategory() async {
    String url = 'http://192.168.64.2/Projects/ncomic/dataHandling/getCategory.php';
  try {
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<Category> _categories = [];
        body.forEach((e) {
          Category categories = Category.fromJson(e);
          _categories.add(categories);
          print('Connexion établie');
        });
        return HTTPResponse(
          true,
          _categories,
          responseCode: response.statusCode,
        );
      } else {
        return HTTPResponse(
          false,
          null,
          message: 'Erreur du server',
          responseCode: response.statusCode,
        );
      }
    } on SocketException {
      return HTTPResponse(false, null,
          message: 'Vérifier votre connexion internet');
    } on FormatException {
      return HTTPResponse(false, null,
          message: 'Mauvaise réponse du server, réessayez');
    } catch (e) {
      return HTTPResponse(false, null,
          message: 'Une erreur est survenue, réessayez');
    }
  }
}