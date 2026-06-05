// To parse this JSON data, do
//
//     final addSupplierModel = addSupplierModelFromJson(jsonString);

import 'dart:convert';

AddSupplierModel addSupplierModelFromJson(String str) => AddSupplierModel.fromJson(json.decode(str));

String addSupplierModelToJson(AddSupplierModel data) => json.encode(data.toJson());

class AddSupplierModel {
    bool status;
    String message;

    AddSupplierModel({
        required this.status,
        required this.message,
    });

    factory AddSupplierModel.fromJson(Map<String, dynamic> json) => AddSupplierModel(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
