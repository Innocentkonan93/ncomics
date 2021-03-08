import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ncomics/providers/Bd.dart';
import 'package:ncomics/model/HTTPResponse.dart';

class APIHelper {
  static Future<HTTPResponse<List<BandeDessinees>>> getUserBd(
      String idUser) async {
    try {
      var response = await http.post(
        'http://bad-event.com/ncomic/dataHandling/getBd.php',
        body: {
          'idUser' : idUser
        },
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<BandeDessinees> _bandeDessinee = [];
        print('Connexion établie');
        body.forEach((e) {
          BandeDessinees bandeDessinee = BandeDessinees.fromJson(e);
          _bandeDessinee.add(bandeDessinee);
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
