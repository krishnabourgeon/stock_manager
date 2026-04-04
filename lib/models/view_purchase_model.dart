// // To parse this JSON data, do
// //
// //     final viewPurchaseModel = viewPurchaseModelFromJson(jsonString);

// import 'dart:convert';

// ViewPurchaseModel viewPurchaseModelFromJson(String str) => ViewPurchaseModel.fromJson(json.decode(str));

// String viewPurchaseModelToJson(ViewPurchaseModel data) => json.encode(data.toJson());

// class ViewPurchaseModel {
//     bool? status;
//     List<Purchases>? data;

//     ViewPurchaseModel({
//         this.status,
//         this.data,
//     });

//     factory ViewPurchaseModel.fromJson(Map<String, dynamic> json) => ViewPurchaseModel(
//         status: json["status"],
//         data: json["data"] == null ? [] : List<Purchases>.from(json["data"]!.map((x) => Purchases.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "status": status,
//         "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//     };
// }

// class Purchases {
//     int? id;
//     int? supplierId;
//     String? invoiceNo;
//     DateTime? date;
//     int? totalAmt;
//     int? totalTax;
//     int? status;
//     int? discount;

//     Purchases({
//         this.id,
//         this.supplierId,
//         this.invoiceNo,
//         this.date,
//         this.totalAmt,
//         this.totalTax,
//         this.status,
//         this.discount,
//     });

//     factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
//         id: json["id"],
//         supplierId: json["supplier_id"],
//         invoiceNo: json["invoice_no"],
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         totalAmt: json["total_amt"],
//         totalTax: json["total_tax"],
//         status: json["status"],
//         discount: json["discount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "supplier_id": supplierId,
//         "invoice_no": invoiceNo,
//         "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "total_amt": totalAmt,
//         "total_tax": totalTax,
//         "status": status,
//         "discount": discount,
//     };
// }



import 'dart:convert';

ViewPurchaseModel viewPurchaseModelFromJson(String str) =>
    ViewPurchaseModel.fromJson(json.decode(str));

String viewPurchaseModelToJson(ViewPurchaseModel data) =>
    json.encode(data.toJson());

class ViewPurchaseModel {
  bool? status;
  List<Purchases>? data;

  ViewPurchaseModel({
    this.status,
    this.data,
  });

  factory ViewPurchaseModel.fromJson(Map<String, dynamic> json) =>
      ViewPurchaseModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Purchases>.from(
                json["data"].map((x) => Purchases.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Purchases {
  int? id;
  int? supplierId;
  String? invoiceNo;
  DateTime? date;
  int? totalAmt;
  int? totalTax;
  int? status;
  int? discount;
  Supplier? supplier;

  Purchases({
    this.id,
    this.supplierId,
    this.invoiceNo,
    this.date,
    this.totalAmt,
    this.totalTax,
    this.status,
    this.discount,
    this.supplier,
  });

  factory Purchases.fromJson(Map<String, dynamic> json) => Purchases(
        id: json["id"],
        supplierId: json["supplier_id"],
        invoiceNo: json["invoice_no"],
        date: json["date"] != null
            ? DateTime.tryParse(json["date"])
            : null,
        totalAmt: json["total_amt"],
        totalTax: json["total_tax"],
        status: json["status"],
        discount: json["discount"],
        supplier: json["supplier"] != null
            ? Supplier.fromJson(json["supplier"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "supplier_id": supplierId,
        "invoice_no": invoiceNo,
        "date": date?.toIso8601String(),
        "total_amt": totalAmt,
        "total_tax": totalTax,
        "status": status,
        "discount": discount,
        "supplier": supplier?.toJson(),
      };
}

class Supplier {
  int? id;
  String? name;

  Supplier({
    this.id,
    this.name,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json["id"],
        name: json["name"], // ✅ direct string
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}