import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/model/HTTPResponse.dart';

class APIHelper {
  static Future<HTTPResponse<List<BandeDessinees>>> getBandeDessinees() async {
    String url = 'http://192.168.64.2/Projects/ncomic/dataHandling/getBd.php';
    try {
      var response = await get(url);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<BandeDessinees> _bandeDessinee = [];
        body.forEach((e) {
          BandeDessinees bandeDessinee = BandeDessinees.fromJson(e);
          _bandeDessinee.add(bandeDessinee);
          print('Connexion établie');
        });
        return HTTPResponse(
          true,
          _bandeDessinee,
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
