import 'dart:convert';
import 'package:ICare/models/note.dart';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class NoteServices {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/NoteServices.php';
  static const _GET_NOTES = 'GET_NOTES';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _UPDATE_NOTE_ACTION = 'UPDATE_NOTE';
  static const _CHECK_WATER_ACTION = 'CHECK_WATER';
  static const _ADD_NOTE_ACTION = 'ADD_NOTE';
  static const _DELETE_NOTE = 'DELETE_NOTE';

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

  static Future<String> getNotes(int id,DateTime time) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_NOTES;
      map['id'] = id.toString();
      map['time'] = time.toString();

      final response = await http.post(ROOT, body: map);
      //List<noteData> list = parseResponse(response.body);
      print('get notes: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e)
    {
      return 'error';// return an empty list on exception/error
    }
  }

  //Update
  static Future<String> updateNote(int id,int userid,String title,String content,String timeStart,String timeEnd,String timeStart2,String timeEnd2,DateTime noteTime,String checked) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_NOTE_ACTION;
      map['id'] = id.toString();
      map['userid'] = userid.toString();
      map['title'] = title;
      map['content'] = content;
      map['timeStart'] = timeStart;
      map['timeEnd'] = timeEnd;
      map['timeStart2'] = timeStart2;
      map['timeEnd2'] = timeEnd2;
      map['noteTime'] = noteTime.toString();
      map['checked'] = checked;
      final response = await http.post(ROOT, body: map);
      print('update note response: ${response.body}');
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
  static Future<String> addNote(int userid,String title,String content,String timeStart,String timeEnd,String timeStart2,String timeEnd2,DateTime noteTime,String checked) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_NOTE_ACTION;
      map['userid'] = userid.toString();
      map['title'] = title;
      map['content'] = content;
      map['timeStart'] = timeStart;
      map['timeEnd'] = timeEnd;
      map['timeStart2'] = timeStart2;
      map['timeEnd2'] = timeEnd2;
      map['noteTime'] = noteTime.toString();
      map['checked'] = checked;
      final response = await http.post(ROOT, body: map);
      print('note result: ${response.body}');
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

  //delete note
  static Future<String> deleteNote(int id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_NOTE;
      map['id'] = id.toString();
      final response = await http.post(ROOT, body: map);
      print('delete note result: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    }catch(e){
      return 'error/exception';
    }
  }

  static List<noteData> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<noteData>((json) => noteData.fromJson(json)).toList();
  }
}