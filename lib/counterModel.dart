// To parse this JSON data, do
//
//     final counterModel = counterModelFromJson(jsonString);

import 'dart:convert';

CounterModel counterModelFromJson(String str) => CounterModel.fromJson(json.decode(str));

String counterModelToJson(CounterModel data) => json.encode(data.toJson());

class CounterModel {
  CounterModel({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.districts,
    this.region,
  });

  String id;
  Name name;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  List<Datum> districts;
  String region;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: Name.fromJson(json["name"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    districts: json["districts"] == null ? null : List<Datum>.from(json["districts"].map((x) => Datum.fromJson(x))),
    region: json["region"] == null ? null : json["region"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name.toJson(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "districts": districts == null ? null : List<dynamic>.from(districts.map((x) => x.toJson())),
    "region": region == null ? null : region,
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
