// To parse this JSON data, do
//
//     final directionStatusModel = directionStatusModelFromJson(jsonString);

import 'dart:convert';

DirectionStatusModel directionStatusModelFromJson(String str) => DirectionStatusModel.fromJson(json.decode(str));

String directionStatusModelToJson(DirectionStatusModel data) => json.encode(data.toJson());

class DirectionStatusModel {
  DirectionStatusModel({
    this.success,
    this.data,
  });

  bool success;
  Data data;

  factory DirectionStatusModel.fromJson(Map<String, dynamic> json) => DirectionStatusModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.car,
    this.files,
    this.balance,
    this.rating,
    this.isActive,
    this.status,
    this.todo,
    this.direction,
    this.person,
    this.id,
    this.user,
    this.number,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.profilePhoto,
  });

  Car car;
  Files files;
  int balance;
  int rating;
  bool isActive;
  bool status;
  String todo;
  List<Direction> direction;
  int person;
  String id;
  User user;
  int number;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String profilePhoto;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    car: Car.fromJson(json["car"]),
    files: Files.fromJson(json["files"]),
    balance: json["balance"],
    rating: json["rating"],
    isActive: json["isActive"],
    status: json["status"],
    todo: json["todo"],
    direction: List<Direction>.from(json["direction"].map((x) => Direction.fromJson(x))),
    person: json["person"],
    id: json["_id"],
    user: User.fromJson(json["user"]),
    number: json["number"],
    type: json["type"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    profilePhoto: json["profilePhoto"],
  );

  Map<String, dynamic> toJson() => {
    "car": car.toJson(),
    "files": files.toJson(),
    "balance": balance,
    "rating": rating,
    "isActive": isActive,
    "status": status,
    "todo": todo,
    "direction": List<dynamic>.from(direction.map((x) => x.toJson())),
    "person": person,
    "_id": id,
    "user": user.toJson(),
    "number": number,
    "type": type,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "profilePhoto": profilePhoto,
  };
}

class Car {
  Car({
    this.type,
    this.number,
  });

  String type;
  String number;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    type: json["type"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "number": number,
  };
}

class Direction {
  Direction({
    this.status,
    this.id,
    this.to,
    this.directionDo,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool status;
  String id;
  Do to;
  Do directionDo;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Direction.fromJson(Map<String, dynamic> json) => Direction(
    status: json["status"],
    id: json["_id"],
    to: Do.fromJson(json["to"]),
    directionDo: Do.fromJson(json["do"]),
    price: json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "to": to.toJson(),
    "do": directionDo.toJson(),
    "price": price,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Do {
  Do({
    this.name,
    this.id,
    this.region,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Name name;
  String id;
  String region;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Do.fromJson(Map<String, dynamic> json) => Do(
    name: Name.fromJson(json["name"]),
    id: json["_id"],
    region: json["region"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "_id": id,
    "region": region,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class Name {
  Name({
    this.uz,
    this.ru,
  });

  String uz;
  String ru;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    uz: json["uz"],
    ru: json["ru"],
  );

  Map<String, dynamic> toJson() => {
    "uz": uz,
    "ru": ru,
  };
}

class Files {
  Files({
    this.tex,
    this.prava,
    this.passport,
  });

  List<String> tex;
  List<String> prava;
  List<String> passport;

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    tex: List<String>.from(json["tex"].map((x) => x)),
    prava: List<String>.from(json["prava"].map((x) => x)),
    passport: List<String>.from(json["passport"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tex": List<dynamic>.from(tex.map((x) => x)),
    "prava": List<dynamic>.from(prava.map((x) => x)),
    "passport": List<dynamic>.from(passport.map((x) => x)),
  };
}

class User {
  User({
    this.role,
    this.id,
    this.name,
    this.password,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String role;
  String id;
  String name;
  String password;
  String phone;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    role: json["role"],
    id: json["_id"],
    name: json["name"],
    password: json["password"],
    phone: json["phone"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "_id": id,
    "name": name,
    "password": password,
    "phone": phone,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
