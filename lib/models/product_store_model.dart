// To parse this JSON data, do
//
//     final productStoreModel = productStoreModelFromJson(jsonString);

import 'dart:convert';

ProductStoreModel productStoreModelFromJson(String str) => ProductStoreModel.fromJson(json.decode(str));

String productStoreModelToJson(ProductStoreModel data) => json.encode(data.toJson());

class ProductStoreModel {
    bool status;
    List<ProductStock> data;

    ProductStoreModel({
        required this.status,
        required this.data,
    });

    factory ProductStoreModel.fromJson(Map<String, dynamic> json) => ProductStoreModel(
        status: json["status"],
        data: List<ProductStock>.from(json["data"].map((x) => ProductStock.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ProductStock {
    double total;
    int productid;

    ProductStock({
        required this.total,
        required this.productid,
    });

    factory ProductStock.fromJson(Map<String, dynamic> json) => ProductStock(
        total: json["total"]?.toDouble(),
        productid: json["productid"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "productid": productid,
    };
}
