// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    this.success,
    this.data,
    this.driver,
  });

  bool success;
  DataClass data;
  Driver driver;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : DataClass.fromJson(json["data"]),
    driver: json["driver"] == null ? null : Driver.fromJson(json["driver"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : data.toJson(),
    "driver": driver == null ? null : driver.toJson(),
  };
}

class DataClass {
  DataClass({
    this.status,
    this.role,
    this.id,
    this.name,
    this.phone,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool status;
  String role;
  String id;
  String name;
  String phone;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
    status: json["status"] == null ? null : json["status"],
    role: json["role"] == null ? null : json["role"],
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    phone: json["phone"] == null ? null : json["phone"],
    code: json["code"] == null ? null : json["code"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "role": role == null ? null : role,
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "phone": phone == null ? null : phone,
    "code": code == null ? null : code,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Driver {
  Driver({
    this.car,
    this.files,
    this.balance,
    this.rating,
    this.isActive,
    this.status,
    this.to,
    this.driverDo,
    this.person,
    this.profilePhoto,
    this.id,
    this.user,
    this.number,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Car car;
  Files files;
  int balance;
  int rating;
  bool isActive;
  bool status;
  dynamic to;
  dynamic driverDo;
  dynamic person;
  String profilePhoto;
  String id;
  String user;
  int number;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    car: json["car"] == null ? null : Car.fromJson(json["car"]),
    files: json["files"] == null ? null : Files.fromJson(json["files"]),
    balance: json["balance"] == null ? null : json["balance"],
    rating: json["rating"] == null ? null : json["rating"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    status: json["status"] == null ? null : json["status"],
    to: json["to"],
    driverDo: json["do"],
    person: json["person"],
    profilePhoto: json["profilePhoto"] == null ? null : json["profilePhoto"],
    id: json["_id"] == null ? null : json["_id"],
    user: json["user"] == null ? null : json["user"],
    number: json["number"] == null ? null : json["number"],
    type: json["type"] == null ? null : json["type"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "car": car == null ? null : car.toJson(),
    "files": files == null ? null : files.toJson(),
    "balance": balance == null ? null : balance,
    "rating": rating == null ? null : rating,
    "isActive": isActive == null ? null : isActive,
    "status": status == null ? null : status,
    "to": to,
    "do": driverDo,
    "person": person,
    "profilePhoto": profilePhoto == null ? null : profilePhoto,
    "_id": id == null ? null : id,
    "user": user == null ? null : user,
    "number": number == null ? null : number,
    "type": type == null ? null : type,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Car {
  Car({
    this.type,
    this.number,
    this.maxnum,
  });

  String type;
  String number;
  int maxnum;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
    type: json["type"] == null ? null : json["type"],
    number: json["number"] == null ? null : json["number"],
    maxnum: json["maxnum"] == null ? null : json["maxnum"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "number": number == null ? null : number,
    "maxnum": maxnum == null ? null : maxnum,
  };
}

class Files {
  Files({
    this.tex,
    this.prava,
    this.passport,
  });

  List<dynamic> tex;
  List<dynamic> prava;
  List<dynamic> passport;

  factory Files.fromJson(Map<String, dynamic> json) => Files(
    tex: json["tex"] == null ? null : List<dynamic>.from(json["tex"].map((x) => x)),
    prava: json["prava"] == null ? null : List<dynamic>.from(json["prava"].map((x) => x)),
    passport: json["passport"] == null ? null : List<dynamic>.from(json["passport"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "tex": tex == null ? null : List<dynamic>.from(tex.map((x) => x)),
    "prava": prava == null ? null : List<dynamic>.from(prava.map((x) => x)),
    "passport": passport == null ? null : List<dynamic>.from(passport.map((x) => x)),
  };
}
