// To parse this JSON data, do
//
//     final saveCatBody = saveCatBodyFromJson(jsonString);

import 'dart:convert';

SaveCatBody saveCatBodyFromJson(String str) => SaveCatBody.fromJson(json.decode(str));

String saveCatBodyToJson(SaveCatBody data) => json.encode(data.toJson());

class SaveCatBody {
    String name;

    SaveCatBody({
        required this.name,
    });

    factory SaveCatBody.fromJson(Map<String, dynamic> json) => SaveCatBody(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
