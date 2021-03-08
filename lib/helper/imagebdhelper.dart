import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:ncomics/model/HTTPResponse.dart';
import 'package:ncomics/model/ImageBd.dart';

class APIHelper {
  static Future<HTTPResponse<List<ImageBd>>> getImageBd() async {
    String url = 'http://192.168.64.2/Projects/ncomic/getData/getImageBd.php';

    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ImageBd> _imageBd = [];
        body.forEach((e) {
          ImageBd imageBd = ImageBd.fromJson(e);
          _imageBd.add(imageBd);
          print('Connexion établie');
        });
        return HTTPResponse(
          true,
          _imageBd,
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
