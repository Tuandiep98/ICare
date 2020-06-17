import 'dart:ffi';

class noteData{
  int id;
  String timeEnd;
  String timeStart;
  String timeEnd2;
  String timeStart2;
  String title;
  String content;
  DateTime noteTime;
  bool checked;

  noteData(this.id, this.timeEnd, this.timeStart,this.timeEnd2,this.timeStart2, this.title, this.content,this.noteTime,this.checked);

  static List<noteData> notes = <noteData>[];

  factory noteData.fromJson(Map<String, dynamic> json) {
    return noteData(
        int.parse(json['id']),
        json['timeEnd'],
        json['timeStart'],
        json['timeEnd2'],
        json['timeStart2'],
        json['title'],
        json['content'],
        DateTime.parse(json['noteTime']),
        bool.fromEnvironment(json['checked'])
    );
  }
}