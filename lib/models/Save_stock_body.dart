class SaveStockBody {
  int supplierId;
  String date;
  int totalAmt;
  int totalTax;
  String? storeId;
  String? customerId;
  List<StockItem> items;

  SaveStockBody({
    required this.supplierId,
    required this.date,
    required this.totalAmt,
    required this.totalTax,
    required this.storeId,
     this.customerId,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        "supplier_id": supplierId,
        "date": date,
        "total_amt": totalAmt,
        "total_tax": totalTax,
        "storeid": storeId,  
        "customer_id": customerId,
        "items": items.map((e) => e.toJson()).toList(),
      };
}

class StockItem {
  int productId;
  String unit;
  int qty;
  int tax;
  int subTot;

  StockItem({
    required this.productId,
    required this.unit,
    required this.qty,
    required this.tax,
    required this.subTot,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "unit": unit,
        "qty": qty,
        "tax": tax,
        "sub_tot": subTot,
      };
}