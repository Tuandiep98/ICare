class dataFood{
  String id;
  String fName;
  String fType;
  String fKcal;
  String fCarb;
  String fProtein;
  String fFat;
  String fStatus;

  dataFood({
    this.id,
    this.fName,
    this.fType,
    this.fKcal,
    this.fCarb,
    this.fProtein,
    this.fFat,
    this.fStatus
  });

  factory dataFood.fromJson(Map<String, dynamic> json) {
    return dataFood(
        id: json['id'],
        fKcal: json['kcal'],
        fCarb: json['Carbs'],
        fProtein: json['Protein'],
        fFat: json['Fat'],
        fName: json['name'],
        fStatus: json['status'],
        fType: json['type']
    );
  }
}