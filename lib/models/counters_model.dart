import 'dart:convert';

CounterModel counterModelFromJson(String str) =>
    CounterModel.fromJson(json.decode(str));
String counterModelToJson(CounterModel data) => json.encode(data.toJson());

class CounterModel {
  CounterModel({
    this.status,
    this.data,
  });
  bool? status;
  List<Datum>? data;
  factory CounterModel.fromJson(Map<String, dynamic> json) => CounterModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.store
  });
  int? id;
  String? name;
  int? store;
  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        store: json["store"]
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "store": store
      };
}
