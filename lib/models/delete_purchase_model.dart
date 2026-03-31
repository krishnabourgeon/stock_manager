// To parse this JSON data, do
//
//     final deletePurchaseModel = deletePurchaseModelFromJson(jsonString);

import 'dart:convert';

DeletePurchaseModel deletePurchaseModelFromJson(String str) => DeletePurchaseModel.fromJson(json.decode(str));

String deletePurchaseModelToJson(DeletePurchaseModel data) => json.encode(data.toJson());

class DeletePurchaseModel {
    bool? status;
    String? message;

    DeletePurchaseModel({
        this.status,
        this.message,
    });

    factory DeletePurchaseModel.fromJson(Map<String, dynamic> json) => DeletePurchaseModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
