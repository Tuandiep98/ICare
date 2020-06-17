
import 'package:http/http.dart' as http; // add the http plugin in pubspec.yaml file.


class MealServices {
  static const ROOT = 'https://icareappflutter.000webhostapp.com/MealServices.php';
  static const _GET_BREAKFAST = 'GET_BREAKFAST';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_LUNCH = 'GET_LUNCH';
  static const _GET_DINNER = 'GET_DINNER';
  static const _GET_SNACK = 'GET_SNACK';
  static const _UPDATE_MEAL_ACTION = 'UPDATE_MEAL';
  static const _CHECK_MEAL_ACTION = 'CHECK_MEAL';
  static const _ADD_MEAL_ACTION = 'ADD_MEAL';

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

  static Future<String> getBreakfast(int id,DateTime time) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _GET_BREAKFAST;
      map['id'] = id.toString();
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('meals Response: ${response.body}');
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

  //Get data from lunch
  static Future<String> getLunch(int id,DateTime time) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_LUNCH;
      map['id'] = id.toString();
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('meals Response: ${response.body}');
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

  //Get data from snack
  static Future<String> getSnack(int id,DateTime time) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_SNACK;
      map['id'] = id.toString();
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('meals Response: ${response.body}');
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

  //Get data from dinner
  static Future<String> getDinner(int id,DateTime time) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_DINNER;
      map['id'] = id.toString();
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      //print('meals Response: ${response.body}');
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

  //Update breakfast
  static Future<String> updateMeal(int id,String list,int kcal,int carbs,int protein,int fat,String mealname,DateTime time,int user_id) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_MEAL_ACTION;
      map['id'] = id.toString();
      map['list'] = list;
      map['kcal'] = kcal.toString();
      map['carbs'] = carbs.toString();
      map['protein'] = protein.toString();
      map['fat'] = fat.toString();
      map['mealName'] = mealname;
      map['time'] = time.toString();
      map['user_id'] = user_id.toString();
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    }catch(e){
      return 'error/exception';
    }
  }

  //Add meal
  static Future<String> addMeal(String mealName,int id,String list,int kcal,int carbs,int protein,int fat,DateTime time) async {
    try{
      var map = Map<String, dynamic>();
      map['action'] = _ADD_MEAL_ACTION;
      map['id'] = id.toString();
      map['list'] = list;
      map['kcal'] = kcal.toString();
      map['carbs'] = carbs.toString();
      map['protein'] = protein.toString();
      map['fat'] = fat.toString();
      map['mealName'] = mealName;
      map['time'] = time.toString();
      final response = await http.post(ROOT, body: map);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return 'error';
      }
    }catch(e){
      return 'error/exception';
    }
  }

  //check meals isempty
  static Future<String> checkMeal(String mealName,DateTime time,int id) async {
    try {
      var map = Map<String , dynamic>();
      map['action'] = _CHECK_MEAL_ACTION;
      map['mealName'] = mealName;
      map['time'] = time.toString();
      map['id'] = id.toString();
      final response = await http.post(ROOT, body: map);
      print('Check Meals Response: ${response.body}');
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