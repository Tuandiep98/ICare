import 'dart:ffi';

class dataJogging{
  int id;
  int steps;
  double distance;
  int timeOn;
  double totalKcal;
  int totalCarbs;
  int totalProtein;
  int totalFat;
  String status;
  DateTime actionTime;
  int actionTypeId;
  int actionUserId;

  dataJogging({this.id,this.steps,this.distance,this.timeOn,this.totalKcal,this.totalCarbs,this.totalProtein,this.totalFat,this.status,this.actionTime,this.actionTypeId,this.actionUserId});

  static dataJogging joggingToday = new dataJogging(
    id: null,
    steps: 0,
    distance: 0,
    timeOn: 60,
    totalKcal: 0,
    totalCarbs: 0,
    totalProtein: 0,
    totalFat: 0,
    actionTime: DateTime.now(),
    status: 'Đang thực hiện',
    actionTypeId: null,
    actionUserId: null
  );

  factory dataJogging.fromJson(Map<String,dynamic>json){
    return dataJogging(
      id: int.parse(json['id']),
      steps: int.parse(json['steps']),
      timeOn: int.parse(json['timeOn']),
      totalKcal: double.parse(json['totalKcal']),
      totalCarbs: int.parse(json['totalCarbs']),
      totalProtein: int.parse(json['totalProtein']),
      totalFat: int.parse(json['totalFat']),
      status: json['status'],
      actionTime: DateTime.parse(json['actionTime']),
      actionTypeId: int.parse(json['actionTypeId']),
      actionUserId: int.parse(json['actionUserId'])
    );
  }
}