// // To parse this JSON data, do
// //
// //     final getAllProduct = getAllProductFromJson(jsonString);

// import 'dart:convert';

// GetAllProduct getAllProductFromJson(String str) => GetAllProduct.fromJson(json.decode(str));

// String getAllProductToJson(GetAllProduct data) => json.encode(data.toJson());

// class GetAllProduct {
//     bool status;
//     List<AllProduct> data;

//     GetAllProduct({
//         required this.status,
//         required this.data,
//     });

//     factory GetAllProduct.fromJson(Map<String, dynamic> json) => GetAllProduct(
//         status: json["status"],
//         data: List<AllProduct>.from(json["data"].map((x) => AllProduct.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
// }

// class AllProduct {
//     int id;
//     int code;
//     String name;
//     int unit;
//     int catId;
//     String price;
//     String stock;
//     DateTime created;
//     int status;
//     String nameMal;

//     AllProduct({
//         required this.id,
//         required this.code,
//         required this.name,
//         required this.unit,
//         required this.catId,
//         required this.price,
//         required this.stock,
//         required this.created,
//         required this.status,
//         required this.nameMal,
//     });

//     factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
//         id: json["id"],
//         code: json["code"],
//         name: json["name"],
//         unit: json["unit"],
//         catId: json["cat_id"],
//         price: json["price"],
//         stock: json["stock"],
//         created: DateTime.parse(json["created"]),
//         status: json["status"],
//         nameMal: json["name_mal"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "code": code,
//         "name": name,
//         "unit": unit,
//         "cat_id": catId,
//         "price": price,
//         "stock": stock,
//         "created": created.toIso8601String(),
//         "status": status,
//         "name_mal": nameMal,
//     };
// }




// To parse this JSON data, do
//
//     final getAllProduct = getAllProductFromJson(jsonString);

import 'dart:convert';

GetAllProduct getAllProductFromJson(String str) => GetAllProduct.fromJson(json.decode(str));

String getAllProductToJson(GetAllProduct data) => json.encode(data.toJson());

class GetAllProduct {
    bool status;
    List<AllProduct> data;

    GetAllProduct({
        required this.status,
        required this.data,
    });

    factory GetAllProduct.fromJson(Map<String, dynamic> json) => GetAllProduct(
        status: json["status"],
        data: List<AllProduct>.from(json["data"].map((x) => AllProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class AllProduct {
    int id;
    int code;
    String name;
    int unit;
    int catId;
    String price;
    String stock;
    DateTime created;
    int status;
    String nameMal;
    String catname;

    AllProduct({
        required this.id,
        required this.code,
        required this.name,
        required this.unit,
        required this.catId,
        required this.price,
        required this.stock,
        required this.created,
        required this.status,
        required this.nameMal,
        required this.catname,
    });

    factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        unit: json["unit"],
        catId: json["cat_id"],
        price: json["price"],
        stock: json["stock"],
        created: DateTime.parse(json["created"]),
        status: json["status"],
        nameMal: json["name_mal"],
        catname: json["catname"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "unit": unit,
        "cat_id": catId,
        "price": price,
        "stock": stock,
        "created": created.toIso8601String(),
        "status": status,
        "name_mal": nameMal,
        "catname": catname,
    };
}
