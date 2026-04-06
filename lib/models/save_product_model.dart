// To parse this JSON data, do
//
//     final saveProductModel = saveProductModelFromJson(jsonString);

import 'dart:convert';

SaveProductModel saveProductModelFromJson(String str) => SaveProductModel.fromJson(json.decode(str));

String saveProductModelToJson(SaveProductModel data) => json.encode(data.toJson());

class SaveProductModel {  
    bool status;
    Product product;

    SaveProductModel({
        required this.status,
        required this.product,
    });

    factory SaveProductModel.fromJson(Map<String, dynamic> json) => SaveProductModel(
        status: json["status"] ?? false,
        product: json["data"] != null ? Product.fromJson(json["data"]) : Product.empty(),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": product.toJson(),
    };
}

class Product {
    String code;
    String name;
    String catId;
    String unit;
    String price;
    int status;
    int id;

    Product({
        required this.code,
        required this.name,
        required this.catId,
        required this.unit,
        required this.price,
        required this.status,
        required this.id,
    });

    factory Product.empty() => Product(
        code: "",
        name: "",
        catId: "",
        unit: "",
        price: "",
        status: 0,
        id: 0,
    );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        name: json["name"],
        catId: json["cat_id"],
        unit: json["unit"],
        price: json["price"],
        status: json["status"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "cat_id": catId,
        "unit": unit,
        "price": price,
        "status": status,
        "id": id,
    };
}
