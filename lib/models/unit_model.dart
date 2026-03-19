// To parse this JSON data, do
//
//     final unitModel = unitModelFromJson(jsonString);

import 'dart:convert';

UnitModel unitModelFromJson(String str) => UnitModel.fromJson(json.decode(str));

String unitModelToJson(UnitModel data) => json.encode(data.toJson());

class UnitModel {
    bool status;
    List<Unit> data;

    UnitModel({
        required this.status,
        required this.data,
    });

    factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        status: json["status"],
        data: List<Unit>.from(json["data"].map((x) => Unit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Unit {
    int id;
    String name;

    Unit({
        required this.id,
        required this.name,
    });

    factory Unit.fromJson(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
