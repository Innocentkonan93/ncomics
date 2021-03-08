import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:ncomics/model/ImageBd.dart';

class AllImageBd {
  static const String url =
      'http://bad-event.com/ncomic/dataHandling/getAllImageBd.php';

  static Future<List<ImageBd>> getImageBd() async {
    try {
      print('connexion réussie');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        List<ImageBd> list = parseImageBd(response.body);
        return list;
      } else {
        throw Exception("Error");
      }
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  static List<ImageBd> parseImageBd(responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<ImageBd>((json) => ImageBd.fromJson(json)).toList();
  }
}
