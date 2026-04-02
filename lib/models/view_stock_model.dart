// // // To parse this JSON data, do
// // //
// // //     final viewStockModel = viewStockModelFromJson(jsonString);

// // import 'dart:convert';

// // ViewStockModel viewStockModelFromJson(String str) => ViewStockModel.fromJson(json.decode(str));

// // String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

// // class ViewStockModel {
// //     bool status;
// //     List<StockList> data;

// //     ViewStockModel({
// //         required this.status,
// //         required this.data,
// //     });

// //     factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
// //         status: json["status"],
// //         data: List<StockList>.from(json["data"].map((x) => StockList.fromJson(x))),
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "data": List<dynamic>.from(data.map((x) => x.toJson())),
// //     };
// // }

// // class StockList {
// //     double total;
// //     int productid;
// //     String name;

// //     StockList({
// //         required this.total,
// //         required this.productid,
// //         required this.name,
// //     });

// //     factory StockList.fromJson(Map<String, dynamic> json) => StockList(
// //         total: json["total"]?.toDouble(),
// //         productid: json["id"],
// //         name: json["name"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "total": total,
// //         "id": productid,
// //         "name": name,
// //     };
// // }



// // To parse this JSON data, do
// //
// //     final viewStockModel = viewStockModelFromJson(jsonString);

// import 'dart:convert';

// ViewStockModel viewStockModelFromJson(String str) => ViewStockModel.fromJson(json.decode(str));

// String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

// class ViewStockModel {
//     bool status;
//     List<StockList>? data;
//     Temple? temple;

//     ViewStockModel({
//       required  this.status,
//         this.data,
//         this.temple,
//     });

//     factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
//         status: json["status"],
//         data: json["data"] == null ? [] : List<StockList>.from(json["data"]!.map((x) => StockList.fromJson(x))),
//         temple: json["temple"] == null ? null : Temple.fromJson(json["temple"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "temple": temple?.toJson(),
//     };
// }

// class StockList {
//     double? total;
//     String? name;
//     int? id;

//     StockList({
//         this.total,
//         this.name,
//         this.id,
//     });

//     factory StockList.fromJson(Map<String, dynamic> json) => StockList(
//         total: json["total"]?.toDouble(),
//         name: json["name"],
//         id: json["id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "total": total,
//         "name": name,
//         "id": id,
//     };
// }

// class Temple {
//     String? name;
//     String? nameMal;
//     String? addressLine1;
//     String? addressLine2;
//     String? phone;
//     String? email;
//     String? website;

//     Temple({
//         this.name,
//         this.nameMal,
//         this.addressLine1,
//         this.addressLine2,
//         this.phone,
//         this.email,
//         this.website,
//     });

//     factory Temple.fromJson(Map<String, dynamic> json) => Temple(
//         name: json["name"],
//         nameMal: json["name_mal"],
//         addressLine1: json["address_line_1"],
//         addressLine2: json["address_line_2"],
//         phone: json["phone"],
//         email: json["email"],
//         website: json["website"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "name_mal": nameMal,
//         "address_line_1": addressLine1,
//         "address_line_2": addressLine2,
//         "phone": phone,
//         "email": email,
//         "website": website,
//     };
// }



// // To parse this JSON data, do
// //
// //     final viewStockModel = viewStockModelFromJson(jsonString);

// import 'dart:convert';

// ViewStockModel viewStockModelFromJson(String str) => ViewStockModel.fromJson(json.decode(str));

// String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

// class ViewStockModel {
//     bool status;
//     List<StockList> data;
//     Temple temple;

//     ViewStockModel({
//         required this.status,
//         required this.data,
//         required this.temple,
//     });

//     factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
//         status: json["status"],
//         data: List<StockList>.from(json["data"].map((x) => StockList.fromJson(x))),
//         temple: Temple.fromJson(json["temple"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "temple": temple.toJson(),
//     };
// }

// class StockList {
//     int total;
//     String name;
//     int id;
//     String code;

//     StockList({
//         required this.total,
//         required this.name,
//         required this.id,
//         required this.code,
//     });

//     factory StockList.fromJson(Map<String, dynamic> json) => StockList(
//         total: json["total"],
//         name: json["name"],
//         id: json["id"],
//         code: json["code"],
//     );

//     Map<String, dynamic> toJson() => {
//         "total": total,
//         "name": name,
//         "id": id,
//         "code": code,
//     };
// }

// class Temple {
//     String name;
//     String nameMal;
//     String addressLine1;
//     String addressLine2;
//     String phone;
//     String email;
//     String website;

//     Temple({
//         required this.name,
//         required this.nameMal,
//         required this.addressLine1,
//         required this.addressLine2,
//         required this.phone,
//         required this.email,
//         required this.website,
//     });

//     factory Temple.fromJson(Map<String, dynamic> json) => Temple(
//         name: json["name"],
//         nameMal: json["name_mal"],
//         addressLine1: json["address_line_1"],
//         addressLine2: json["address_line_2"],
//         phone: json["phone"],
//         email: json["email"],
//         website: json["website"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "name_mal": nameMal,
//         "address_line_1": addressLine1,
//         "address_line_2": addressLine2,
//         "phone": phone,
//         "email": email,
//         "website": website,
//     };
// }




// To parse this JSON data, do
//
//     final viewStockModel = viewStockModelFromJson(jsonString);

import 'dart:convert';

ViewStockModel viewStockModelFromJson(String str) => ViewStockModel.fromJson(json.decode(str));

String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

class ViewStockModel {
    bool status;
    List<StockList> data;
    Temple temple;

    ViewStockModel({
        required this.status,
        required this.data,
        required this.temple,
    });

    factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
        status: json["status"],
        data: List<StockList>.from(json["data"].map((x) => StockList.fromJson(x))),
        temple: Temple.fromJson(json["temple"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "temple": temple.toJson(),
    };
}

class StockList {
    int total;
    String name;
    int id;
    String code;
    String unitName;
    int purchaseid;

    StockList({
        required this.total,
        required this.name,
        required this.id,
        required this.code,
        required this.unitName,
        required this.purchaseid,
    });

    factory StockList.fromJson(Map<String, dynamic> json) => StockList(
        total: json["total"],
        name: json["name"],
        id: json["id"],
        code: json["code"],
        unitName: json["unit_name"],
        purchaseid: json["purchaseid"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "name": name,
        "id": id,
        "code": code,
        "unit_name": unitName,
        "purchaseid": purchaseid,
    };
}

class Temple {
    String name;
    String nameMal;
    String addressLine1;
    String addressLine2;
    String phone;
    String email;
    String website;

    Temple({
        required this.name,
        required this.nameMal,
        required this.addressLine1,
        required this.addressLine2,
        required this.phone,
        required this.email,
        required this.website,
    });

    factory Temple.fromJson(Map<String, dynamic> json) => Temple(
        name: json["name"],
        nameMal: json["name_mal"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        phone: json["phone"],
        email: json["email"],
        website: json["website"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "name_mal": nameMal,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "phone": phone,
        "email": email,
        "website": website,
    };
}
