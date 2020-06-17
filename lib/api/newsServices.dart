
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class NewsServices {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/NewsServices.php';
  static const _GET_NEWS = 'GET_NEWS';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _UPDATE_NEWS_ACTION = 'UPDATE_NEWS';
  static const _CHECK_NEWS_ACTION = 'CHECK_NEWS';
  static const _ADD_NEWS_ACTION = 'ADD_NEWS';

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

  static Future<String> getNewsById(int newsType) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_NEWS;
      map['newsType'] = newsType.toString();

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
  static Future<String> updateNews(int id,int ml,DateTime time,int userId,String lastUpdated) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_NEWS_ACTION;
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
  static Future<String> addNews(int userid,int ml,DateTime time,String lastupdated) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_NEWS_ACTION;
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
  static Future<String> checkNews(DateTime time,int id) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _CHECK_NEWS_ACTION;
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