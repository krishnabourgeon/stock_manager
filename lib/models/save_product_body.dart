// To parse this JSON data, do
//
//     final saveProductBody = saveProductBodyFromJson(jsonString);

import 'dart:convert';

SaveProductBody saveProductBodyFromJson(String str) => SaveProductBody.fromJson(json.decode(str));

String saveProductBodyToJson(SaveProductBody data) => json.encode(data.toJson());

class SaveProductBody {
    String code;
    String name;
    String catId;
    String unit;
    String price;
    String storeId;

    SaveProductBody({
        required this.code,
        required this.name,
        required this.catId,
        required this.unit,
        required this.price,
        required this.storeId,
    });

    factory SaveProductBody.fromJson(Map<String, dynamic> json) => SaveProductBody(
        code: json["code"],
        name: json["name"],
        catId: json["cat_id"],
        unit: json["unit"],
        price: json["price"],
        storeId: json["store_id"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "cat_id": catId,
        "unit": unit,
        "price": price,
        "store_id": storeId,
    };
}
