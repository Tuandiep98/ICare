
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class ActionServices{
  static const ROOT = 'https://icareappflutter.000webhostapp.com/ActionServices.php';
  static const _GET_JOGGING = 'GET_JOGGING';
  static const _GET_ACTIONS = 'GET_ACTIONS';
  static const _UPDATE_JOGGING_ACTION = 'UPDATE_JOGGING';
  static const _CHECK_JOGGING_ACTION = 'CHECK_JOGGING';
  static const _ADD_NEW_ACTION = 'ADD_NEW_ACTION';


  static Future<String> getJogging(int id,DateTime time,String type) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_JOGGING;
      map['id'] = id.toString();
      map['time'] = time.toString();
      map['type'] = type.toString();
      final response = await http.post(ROOT, body: map);
      //print('actions Response: ${response.body}');
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

  //Get Actions
  static Future<String> getActions(int id,DateTime time) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_ACTIONS;
      map['id'] = id.toString();
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('actions Response: ${response.body}');
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
  static Future<String> updateJogging(String id,int ml,DateTime time,int userId,String lastUpdated) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_JOGGING_ACTION;
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
  static Future<String> addNewAction(int id,String type,DateTime time) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_NEW_ACTION;
      map['id'] = id.toString();
      map['type'] = type;
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('add action reponse: ${response.body}');
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
  static Future<String> checkActions(DateTime time,int id,String type) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _CHECK_JOGGING_ACTION;
      map['time'] = time.toString();
      map['id'] = id.toString();
      map['type'] = type;
      final response = await http.post(ROOT, body: map);
      print('Check action Response: ${response.body}');
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