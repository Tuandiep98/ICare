class dataWater{
  int id;
  int ml;
  String time;
  String userId;
  String lastUpdated;
  int per;
  int lv;

  dataWater({
    this.id,
    this.ml = 0,
    this.time,
    this.userId,
    this.lastUpdated,
    this.per = 0,
    this.lv = 150
  });

  static dataWater water = dataWater(
    id: 0,
    lv: 150,
    ml: 0,
    per: 0,
    userId: '',
    time: '',
    lastUpdated: '',
  );

  factory dataWater.fromJson(Map<String, dynamic> json) {
    return dataWater(
        id: int.parse(json['id']),
        ml: int.parse(json['waterCapacity']),
        time: json['waterTime'],
        userId: json['waterUserId'],
        lastUpdated: json['lastUpdated']
    );
  }
}