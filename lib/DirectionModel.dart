
import 'dart:convert';

DirectionModel directionModelFromJson(String str) => DirectionModel.fromJson(json.decode(str));

String directionModelToJson(DirectionModel data) => json.encode(data.toJson());

class DirectionModel {
  DirectionModel({
    this.success,
    this.data,
  });

  bool success;
  List<Datum> data;

  factory DirectionModel.fromJson(Map<String, dynamic> json) => DirectionModel(
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
    this.status,
    this.id,
    this.to,
    this.datumDo,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  bool status;
  String id;
  Do to;
  Do datumDo;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    status: json["status"],
    id: json["_id"],
    to: Do.fromJson(json["to"]),
    datumDo: Do.fromJson(json["do"]),
    price: json["price"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "_id": id,
    "to": to.toJson(),
    "do": datumDo.toJson(),
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
  Do region;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Do.fromJson(Map<String, dynamic> json) => Do(
    name: Name.fromJson(json["name"]),
    id: json["_id"],
    region: json["region"] == null ? null : Do.fromJson(json["region"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "_id": id,
    "region": region == null ? null : region.toJson(),
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
