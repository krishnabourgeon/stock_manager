// To parse this JSON data, do
//
//     final saveStockModel = saveStockModelFromJson(jsonString);

import 'dart:convert';

SaveStockModel saveStockModelFromJson(String str) => SaveStockModel.fromJson(json.decode(str));

String saveStockModelToJson(SaveStockModel data) => json.encode(data.toJson());

class SaveStockModel {
    bool status;
    String message;
    int purchaseId;

    SaveStockModel({
        required this.status,
        required this.message,
        required this.purchaseId,
    });

    factory SaveStockModel.fromJson(Map<String, dynamic> json) => SaveStockModel(
        status: json["status"],
        message: json["message"],
        purchaseId: json["purchase_id"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "purchase_id": purchaseId,
    };
}
