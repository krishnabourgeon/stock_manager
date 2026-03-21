// To parse this JSON data, do
//
//     final viewStockModel = viewStockModelFromJson(jsonString);

import 'dart:convert';

ViewStockModel viewStockModelFromJson(String str) => ViewStockModel.fromJson(json.decode(str));

String viewStockModelToJson(ViewStockModel data) => json.encode(data.toJson());

class ViewStockModel {
    bool status;
    List<StockList> data;

    ViewStockModel({
        required this.status,
        required this.data,
    });

    factory ViewStockModel.fromJson(Map<String, dynamic> json) => ViewStockModel(
        status: json["status"],
        data: List<StockList>.from(json["data"].map((x) => StockList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class StockList {
    double total;
    int productid;

    StockList({
        required this.total,
        required this.productid,
    });

    factory StockList.fromJson(Map<String, dynamic> json) => StockList(
        total: json["total"]?.toDouble(),
        productid: json["productid"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "productid": productid,
    };
}
