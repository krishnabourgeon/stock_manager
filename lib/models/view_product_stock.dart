// // To parse this JSON data, do
// //
// //     final viewProductStock = viewProductStockFromJson(jsonString);

// import 'dart:convert';

// ViewProductStock viewProductStockFromJson(String str) =>
//     ViewProductStock.fromJson(json.decode(str));

// String viewProductStockToJson(ViewProductStock data) =>
//     json.encode(data.toJson());

// class ViewProductStock {
//   bool status;
//   List<ProductList> data;

//   ViewProductStock({
//     required this.status,
//     required this.data,
//   });

//   factory ViewProductStock.fromJson(Map<String, dynamic> json) =>
//       ViewProductStock(
//         status: json["status"] ?? false,
//         data: json["data"] == null
//             ? []
//             : List<ProductList>.from(
//                 json["data"].map((x) => ProductList.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class ProductList {
//   int id;
//   int refId;
//   int productId;
//   int unit;
//   int qty;
//   String salesRate;
//   int tax;
//   int subTot;
//   int status;
//   Product product;

//   ProductList({
//     required this.id,
//     required this.refId,
//     required this.productId,
//     required this.unit,
//     required this.qty,
//     required this.salesRate,
//     required this.tax,
//     required this.subTot,
//     required this.status,
//     required this.product,
//   });

//   factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
//         id: json["id"],
//         refId: json["ref_id"],
//         productId: json["product_id"],
//         unit: json["unit"],
//         qty: json["qty"],
//         salesRate: json["sales_rate"],
//         tax: json["tax"],
//         subTot: json["sub_tot"],
//         status: json["status"],
//         product: Product.fromJson(json["product"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "ref_id": refId,
//         "product_id": productId,
//         "unit": unit,
//         "qty": qty,
//         "sales_rate": salesRate,
//         "tax": tax,
//         "sub_tot": subTot,
//         "status": status,
//         "product": product.toJson(),
//       };
// }

// class Product {
//   int id;
//   String code;
//   String name;

//   Product({
//     required this.id,
//     required this.code,
//     required this.name,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         code: json["code"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "code": code,
//         "name": name,
//       };
// }






// To parse this JSON data, do
//
//     final viewProductStock = viewProductStockFromJson(jsonString);

import 'dart:convert';

ViewProductStock viewProductStockFromJson(String str) => ViewProductStock.fromJson(json.decode(str));

String viewProductStockToJson(ViewProductStock data) => json.encode(data.toJson());

class ViewProductStock {
    bool status;
    List<ProductList> data;

    ViewProductStock({
        required this.status,
        required this.data,
    });

    factory ViewProductStock.fromJson(Map<String, dynamic> json) => ViewProductStock(
        status: json["status"] ?? false,
        data: json["data"] == null
            ? []
            : List<ProductList>.from(
                json["data"].map((x) => ProductList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class ProductList {
    int id;
    int productid;
    int unitid;
    int qty;
    dynamic salesRate;
    String mode;
    DateTime addedDate;
    int user;
    int refId;
    dynamic date;
    int storeid;
    int status;
    String productCode;
    String productName;
    String invoiceNo;

    ProductList({
        required this.id,
        required this.productid,
        required this.unitid,
        required this.qty,
        required this.salesRate,
        required this.mode,
        required this.addedDate,
        required this.user,
        required this.refId,
        required this.date,
        required this.storeid,
        required this.status,
        required this.productCode,
        required this.productName,
        required this.invoiceNo,
    });

    factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
        id: json["id"] ?? 0,
        productid: json["productid"] ?? 0,
        unitid: json["unitid"] ?? 0,
        qty: json["qty"] ?? 0,
        salesRate: json["sales_rate"],
        mode: json["mode"] ?? "",
        addedDate: json["added_date"] == null ? DateTime.now() : DateTime.parse(json["added_date"]),
        user: json["user"] ?? 0,
        refId: json["ref_id"] ?? 0,
        date: json["date"],
        storeid: json["storeid"] ?? 0,
        status: json["status"] ?? 0,
        productCode: json["product_code"] ?? "1",
        productName: json["product_name"] ?? "Unknown",
        invoiceNo: json["invoice_no"] ?? "N/A",
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productid": productid,
        "unitid": unitid,
        "qty": qty,
        "sales_rate": salesRate,
        "mode": mode,
        "added_date": addedDate.toIso8601String(),
        "user": user,
        "ref_id": refId,
        "date": date,
        "storeid": storeid,
        "status": status,
        "product_code": productCode,
        "product_name": productName,
        "invoice_no": invoiceNo,
    };
}
