import 'dart:convert';
import 'package:ICare/models/user.dart';
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class Services {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/UserServices.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _SIGN_UP_ACTION = 'SIGN_UP';
  static const _LOGIN = 'LOGIN';
  static const _GET_USER_DATA = 'GET_DATA_USER';
  static const _GET_GG_USER_DATA = 'GET_GG_DATA_USER';
  static const _CHECK_USER_ACTION = 'CHECK_ISVALID_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_DATA_USER';
  static const _DELETE_ACCOUNT_ACTION = 'DELETE';

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

  //get user simple
  static Future<List<User>> getUser() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_USER_DATA;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  //get google data user attributes in mysql
  static Future<String> getGGUser(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_GG_USER_DATA;
      map['email'] = email;

      final response = await http.post(ROOT, body: map);
      print('get gg data Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    } catch (e) {
      return 'error/exception'; // return an empty list on exception/error
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // Method to sign up new account to the database...
  static Future<String> login(String email,String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _LOGIN;
      map['email'] = email;
      map['password'] = password;
      final response = await http.post(ROOT, body: map);
      print('login Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to sign up new account to the database...
  static Future<String> signUp(String name, String email,String password,String confpassword) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _SIGN_UP_ACTION;
      map['name'] = name;
      map['email'] = email;
      map['password'] = password;
      map['confpassword'] = confpassword;

      final response = await http.post(ROOT, body: map);
      print('sign up Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an user in Database...
  static Future<String> updateUser(
      int user_id, String name,String birthday,String sex,String height,String weight,String numberphone,String bio,String email,String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['user_id'] = user_id.toString();
      map['name'] = name;
      map['sex'] = sex;
      map['birthday'] = birthday.toString();
      map['height'] = height;
      map['weight'] = weight;
      map['numberphone'] = numberphone;
      map['bio'] = bio;
      map['email'] = email;
      map['password'] = password;

      final response = await http.post(ROOT, body: map);
      print('Update User Response: ${response.body}');
      if (200 == response.statusCode){
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error/exception";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteAccount(int user_id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_ACCOUNT_ACTION;
      map['user_id'] = user_id;
      final response = await http.post(ROOT, body: map);
      print('deleteAccount Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
  // Method to Delete an Employee from Database...
  static Future<String> checkAccount(String email) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CHECK_USER_ACTION;
      map['email'] = email;
      final response = await http.post(ROOT, body: map);
      print('check Account Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}