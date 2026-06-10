// To parse this JSON data, do
//
//     final saveCatBody = saveCatBodyFromJson(jsonString);

import 'dart:convert';

SaveCatBody saveCatBodyFromJson(String str) => SaveCatBody.fromJson(json.decode(str));

String saveCatBodyToJson(SaveCatBody data) => json.encode(data.toJson());

class SaveCatBody {
    String name;
    String? nameMal;
    int storeId;

    SaveCatBody({
        required this.name,
        this.nameMal,
        required this.storeId,
    });

    factory SaveCatBody.fromJson(Map<String, dynamic> json) => SaveCatBody(
        name: json["name"],
        nameMal: json["name_mal"],
        storeId: json["store_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "name_mal": nameMal,
        "store_id": storeId,
    };
}
