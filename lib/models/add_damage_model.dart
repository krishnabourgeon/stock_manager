// To parse this JSON data, do
//
//     final saveDamageModel = saveDamageModelFromJson(jsonString);

import 'dart:convert';

SaveDamageModel saveDamageModelFromJson(String str) => SaveDamageModel.fromJson(json.decode(str));

String saveDamageModelToJson(SaveDamageModel data) => json.encode(data.toJson());

class SaveDamageModel {
    bool status;
    String message;

    SaveDamageModel({
        required this.status,
        required this.message,
    });

    factory SaveDamageModel.fromJson(Map<String, dynamic> json) => SaveDamageModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
