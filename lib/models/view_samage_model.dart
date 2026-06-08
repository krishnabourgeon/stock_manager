class ViewDamageModel {
  bool? status;
  List<DamageMessage>? message;

  ViewDamageModel({
    this.status,
    this.message,
  });

  factory ViewDamageModel.fromJson(Map<String, dynamic> json) {
    return ViewDamageModel(
      status: json["status"],
      message: json["message"] == null
          ? []
          : List<DamageMessage>.from(
              json["message"].map((x) => DamageMessage.fromJson(x)),
            ),
    );
  }
}

class DamageMessage {
  String? productName;
  String? addedDate;
  int? qty;
  String? reason;
  String? unitName;

  DamageMessage({
    this.productName,
    this.addedDate,
    this.qty,
    this.reason,
    this.unitName,
  });

  factory DamageMessage.fromJson(Map<String, dynamic> json) {
    return DamageMessage(
      productName: json["product_name"]?.toString(),
      addedDate: json["added_date"]?.toString(),
      qty: json["qty"] ?? 0,
      reason: json["reason"]?.toString(),
      unitName: json["unit_name"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "product_name": productName,
      "added_date": addedDate,
      "qty": qty,
      "reason": reason,
      "unit_name": unitName,
    };
  }
}