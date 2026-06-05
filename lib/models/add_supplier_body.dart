// To parse this JSON data, do
//
//     final addSupplierBody = addSupplierBodyFromJson(jsonString);

import 'dart:convert';

AddSupplierBody addSupplierBodyFromJson(String str) => AddSupplierBody.fromJson(json.decode(str));

String addSupplierBodyToJson(AddSupplierBody data) => json.encode(data.toJson());

class AddSupplierBody {
    String name;
    String contactPerson;
    int contactNo;
    String address;
    int storeId;

    AddSupplierBody({
        required this.name,
        required this.contactPerson,
        required this.contactNo,
        required this.address,
        required this.storeId,
    });

    factory AddSupplierBody.fromJson(Map<String, dynamic> json) => AddSupplierBody(
        name: json["name"],
        contactPerson: json["contact_person"],
        contactNo: json["contact_no"],
        address: json["address"],
        storeId: json["store_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "contact_person": contactPerson,
        "contact_no": contactNo,
        "address": address,
        "store_id": storeId,
    };
}
