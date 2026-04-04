// // // To parse this JSON data, do
// // //
// // //     final purchaseDetailsModel = purchaseDetailsModelFromJson(jsonString);

// // import 'dart:convert';

// // PurchaseDetailsModel purchaseDetailsModelFromJson(String str) => PurchaseDetailsModel.fromJson(json.decode(str));

// // String purchaseDetailsModelToJson(PurchaseDetailsModel data) => json.encode(data.toJson());

// // class PurchaseDetailsModel {
// //     bool? status;
// //     List<Details>? data;

// //     PurchaseDetailsModel({
// //         this.status,
// //         this.data,
// //     });

// //     factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) => PurchaseDetailsModel(
// //         status: json["status"],
// //         data: json["data"] == null ? [] : List<Details>.from(json["data"]!.map((x) => Details.fromJson(x))),
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "status": status,
// //         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
// //     };
// // }

// // class Details {
// //     int? id;
// //     int? refId;
// //     int? productId;
// //     int? unit;
// //     int? qty;
// //     int? tax;
// //     int? subTot;
// //     int? status;

// //     Details({
// //         this.id,
// //         this.refId,
// //         this.productId,
// //         this.unit,
// //         this.qty,
// //         this.tax,
// //         this.subTot,
// //         this.status,
// //     });

// //     factory Details.fromJson(Map<String, dynamic> json) => Details (
// //         id: json["id"],
// //         refId: json["ref_id"],
// //         productId: json["product_id"],
// //         unit: json["unit"],
// //         qty: json["qty"],
// //         tax: json["tax"],
// //         subTot: json["sub_tot"],
// //         status: json["status"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "ref_id": refId,
// //         "product_id": productId,
// //         "unit": unit,
// //         "qty": qty,
// //         "tax": tax,
// //         "sub_tot": subTot,
// //         "status": status,
// //     };
// // }




// // To parse this JSON data, do
// //
// //     final purchaseDetailsModel = purchaseDetailsModelFromJson(jsonString);

// import 'dart:convert';

// PurchaseDetailsModel purchaseDetailsModelFromJson(String str) => PurchaseDetailsModel.fromJson(json.decode(str));

// String purchaseDetailsModelToJson(PurchaseDetailsModel data) => json.encode(data.toJson());

// class PurchaseDetailsModel {
//     bool? status;
//     String? purchaseId;
//     List<Details>? data;

//     PurchaseDetailsModel({
//         this.status,
//         this.purchaseId,
//         this.data,
//     });

//     factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) => PurchaseDetailsModel(
//         status: json["status"],
//         purchaseId: json["purchase_id"],
//         data: json["data"] == null ? [] : List<Details>.from(json["data"]!.map((x) => Details.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "purchase_id": purchaseId,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class Details {
//     int? id;
//     int? refId;
//     int? productId;
//     int? unit;
//     int? qty;
//     int? tax;
//     int? subTot;
//     int? status;
//     Product? product;

//     Details({
//         this.id,
//         this.refId,
//         this.productId,
//         this.unit,
//         this.qty,
//         this.tax,
//         this.subTot,
//         this.status,
//         this.product,
//     });

//     factory Details.fromJson(Map<String, dynamic> json) => Details  (
//         id: json["id"],
//         refId: json["ref_id"],
//         productId: json["product_id"],
//         unit: json["unit"],
//         qty: json["qty"],
//         tax: json["tax"],
//         subTot: json["sub_tot"],
//         status: json["status"],
//         product: json["product"] == null ? null : Product.fromJson(json["product"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "ref_id": refId,
//         "product_id": productId,
//         "unit": unit,
//         "qty": qty,
//         "tax": tax,
//         "sub_tot": subTot,
//         "status": status,
//         "product": product?.toJson(),
//     };
// }

// class Product {
//     int? id;
//     String? name;

//     Product({
//         this.id,
//         this.name,
//     });

//     factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//     };
// }


// To parse this JSON data, do
//
//     final purchaseDetailsModel = purchaseDetailsModelFromJson(jsonString);

import 'dart:convert';

PurchaseDetailsModel purchaseDetailsModelFromJson(String str) => PurchaseDetailsModel.fromJson(json.decode(str));

String purchaseDetailsModelToJson(PurchaseDetailsModel data) => json.encode(data.toJson());

class PurchaseDetailsModel {
    bool? status;
    String? purchaseId;
    List<Details>? data;

    PurchaseDetailsModel({
         this.status,
         this.purchaseId,
         this.data,
    });

    factory PurchaseDetailsModel.fromJson(Map<String, dynamic> json) => PurchaseDetailsModel(
        status: json["status"],
        purchaseId: json["purchase_id"]?.toString(),
        data: json["data"] == null ? [] : List<Details>.from(json["data"].map((x) => Details.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "purchase_id": purchaseId,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Details {
    int? id;
    int? refId;
    int? productId;
    int? unit;
    int? qty;
    String? salesRate;
    int? tax;
    int? subTot;
    int? status;
    Product? product;

    Details({
         this.id,
         this.refId,
         this.productId,
         this.unit,
         this.qty,
         this.salesRate,
         this.tax,
         this.subTot,
         this.status,
         this.product,
    });

    factory Details.fromJson(Map<String, dynamic> json) => Details(
        id: json["id"],
        refId: json["ref_id"],
        productId: json["product_id"],
        unit: json["unit"],
        qty: json["qty"],
        salesRate: json["sales_rate"]?.toString(),
        tax: json["tax"],
        subTot: json["sub_tot"],
        status: json["status"],
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ref_id": refId,
        "product_id": productId,
        "unit": unit,
        "qty": qty,
        "sales_rate": salesRate,
        "tax": tax,
        "sub_tot": subTot,
        "status": status,
        "product": product?.toJson(),
    };
}

class Product {
    int? id;
    String? code;
    String? name;

    Product({
         this.id,
         this.code,
         this.name,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        code: json["code"]?.toString(),
        name: json["name"]?.toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
    };
}
