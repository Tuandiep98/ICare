import 'dart:ffi';

class User{
  int id;
  String email;
  String password;
  String name;
  String birthday;
  String height;
  String weight;
  String sex;
  String phone;
  String bio;
  String pictureUrl;
  String loginBy;
  DateTime lastUpdated;

  User({this.id,this.email,this.password,this.name,this.birthday,this.height,this.weight,this.sex,this.phone,this.bio,this.pictureUrl,this.loginBy,this.lastUpdated});

  static User main = User(
    id: 0,
    email: '',
    password: '',
    name: '',
    birthday: DateTime.now().toString(),
    height: '0',
    weight: '0',
    sex: '',
    phone: '',
    bio: '',
    pictureUrl: '',
    loginBy: '',
    lastUpdated: DateTime.now(),
  );

  factory User.fromJson(Map<String,dynamic>json){
    return User(
      id: int.parse(json['id']),
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      birthday:json['birthday'],
      height: json['height'],
      weight: json['weight'],
      sex: json['sex'] as String,
      phone: json['numberphone'] as String,
      bio: json['bio'] as String,
      pictureUrl: '',
    );
  }
}