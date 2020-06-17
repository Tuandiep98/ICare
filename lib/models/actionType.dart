class actionType{
  String id;
  String actionName;
  String timeOff;
  String status;
  String imagePath;

  actionType({
    this.id,
    this.actionName,
    this.status,
    this.timeOff,
    this.imagePath
  });

  static List<actionType> actionsType = <actionType>[

  ];

  factory actionType.fromJson(Map<String,dynamic>json){
    return actionType(
      id: json['id'].toString(),
      actionName : json['actionName'],
      timeOff : json['timeOff'].toString(),
      status : json['status'],
      imagePath: json['imagePath'],
    );
  }
}