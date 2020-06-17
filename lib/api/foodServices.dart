import 'dart:convert';
import 'package:ICare/models/dataFood.dart';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class FoodServices {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/FoodServices.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_FOOD_ACTION = 'GET_ALL_FOOD';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<dataFood>> getAllFood() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_FOOD_ACTION;
      final response = await http.post(ROOT, body: map);
      //print('get food: ${response.body}');
      if (200 == response.statusCode) {
        List<dataFood> list = parseResponse(response.body);
        return list;
      } else {
        return [];
      }
    } catch (e)
    {
      return [];// return an empty list on exception/error
    }
  }

  static List<dataFood> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<dataFood>((json) => dataFood.fromJson(json)).toList();
  }

}