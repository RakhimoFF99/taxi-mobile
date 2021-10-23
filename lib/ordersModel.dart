// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  OrderModel({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    success: json["success"] == null ? null : json["success"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? null : success,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.cargo,
    this.driver,
    this.num,
    this.comment,
    this.status,
    this.time,
    this.id,
    this.user,
    this.phone,
    this.type,
    this.to,
    this.datumDo,
    this.date,
    this.price,
    this.uid,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Cargo cargo;
  String driver;
  int num;
  String comment;
  String status;
  int time;
  String id;
  User user;
  String phone;
  String type;
  Do to;
  Do datumDo;
  DateTime date;
  int price;
  int uid;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    cargo: json["cargo"] == null ? null : Cargo.fromJson(json["cargo"]),
    driver: json["driver"] == null ? null : json["driver"],
    num: json["num"] == null ? null : json["num"],
    comment: json["comment"] == null ? null : json["comment"],
    status: json["status"] == null ? null : json["status"],
    time: json["time"] == null ? null : json["time"],
    id: json["_id"] == null ? null : json["_id"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    phone: json["phone"] == null ? null : json["phone"],
    type: json["type"] == null ? null : json["type"],
    to: json["to"] == null ? null : Do.fromJson(json["to"]),
    datumDo: json["do"] == null ? null : Do.fromJson(json["do"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    price: json["price"] == null ? null : json["price"],
    uid: json["uid"] == null ? null : json["uid"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "cargo": cargo == null ? null : cargo.toJson(),
    "driver": driver == null ? null : driver,
    "num": num == null ? null : num,
    "comment": comment == null ? null : comment,
    "status": status == null ? null : status,
    "time": time == null ? null : time,
    "_id": id == null ? null : id,
    "user": user == null ? null : user.toJson(),
    "phone": phone == null ? null : phone,
    "type": type == null ? null : type,
    "to": to == null ? null : to.toJson(),
    "do": datumDo == null ? null : datumDo.toJson(),
    "date": date == null ? null : date.toIso8601String(),
    "price": price == null ? null : price,
    "uid": uid == null ? null : uid,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}

class Cargo {
  Cargo({
    this.to,
    this.cargoDo,
  });

  int to;
  int cargoDo;

  factory Cargo.fromJson(Map<String, dynamic> json) => Cargo(
    to: json["to"] == null ? null : json["to"],
    cargoDo: json["do"] == null ? null : json["do"],
  );

  Map<String, dynamic> toJson() => {
    "to": to == null ? null : to,
    "do": cargoDo == null ? null : cargoDo,
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
  Do region;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Do.fromJson(Map<String, dynamic> json) => Do(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    id: json["_id"] == null ? null : json["_id"],
    region: json["region"] == null ? null : Do.fromJson(json["region"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name.toJson(),
    "_id": id == null ? null : id,
    "region": region == null ? null : region.toJson(),
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
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
    uz: json["uz"] == null ? null : json["uz"],
    ru: json["ru"] == null ? null : json["ru"],
  );

  Map<String, dynamic> toJson() => {
    "uz": uz == null ? null : uz,
    "ru": ru == null ? null : ru,
  };
}

class User {
  User({
    this.status,
    this.role,
    this.id,
    this.name,
    this.password,
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
  String password;
  String phone;
  String code;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    status: json["status"] == null ? null : json["status"],
    role: json["role"] == null ? null : json["role"],
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    password: json["password"] == null ? null : json["password"],
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
    "password": password == null ? null : password,
    "phone": phone == null ? null : phone,
    "code": code == null ? null : code,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}
