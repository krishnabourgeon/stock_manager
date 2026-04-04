// // To parse this JSON data, do
// //
// //     final productModel = productModelFromJson(jsonString);

// import 'dart:convert';

// ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

// String productModelToJson(ProductModel data) => json.encode(data.toJson());

// class ProductModel {
//     bool status;
//     List<Datum> data;

//     ProductModel({
//         required this.status,
//         required this.data,
//     });

//     factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
//         status: json["status"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class Datum {
//     int id;
//     String name;
//     int unit;
//     String price;
//     int catId;

//     Datum({
//         required this.id,
//         required this.name,
//         required this.unit,
//         required this.price,
//         required this.catId,
//     });

//     factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         unit: json["unit"],
//         price: json["price"],
//         catId: json["cat_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "unit": unit,
//         "price": price,
//         "cat_id": catId,
//     };
// }




// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    bool status;
    List<Datum> data;

    ProductModel({
        required this.status,
        required this.data,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    int id;
    String code;
    String name;
    int unit;
    String price;
    int catId;

    Datum({
        required this.id,
        required this.code,
        required this.name,
        required this.unit,
        required this.price,
        required this.catId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        unit: json["unit"],
        price: json["price"],
        catId: json["cat_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "unit": unit,
        "price": price,
        "cat_id": catId,
    };
}
