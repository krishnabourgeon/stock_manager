// To parse this JSON data, do
//
//     final saveCatBody = saveCatBodyFromJson(jsonString);

import 'dart:convert';

SaveCatBody saveCatBodyFromJson(String str) => SaveCatBody.fromJson(json.decode(str));

String saveCatBodyToJson(SaveCatBody data) => json.encode(data.toJson());

class SaveCatBody {
    String name;
    int storeId;

    SaveCatBody({
        required this.name,
        required this.storeId,
    });

    factory SaveCatBody.fromJson(Map<String, dynamic> json) => SaveCatBody(
        name: json["name"],
        storeId: json["store_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "store_id": storeId,
    };
}
