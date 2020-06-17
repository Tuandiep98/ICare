import 'dart:convert';
import 'package:ICare/models/response_top_headlinews_news.dart';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.

class ApiProvider {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/NewsServices.php';
  void printOutError(error, StackTrace stacktrace) {
    print('Exception occured: $error with stacktrace: $stacktrace');
  }

  Future<List<News>> getTopHeadlinesNews() async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = 'GET_ALL_NEWS';

      final response = await http.post(ROOT, body: map);
      List<News> list = parseResponse(response.body);
      return list;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return [];
    }
  }

  Future<List<News>> getTinTucTheoLoai(int newsType) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = 'GET_NEWS';
      map['newsType'] = newsType.toString();

      final response = await http.post(ROOT, body: map);
      List<News> list = parseResponse(response.body);
      return list;
    } catch (error, stacktrace) {
      printOutError(error, stacktrace);
      return [];
    }
  }
  static List<News> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<News>((json) => News.fromJson(json)).toList();
  }
}
