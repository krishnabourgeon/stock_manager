import 'package:flutter/material.dart';
import 'package:stock_manager/common/common_functions.dart';
import 'package:stock_manager/models/Save_stock_body.dart';
import 'package:stock_manager/models/category_model.dart';
import 'package:stock_manager/models/delete_purchase_model.dart';
import 'package:stock_manager/models/get_all_product.dart';
import 'package:stock_manager/models/product_model.dart';
import 'package:stock_manager/models/purchase_details_model.dart';
import 'package:stock_manager/models/save_product_body.dart';
import 'package:stock_manager/models/save_product_model.dart';
import 'package:stock_manager/models/save_stock_model.dart';
import 'package:stock_manager/models/supplier_model.dart';
import 'package:stock_manager/models/unit_model.dart';
import 'package:stock_manager/models/view_product_stock.dart';
import 'package:stock_manager/models/view_purchase_model.dart';
import 'package:stock_manager/models/view_stock_model.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class StockProvider extends ChangeNotifier with ProviderHelperClass {
  ProductModel? productModel;
  SupplierModel? supplierModel;
  UnitModel? unitModel;
  CategoryModel? categoryModel;
  ViewStockModel? viewStockModel;
  ViewPurchaseModel? viewPurchaseModel;
  PurchaseDetailsModel? purchaseDetailsModel;
  ViewProductStock? viewProductStock;

  List<Datum> productList = [];
  List<Datum> allPoojaDataList = [];

  List<ProductList> viewProductStockList = [];
  List<ProductList> allViewProductStockList = [];

  List<Details> purchasedetailList = [];
  List<Details> allpurchasedetailList = [];

  List<Purchases> viewPurchaseList = [];
  List<Purchases> allViewPurchaseList = [];

  List<Data> supplierList = [];
  List<Data> allSupplierList = [];

  List<Unit> unitList = [];
  List<Unit> allUnitList = [];

  List<Cat> categoryList = [];
  List<Cat> allCategoryList = [];

  List<StockList> stockList = [];
  List<StockList> allStockList = [];

  String? selectedProductFilter;
  DateTime? fromDate;
  DateTime? toDate;
  List filterstockList = [];
  List allfilterStockList = [];
  int? selectedSupplierFilter;
  List<String> productNames = [];

  void setSupplierFilter(int? value) {
    selectedSupplierFilter = value;
    applyFilters(); // auto apply
    notifyListeners();
  }

// 🔽 SELECTION VARIABLES
  int? selectedSupplierId;
  int? selectedPurchaseId;
  DateTime? selectedInvoiceDate;

//  GET UNIQUE SUPPLIERS FROM PURCHASE LIST
// List<int> get supplierIds {
//   return viewPurchaseList
//       .map((e) => e.supplierId!)
//       .toSet()
//       .toList();
// }

//  FILTER INVOICES BASED ON SUPPLIER
  List<Purchases> get filteredInvoices {
    if (selectedSupplierId == null) return [];

    return viewPurchaseList
        .where((e) => e.supplierId == selectedSupplierId)
        .toList();
  }

//  SET SUPPLIER
  void setSupplier(int? id) {
    selectedSupplierId = id;

    // reset
    selectedPurchaseId = null;
    selectedInvoiceDate = null;
    purchasedetailList = [];

    notifyListeners();
  }

  List<Supplier> get uniqueSuppliers {
    final Map<int, Supplier> map = {};

    for (var purchase in viewPurchaseList) {
      if (purchase.supplier != null) {
        map[purchase.supplier!.id!] = purchase.supplier!;
      }
    }

    return map.values.toList();
  }

//  SET INVOICE + CALL DETAILS API
  void setInvoice(Purchases purchase) {
    selectedPurchaseId = purchase.id;
    selectedInvoiceDate = purchase.date;

    // API CALL
    getDetailPurchases(purchase.id.toString());

    notifyListeners();
  }

  /// Reset selection state when screen reloads
  void resetPurchaseSelection() {
    selectedSupplierId = null;
    selectedPurchaseId = null;
    selectedInvoiceDate = null;
    purchasedetailList = [];
    notifyListeners();
  }


  GetAllProduct? getAllProductModel;
List<AllProduct> allProductList = [];

Future<void> getAllProducts() async {
  final network = await CommonFunctions.checkInternetConnection();

  if (network) {
    updateLoadState(LoaderState.loading);

    try {
      var res = await serviceConfig.getAllProduct();

      if (res.isValue) {
        getAllProductModel = res.asValue!.value;

        if (getAllProductModel != null) {
          allProductList = getAllProductModel!.data;
        }
      }

      updateLoadState(LoaderState.loaded);
    } catch (e) {
      debugPrint('exception in all products: $e');
      updateLoadState(LoaderState.loaded);
    }
  }
}

  // Future<void> getProducts() async {
  //   final network = await CommonFunctions.checkInternetConnection();
  //   if (network) {
  //     updateLoadState(LoaderState.loading);
  //     try {
  //       var res = await serviceConfig.getProduct();
  //       if (res.isValue) {
  //         productModel = res.asValue!.value;
  //         if (productModel != null) {
  //           updateProductsList(productModel);
  //         }
  //         updateLoadState(LoaderState.loaded);
  //       } else {
  //         updateLoadState(LoaderState.loaded);
  //       }
  //     } catch (e) {
  //       debugPrint('exception in products: $e');
  //       updateLoadState(LoaderState.loaded);
  //     }
  //   }
  // }


  Future<void> getProducts({int? categoryId}) async {
  final network = await CommonFunctions.checkInternetConnection();

  if (network) {
    updateLoadState(LoaderState.loading);

    try {
      var res = await serviceConfig.getProduct(categoryId: categoryId);

      if (res.isValue) {
        productModel = res.asValue!.value;

        if (productModel != null) {
          updateProductsList(productModel);
        }
      }

      updateLoadState(LoaderState.loaded);
    } catch (e) {
      debugPrint('exception in products: $e');
      updateLoadState(LoaderState.loaded);
    }
  }
}

//   Future<void> deletePurchaseItem({
//   required String id,
//   required int index,
// }) async {
//   final network = await CommonFunctions.checkInternetConnection();

//   if (network) {
//     updateLoadState(LoaderState.loading);

//     try {
//       var res = await serviceConfig.deletePurchaseDetails(id);

//       if (res.isValue) {
//         DeletePurchaseModel response = res.asValue!.value;

//         // ✅ Remove item from list (instant UI update)
//         purchasedetailList.removeAt(index);

//         Helpers.successToast(response.message ?? "Deleted successfully");
//       } else {
//         Helpers.successToast("Delete failed");
//       }

//       updateLoadState(LoaderState.loaded);
//     } catch (e) {
//       debugPrint('exception in delete purchase: $e');
//       updateLoadState(LoaderState.loaded);
//     }
//   }
// }

  Future<void> deletePurchaseItem({
    required String id,
    required String productId, // ✅ added
    required int index,
  }) async {
    final network = await CommonFunctions.checkInternetConnection();

    if (network) {
      updateLoadState(LoaderState.loading);

      try {
        var res = await serviceConfig.deletePurchaseDetails(id, productId);

        if (res.isValue) {
          DeletePurchaseModel response = res.asValue!.value;

          purchasedetailList.removeAt(index);

          Helpers.successToast(response.message ?? "Deleted successfully");
        } else {
          Helpers.successToast("Delete failed");
        }

        updateLoadState(LoaderState.loaded);
      } catch (e) {
        debugPrint('exception in delete purchase: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  void setProductFilter(String? value) {
    selectedProductFilter = value;
    notifyListeners();
  }

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  String formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

// void applyFilters() {
//   List tempList = allfilterStockList;

//   /// 🔍 PRODUCT FILTER
//   if (selectedProductFilter != null) {
//     tempList = tempList
//         .where((e) => e.name == selectedProductFilter)
//         .toList();
//   }

//   /// 📅 DATE FILTER
//   if (fromDate != null && toDate != null) {
//     tempList = tempList.where((e) {
//       final stockDate = DateTime.parse(e.date); // ensure API gives date
//       return stockDate.isAfter(fromDate!.subtract(const Duration(days: 1))) &&
//           stockDate.isBefore(toDate!.add(const Duration(days: 1)));
//     }).toList();
//   }

//   filterstockList = tempList;
//   notifyListeners();
// }

// void clearFilters() {
//   selectedProductFilter = null;
//   fromDate = null;
//   toDate = null;
//   stockList = allStockList;
//   notifyListeners();
// }

  void applyFilters() {
    List<StockList> tempList = List.from(allStockList);

    /// 🔍 SUPPLIER FILTER
    if (selectedSupplierFilter != null) {
      tempList =
          tempList.where((e) => e.name == selectedSupplierFilter).toList();
    }

    /// 📅 DATE FILTER
    // if (fromDate != null && toDate != null) {
    //   tempList = tempList.where((e) {
    //     //final stockDate = DateTime.parse(e.date);
    //     return stockDate.isAfter(fromDate!.subtract(const Duration(days: 1))) &&
    //         stockDate.isBefore(toDate!.add(const Duration(days: 1)));
    //   }).toList();
    // }

    stockList = tempList;
    notifyListeners();
  }

  Future<void> getSuppliers() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getSupplier();
        if (res.isValue) {
          supplierModel = res.asValue!.value;
          if (supplierModel != null) {
            updateSuppliersList(supplierModel);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in suppliers: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  Future<void> getViewProductStock(String productid) async {
    final network = await CommonFunctions.checkInternetConnection();
    viewProductStockList = [];
    allViewProductStockList = [];
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.viewProductStock(productid);
        if (res.isValue) {
          ViewProductStock viewProductStock = res.asValue!.value;
          if (viewProductStock != null) {
            updateViewProductStockList(viewProductStock);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in suppliers: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  Future<void> getViewPurchases() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getPurchases();
        if (res.isValue) {
          viewPurchaseModel = res.asValue!.value;
          if (viewPurchaseModel != null) {
            updatePurchasesList(viewPurchaseModel);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in suppliers: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  Future<void> getDetailPurchases(String id) async {
    final network = await CommonFunctions.checkInternetConnection();
    purchasedetailList = [];
    if (network) {
      updateLoadState(LoaderState.loading);

      try {
        var res = await serviceConfig.purchaseDetails(id);

        if (res.isValue) {
          purchaseDetailsModel = res.asValue!.value;

          purchasedetailList = purchaseDetailsModel?.data ?? [];
        }

        updateLoadState(LoaderState.loaded);
      } catch (e) {
        debugPrint('exception in purchase details: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

//   Future<void> getStockList() async {
//   final network = await CommonFunctions.checkInternetConnection();

//   if (network) {
//     updateLoadState(LoaderState.loading);

//     try {
//       var res = await serviceConfig.getStockList();

//       if (res.isValue) {
//         viewStockModel = res.asValue!.value;

//         if (viewStockModel != null) {
//           updateStockList(viewStockModel);
//         }
//       }

//       updateLoadState(LoaderState.loaded);
//     } catch (e) {
//       debugPrint('exception in stock list: $e');
//       updateLoadState(LoaderState.loaded);
//     }
//   }
// }

  Future<void> getStockList({
    String? fromDate,
    String? toDate,
    int? supplierId,
  }) async {
    final network = await CommonFunctions.checkInternetConnection();

    if (network) {
      updateLoadState(LoaderState.loading);

      try {
        var res = await serviceConfig.getStockList(
          fromDate: fromDate,
          toDate: toDate,
          supplierId: supplierId,
        );

        if (res.isValue) {
          viewStockModel = res.asValue!.value;

          if (viewStockModel != null) {
            stockList = viewStockModel!.data ?? [];
          }
        }
        updateLoadState(LoaderState.loaded);
      } catch (e) {
        debugPrint('exception in stock list: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }

  Future<void> getUnits() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getUnit();
        if (res.isValue) {
          unitModel = res.asValue!.value;
          if (unitModel != null) {
            updateUnitsList(unitModel);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in units: $e');
        updateLoadState(LoaderState.loaded);
      }
    }
  }


  Future<void> saveProduct({
  required String name,
  required String code,
  required String unit,
  required String price,
  required String categoryId,
  Function? onSuccess,
  Function? onFailure,
}) async {
  final network = await CommonFunctions.checkInternetConnection();

  if (network) {
    updateLoadState(LoaderState.loading);

    try {
      /// 🔹 CREATE BODY
      SaveProductBody body = SaveProductBody(
        code: code,
        name: name,
        catId: categoryId,
        unit: unit,
        price: price,
        storeId: AppConfig.storeId.toString(),
      );

      debugPrint("SAVE PRODUCT BODY: ${body.toJson()}");

      /// 🔹 API CALL
      var res = await serviceConfig.saveProduct(body);

      if (res.isValue) {
        SaveProductModel response = res.asValue!.value;

        Helpers.successToast("Product Added Successfully");

        if (onSuccess != null) onSuccess();
      } else {
        Helpers.successToast("Failed to add product");

        if (onFailure != null) onFailure();
      }

      updateLoadState(LoaderState.loaded);
    } catch (e) {
      debugPrint("save product error: $e");
      updateLoadState(LoaderState.loaded);
      Helpers.successToast("Something went wrong");
    }
  }
}



  // Future<void> getCategories() async {
  //   final network = await CommonFunctions.checkInternetConnection();
  //   if (network) {
  //     updateLoadState(LoaderState.loading);
  //     try {
  //       var res = await serviceConfig.getCategory();
  //       if (res.isValue) {
  //         categoryModel = res.asValue!.value;
  //         if (categoryModel != null) {
  //           updateCategoriesList(categoryModel);
  //         }
  //         updateLoadState(LoaderState.loaded);
  //       } else {
  //         updateLoadState(LoaderState.loaded);
  //       }
  //     } catch (e) {
  //       debugPrint('exception in categories: $e');
  //       updateLoadState(LoaderState.loaded);
  //     }
  //   }
  // }

  Future<void> getCategories({int? categoryId}) async {
  final network = await CommonFunctions.checkInternetConnection();

  if (network) {
    updateLoadState(LoaderState.loading);

    try {
      var res = await serviceConfig.getCategory(categoryId: categoryId);

      if (res.isValue) {
        categoryModel = res.asValue!.value;

        if (categoryModel != null) {
          updateCategoriesList(categoryModel);
        }
      }

      updateLoadState(LoaderState.loaded);
    } catch (e) {
      debugPrint('exception in categories: $e');
      updateLoadState(LoaderState.loaded);
    }
  }
}

  Future<void> saveStock({
    required List<Map<String, dynamic>> addedStocks,
    required String invoiceNo,
    required DateTime date,
    // required DateTime fromDate,
    // required DateTime toDate,
    Function? onSuccess,
    Function? onFailure,
    bool enableLoaderState = false,
  }) async {
    final network = await CommonFunctions.checkInternetConnection();

    if (network) {
      if (enableLoaderState) updateBtnLoader(true);
      if (!enableLoaderState) updateLoadState(LoaderState.loading);

      try {
        //  Convert UI → API
        List<StockItem> items = addedStocks.map((e) {
          return StockItem(
            productId: e['product'],
            unit: e['unit'], // must be STRING (pcs, kg...)
            qty: int.parse(e['qty'].toString()),
            tax: 0,
            subTot: int.parse(e['rate'].toString()), //  RATE HERE
            salesRate: int.parse(e['salesRate'].toString()),
          );
        }).toList();
        debugPrint("salesRate: ${addedStocks.first['salesRate']}");
        //  FIXED (num → int issue solved)
        int totalAmt = addedStocks.fold<int>(
          0,
          (sum, item) {
            double value = double.tryParse(item['total'].toString()) ?? 0;
            return sum + value.toInt();
          },
        );

        int totalTax = 0;

        SaveStockBody body = SaveStockBody(
          supplierId: addedStocks.first['supplier'],
          purchaseDate: date.toString().split(' ')[0],
          totalAmt: totalAmt,
          totalTax: totalTax,
          items: items,
          invoiceNo: invoiceNo,
          // fromDate: fromDate.toString().split(' ')[0],
          // toDate: toDate.toString().split(' ')[0],
          storeId: AppConfig.storeId,
        );

        print("REQUEST BODY: ${body.toJson()}"); //  debug
        print("=========== STOCK SAVE DEBUG ===========");
        print("Invoice No: $invoiceNo");
        print("Purchase Date: ${date.toString().split(' ')[0]}");
        print("Supplier ID: ${addedStocks.first['supplier']}");
        print("Total Amount: $totalAmt");
        print("Items: ${items.map((e) => e.toJson()).toList()}");
        print("Final JSON: ${body.toJson()}");
        print("========================================");

        var res = await serviceConfig.saveStock(body);

        if (res.isValue) {
          SaveStockModel response = res.asValue!.value;

          if (onSuccess != null) onSuccess();

          Helpers.successToast(response.message);
        } else {
          if (onFailure != null) onFailure();
        }

        if (enableLoaderState) updateBtnLoader(false);
        if (!enableLoaderState) updateLoadState(LoaderState.loaded);
      } catch (e) {
        debugPrint('exception in save stock: $e');

        if (enableLoaderState) updateBtnLoader(false);
        if (!enableLoaderState) updateLoadState(LoaderState.loaded);

        Helpers.successToast('Internal Server Error...');
      }
    }
  }

  updateStockList(ViewStockModel? viewStockModel) {
    stockList = viewStockModel?.data ?? [];
    allStockList = viewStockModel?.data ?? [];
    notifyListeners();
  }

  updateProductsList(ProductModel? productModel) {
    productList = productModel?.data ?? [];
    allPoojaDataList = productModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updatePurchasesList(ViewPurchaseModel? viewPurchaseModel) {
    viewPurchaseList = viewPurchaseModel?.data ?? [];
    allViewPurchaseList = viewPurchaseModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updateDetailPurchasesList(PurchaseDetailsModel? purchaseDetailsModel) {
    purchasedetailList = purchaseDetailsModel?.data ?? [];
    allpurchasedetailList = purchaseDetailsModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updateSuppliersList(SupplierModel? supplierModel) {
    supplierList = supplierModel?.data ?? [];
    allSupplierList = supplierModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updateViewProductStockList(ViewProductStock? viewProductStock) {
    viewProductStockList = viewProductStock?.data ?? [];
    allViewProductStockList = viewProductStock?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updateUnitsList(UnitModel? unitModel) {
    unitList = unitModel?.data ?? [];
    allUnitList = unitModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  updateCategoriesList(CategoryModel? categoryModel) {
    categoryList = categoryModel?.data ?? [];
    allCategoryList = categoryModel?.data ?? [];
    // updateDeityId('${deitiesList[0].id}');  // cleared
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}
