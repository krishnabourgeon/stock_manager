// To parse this JSON data, do
//
//     final supplierModel = supplierModelFromJson(jsonString);

import 'dart:convert';

SupplierModel supplierModelFromJson(String str) => SupplierModel.fromJson(json.decode(str));

String supplierModelToJson(SupplierModel data) => json.encode(data.toJson());

class SupplierModel {
    bool status;
    List<Data> data;

    SupplierModel({
        required this.status,
        required this.data,
    });

    factory SupplierModel.fromJson(Map<String, dynamic> json) => SupplierModel(
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Data {
    int id;
    String name;
    String contactperson;
    String contactno;
    String address;

    Data({
        required this.id,
        required this.name,
        required this.contactperson,
        required this.contactno,
        required this.address,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        contactperson: json["contact_person"],
        contactno: json["contact_no"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contact_person": contactperson,
        "contact_no": contactno,
        "address": address,
    };
}
