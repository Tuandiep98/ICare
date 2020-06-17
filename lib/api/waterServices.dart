
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class WaterServices {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/WaterServices.php';
  static const _GET_WATER = 'GET_WATER';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _UPDATE_WATER_ACTION = 'UPDATE_WATER';
  static const _CHECK_WATER_ACTION = 'CHECK_WATER';
  static const _ADD_WATER_ACTION = 'ADD_WATER';

  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      print(response.statusCode);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error catch";
    }
  }

  static Future<String> getWater(int id,DateTime time) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_WATER;
      map['id'] = id.toString();
      map['time'] = time.toString();

      final response = await http.post(ROOT, body: map);
      //print('water Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e)
    {
      return "error";// return an empty list on exception/error
    }
  }

  //Update
  static Future<String> updateWater(int id,int ml,DateTime time,int userId,String lastUpdated) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_WATER_ACTION;
      map['id'] = id.toString();
      map['ml'] = ml.toString();
      map['time'] = time.toString();
      map['userId'] = userId.toString();
      map['lastUpdated'] = lastUpdated;
      final response = await http.post(ROOT, body: map);
      print('update water response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    }catch(e){
      return 'error/exception';
    }
  }

  //Add water
  static Future<String> addWater(int userid,int ml,DateTime time,String lastupdated) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_WATER_ACTION;
      map['userid'] = userid.toString();
      map['ml'] = ml.toString();
      map['time'] = time.toString();
      map['lastupdated'] = lastupdated;
      final response = await http.post(ROOT, body: map);
      print('water result: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    }catch(e){
      return 'error/exception';
    }
  }

  //check is empty
  static Future<String> checkWater(DateTime time,int id) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _CHECK_WATER_ACTION;
      map['time'] = time.toString();
      map['id'] = id.toString();
      final response = await http.post(ROOT, body: map);
      print('Check water Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e)
    {
      return "error";// return an empty list on exception/error
    }
  }
}