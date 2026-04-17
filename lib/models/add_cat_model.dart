// To parse this JSON data, do
//
//     final addCatModel = addCatModelFromJson(jsonString);

import 'dart:convert';

AddCatModel addCatModelFromJson(String str) => AddCatModel.fromJson(json.decode(str));

String addCatModelToJson(AddCatModel data) => json.encode(data.toJson());

class AddCatModel {
    bool status;

    AddCatModel({
        required this.status,
    });

    factory AddCatModel.fromJson(Map<String, dynamic> json) => AddCatModel(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}
