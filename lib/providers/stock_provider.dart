import 'package:flutter/material.dart';
import 'package:stock_manager/common/common_functions.dart';
import 'package:stock_manager/models/Save_stock_body.dart';
import 'package:stock_manager/models/category_model.dart';
import 'package:stock_manager/models/product_model.dart';
import 'package:stock_manager/models/save_stock_model.dart';
import 'package:stock_manager/models/supplier_model.dart';
import 'package:stock_manager/models/unit_model.dart';
import 'package:stock_manager/models/view_stock_model.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class StockProvider extends ChangeNotifier with ProviderHelperClass{

ProductModel? productModel;
SupplierModel? supplierModel;
UnitModel? unitModel;
CategoryModel? categoryModel;
ViewStockModel? viewStockModel;

List<Datum> productList = [];
List<Datum> allPoojaDataList = [];  

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

Future<void> getProducts() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getProduct();
        if (res.isValue) {
          productModel = res.asValue!.value;
          if (productModel != null) {
            updateProductsList(productModel);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
      } catch (e) {
        debugPrint('exception in products: $e');
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
    tempList = tempList
        .where((e) => e.name == selectedSupplierFilter)
        .toList();
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


  Future<void> getCategories() async {
    final network = await CommonFunctions.checkInternetConnection();
    if (network) {
      updateLoadState(LoaderState.loading);
      try {
        var res = await serviceConfig.getCategory();
        if (res.isValue) {
          categoryModel = res.asValue!.value;
          if (categoryModel != null) {
            updateCategoriesList(categoryModel);
          }
          updateLoadState(LoaderState.loaded);
        } else {
          updateLoadState(LoaderState.loaded);
        }
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
        );
      }).toList();

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

  updateSuppliersList(SupplierModel? supplierModel) {
    supplierList = supplierModel?.data ?? [];
    allSupplierList = supplierModel?.data ?? [];
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