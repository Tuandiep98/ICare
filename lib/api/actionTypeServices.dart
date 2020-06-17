
import 'dart:convert';

import 'package:ICare/models/actionType.dart';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class ActionTypeServices{
  static const ROOT = 'https://icareappflutter.000webhostapp.com/ActionTypeServices.php';
  static const _GET_TYPE = 'GET_TYPE';


  static Future<List<actionType>> getType() async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_TYPE;

      final response = await http.post(ROOT, body: map);
      //print('type Response: ${response.body}');
      if (200 == response.statusCode) {
        List<actionType> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e)
    {
      return [];// return an empty list on exception/error
    }
  }
  static List<actionType> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<actionType>((json) => actionType.fromJson(json)).toList();
  }
}