// To parse this JSON data, do
//
//     final addDamageBody = addDamageBodyFromJson(jsonString);

import 'dart:convert';

AddDamageBody addDamageBodyFromJson(String str) => AddDamageBody.fromJson(json.decode(str));

String addDamageBodyToJson(AddDamageBody data) => json.encode(data.toJson());

class AddDamageBody {
    List<Item> items;

    AddDamageBody({
        required this.items,
    });

    factory AddDamageBody.fromJson(Map<String, dynamic> json) => AddDamageBody(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    int productId;
    String unit;
    int qty;
    int storeId;
    String reason;
    DateTime date;

    Item({
        required this.productId,
        required this.unit,
        required this.qty,
        required this.storeId,
        required this.reason,
        required this.date,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        productId: json["product_id"],
        unit: json["unit"],
        qty: json["qty"],
        storeId: json["store_id"],
        reason: json["reason"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "product_id": productId,
        "unit": unit,
        "qty": qty,
        "store_id": storeId,
        "reason": reason,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
