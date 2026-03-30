import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_manager/common/common_button.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/models/category_model.dart';
import 'package:stock_manager/models/unit_model.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/models/product_model.dart';
import 'package:stock_manager/models/supplier_model.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';
class AddStock extends StatefulWidget {
  const AddStock({super.key});

  @override
  State<AddStock> createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  int qty = 0;
  int? selectedSupplierId;
  int? selectedCategoryId;
  int? selectedProductId;
  int? selectedUnitId;
  final TextEditingController qtyController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSupplierLocked = false;
  String? selectedUnitName;
  TextEditingController invoiceController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;
  DateTime? selectedDate;
  

  List<Map<String, dynamic>> addedStocks = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getProducts();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getSuppliers();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getUnits();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getCategories();
    });
  }

  

//  void _saveAndNext() {
//   if (formKey.currentState!.validate()) {
//     setState(() {
//       addedStocks.add({
//         'supplier': selectedSupplier?.id,
//         'category': selectedCategory?.id,
//         'product': selectedProduct?.id,
//         'unit': selectedUnit?.id,
//         'qty': qtyController.text,
//         'rate': rateController.text,
//         'date': DateTime.now(),
//         'customerName': AppConfig.customerName
//       });

//       selectedSupplier = null;
//       selectedCategory = null;
//       selectedProduct = null;
//       selectedUnit = null;

//       qty = 0;
//       qtyController.clear();
//       rateController.clear();
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Stock added to list')),
//     );
//   }
// }


// void _saveAndNext() {
//   if (formKey.currentState!.validate()) {
//     double qtyValue = double.tryParse(qtyController.text) ?? 0;
//     double rateValue = double.tryParse(rateController.text) ?? 0;
//     double total = qtyValue * rateValue;

//     setState(() {
//       addedStocks.add({
//         'supplier': selectedSupplierId,
//         'category': selectedCategoryId,
//         'product': selectedProductId,
//         'unit': selectedUnitId,
//         'qty': qtyController.text,
//         'rate': rateController.text,
//         'total': total, //  ADD THIS
//         'date': DateTime.now(),
//         'customerName': AppConfig.customerName
//       });

//       //selectedSupplierId = null;
//        isSupplierLocked = true;
//       selectedCategoryId = null;
//       selectedProductId = null;
//       selectedUnitId = null;

//       qty = 0;
//       qtyController.clear();
//       rateController.clear();
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Stock added (Total: ₹$total)')),
//     );
//   }
// }

// Future<void> selectDate(BuildContext context, bool isFromDate) async {
//   DateTime? picked = await showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime(2000),
//     lastDate: DateTime(2100),
//   );

//   if (picked != null) {
//     setState(() {
//       if (isFromDate) {
//         fromDate = picked;
//       } else {
//         toDate = picked;
//       }
//     });
//   }
// }


Future<void> pickDate() async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (picked != null) {
    setState(() {
      selectedDate = picked;
    });
  }
}



void _saveAndNext() {
  if (formKey.currentState!.validate()) {
    double qtyValue = double.tryParse(qtyController.text) ?? 0;
    double rateValue = double.tryParse(rateController.text) ?? 0;
    double total = qtyValue * rateValue;

    setState(() {
      addedStocks.add({
        'supplier': selectedSupplierId,
        'product': selectedProductId,
        'unit': selectedUnitName, 
        'qty': qtyValue.toInt(),  
        'rate': rateValue.toInt(),
        'total': total,
      });

      isSupplierLocked = true;

      selectedCategoryId = null;
      selectedProductId = null;
      selectedUnitId = null;

      qty = 0;
      qtyController.clear();
      rateController.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Stock added (₹$total)')),
    );
  }
}

// void _saveAll() {
//   if (formKey.currentState!.validate()) {
//     // ALWAYS add current item before saving
//     addedStocks.add({
//       'supplier': selectedSupplier?.id,
//       'category': selectedCategory?.id,
//       'product': selectedProduct?.id,
//       'unit': selectedUnit?.id,
//       'qty': qtyController.text,
//       'rate': rateController.text,
//       'date': DateTime.now()
//     });
//   }

//   if (addedStocks.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('No stocks to save')),
//     );
//     return;
//   }

//   ScaffoldMessenger.of(context).showSnackBar(
//     const SnackBar(content: Text('All stocks saved successfully!')),
//   );

//   Navigator.pop(context, addedStocks);
// }


// void _saveAll() {
//   if (formKey.currentState!.validate()) {
//     double qtyValue = double.tryParse(qtyController.text) ?? 0;
//     double rateValue = double.tryParse(rateController.text) ?? 0;
//     double total = qtyValue * rateValue;

//     addedStocks.add({
//       'supplier': selectedSupplierId,
//       'category': selectedCategoryId,
//       'product': selectedProductId,
//       'unit': selectedUnitId,
//       'qty': qtyController.text,
//       'rate': rateController.text,
//       'total': total, // ✅ ADD THIS
//       'date': DateTime.now()
//     });
//   }

//   if (addedStocks.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('No stocks to save')),
//     );
//     return;
//   }

//   // ✅ Calculate GRAND TOTAL
//   double grandTotal = addedStocks.fold(
//     0,
//     (sum, item) => sum + (item['total'] ?? 0),
//   );

//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text('Saved! Grand Total: ₹$grandTotal')),
//   );

//   Navigator.pop(context, addedStocks);
// }



// void _saveAll() {
//   //  Validate form
//   if (formKey.currentState!.validate()) {
//     double qtyValue = double.tryParse(qtyController.text) ?? 0;
//     double rateValue = double.tryParse(rateController.text) ?? 0;
//     double total = qtyValue * rateValue;

//     //  Add current item before saving
//     addedStocks.add({
//       'supplier': selectedSupplierId,
//       'product': selectedProductId,
//       'unit': selectedUnitName, //  must be STRING (pcs, kg...)
//       'qty': qtyValue.toInt(),
//       'rate': rateValue.toInt(),
//       'total': total,
//     });
//   }

//   //  Check empty list
//   if (addedStocks.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('No stocks to save')),
//     );
//     return;
//   }

//   //  Validate supplier
//   if (selectedSupplierId == null) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Please select supplier')),
//     );
//     return;
//   }

//   //  Calculate GRAND TOTAL (FIXED TYPE)
//   double grandTotal = addedStocks.fold(
//     0.0,
//     (sum, item) => sum + ((item['total'] ?? 0) as num).toDouble(),
//   );

//   //  Show total (optional)
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(content: Text('Grand Total: ₹${grandTotal.toStringAsFixed(2)}')),
//   );

//   //  CALL API
//   context.read<StockProvider>().saveStock(
//     addedStocks: addedStocks,
//     onSuccess: () {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Stock saved successfully')),
//       );
      
//       //  Reset UI after success
//       setState(() {
//         addedStocks.clear();
//         isSupplierLocked = false;
//         selectedSupplierId = null;
//         selectedProductId = null;
//         selectedUnitId = null;
//         selectedUnitName = null;
//         qty = 0;
//         qtyController.clear();
//         rateController.clear();
//       });

//       Navigator.pop(context);
//     },
//     onFailure: () {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to save stock')),
//       );
//     },
//   );
// }



void _saveAll() async {
  //  Validate form
  if (formKey.currentState!.validate()) {
    double qtyValue = double.tryParse(qtyController.text) ?? 0;
    double rateValue = double.tryParse(rateController.text) ?? 0;
    double total = qtyValue * rateValue;

    //  Add current item before saving
    addedStocks.add({
      'supplier': selectedSupplierId,
      'product': selectedProductId,
      'unit': selectedUnitName, // must be STRING (kg, pcs...)
      'qty': qtyValue.toInt(),
      'rate': rateValue.toInt(),
      'total': total,
    });
  }

  //  Check empty list
  if (addedStocks.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No stocks to save')),
    );
    return;
  }

  //  Validate supplier
  if (selectedSupplierId == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select supplier')),
    );
    return;
  }

  if (invoiceController.text.isEmpty) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Enter invoice number')),
  );
  return;
}

if (selectedDate == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please select date')),
  );
  return;
}

  //   LOAD STORE ID (VERY IMPORTANT FIX)
  await SharedPreferenceHelper.getStoreID();

  //  DEBUG (check in console)
  print("STORE ID BEFORE API: ${AppConfig.storeId}");

  //   SAFETY CHECK
  if (AppConfig.storeId == null || AppConfig.storeId!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Store ID missing. Please login again')),
    );
    return;
  }

  //  Calculate GRAND TOTAL
  double grandTotal = addedStocks.fold(
    0.0,
    (sum, item) => sum + ((item['total'] ?? 0) as num).toDouble(),
  );

  //  Show total (optional)
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Grand Total: ₹${grandTotal.toStringAsFixed(2)}'),
    ),
  );

  //  CALL API
  context.read<StockProvider>().saveStock(
    addedStocks: addedStocks,
    invoiceNo: invoiceController.text,
    // fromDate: fromDate!,
    // toDate: toDate!,
    date: selectedDate!, 
    onSuccess: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Stock saved successfully')),
      );

      //  Reset UI after success
      setState(() {
        addedStocks.clear();
        isSupplierLocked = false;
        selectedSupplierId = null;
        selectedProductId = null;
        selectedUnitId = null;
        selectedUnitName = null;
        qty = 0;
        qtyController.clear();
        rateController.clear();
      });

      Navigator.pop(context);
    },
    onFailure: () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to save stock')),
      );
    },
  );
}


double getCombinedTotal() {
  double existingTotal = addedStocks.fold(
    0,
    (sum, item) => sum + (item['total'] ?? 0),
  );

  double currentQty = double.tryParse(qtyController.text) ?? 0;
  double currentRate = double.tryParse(rateController.text) ?? 0;
  double currentTotal = currentQty * currentRate;

  return existingTotal + currentTotal;
}

  @override
  void dispose() {
    qtyController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Add Stock', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Consumer<StockProvider>(
                        builder: (context, stockProvider, child) {
                          return 
                          // DropdownButtonFormField<int>(
                          //   decoration: InputDecoration(
                          //     labelText: "Select Supplier",
                          //     border: const OutlineInputBorder(),
                          //     prefixIcon: stockProvider.loaderState == LoaderState.loading
                          //         ? const Padding(
                          //             padding: EdgeInsets.all(12.0),
                          //             child: SizedBox(
                          //               width: 20,
                          //               height: 20,
                          //               child: CircularProgressIndicator(strokeWidth: 2),
                          //             ),
                          //           )
                          //         : null,
                          //   ),
                          //   value: stockProvider.supplierList.any((e) => e.id == selectedSupplierId) ? selectedSupplierId : null,
                          //   items: stockProvider.supplierList.isEmpty
                          //       ? const [
                          //           DropdownMenuItem<int>(
                          //             value: null,
                          //             child: Text("No suppliers available"),
                          //           )
                          //         ]
                          //       : stockProvider.supplierList
                          //           .fold<List<Data>>([], (prev, item) {
                          //             if (!prev.any((e) => e.id == item.id)) prev.add(item);
                          //             return prev;
                          //           })
                          //           .map((item) => DropdownMenuItem<int>(
                          //                 value: item.id,
                          //                 child: Text(item.name.toString()),
                          //               ))
                          //           .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       selectedSupplierId = value;
                          //     });
                          //   },
                          //   validator: (value) {
                          //     if (value == null) {
                          //       return "Please select supplier";
                          //     }
                          //     return null;
                          //   },
                          // );
                          DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: isSupplierLocked ? "Supplier (Locked)" : "Select Supplier",
                              border: const OutlineInputBorder(),
                              filled: isSupplierLocked,
                              fillColor: isSupplierLocked ? Colors.grey.shade200 : null,
                              prefixIcon: stockProvider.loaderState == LoaderState.loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    )
                                  : null,
                            ),

                            value: stockProvider.supplierList.any((e) => e.id == selectedSupplierId)
                                ? selectedSupplierId
                                : null,

                            items: stockProvider.supplierList.isEmpty
                                ? const [
                                    DropdownMenuItem<int>(
                                      value: null,
                                      child: Text("No suppliers available"),
                                    )
                                  ]
                                : stockProvider.supplierList
                                    .fold<List<Data>>([], (prev, item) {
                                      if (!prev.any((e) => e.id == item.id)) prev.add(item);
                                      return prev;
                                    })
                                    .map((item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: Text(item.name.toString()),
                                        ))
                                    .toList(),

                            //  IMPORTANT CHANGE HERE
                            onChanged: isSupplierLocked
                                ? null
                                : (value) {
                                    setState(() {
                                      selectedSupplierId = value;
                                    });
                                  },

                            validator: (value) {
                              if (value == null) {
                                return "Please select supplier";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.verticalSpace,
                      10.verticalSpace,

/// 🔹 INVOICE + DATE (SAME ROW)
Row(
  children: [
    /// 📄 Invoice Number
    Expanded(
      child: TextFormField(
        controller: invoiceController,
        decoration: const InputDecoration(
          labelText: "Invoice No",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter invoice";
          }
          return null;
        },
      ),
    ),

    SizedBox(width: 10.w),

    /// 📅 Date Picker
    Expanded(
      child: InkWell(
        onTap: pickDate,
        child: InputDecorator(
          decoration: const InputDecoration(
            labelText: "Date",
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          child: Text(
            selectedDate == null
                ? "Select"
                : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
          ),
        ),
      ),
    ),
  ],
),

10.verticalSpace,
                      Consumer<StockProvider>(
                        builder: (context, stockProvider, child) {
                          return DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Select Category",
                              border: const OutlineInputBorder(),
                              prefixIcon: stockProvider.loaderState == LoaderState.loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    )
                                  : null,
                            ),
                            value: stockProvider.categoryList.any((e) => e.id == selectedCategoryId) ? selectedCategoryId : null,
                            items: stockProvider.categoryList.isEmpty
                                ? const [
                                    DropdownMenuItem<int>(
                                      value: null,
                                      child: Text("No categories available"),
                                    )
                                  ]
                                : stockProvider.categoryList
                                    .fold<List<Cat>>([], (prev, item) {
                                      if (!prev.any((e) => e.id == item.id)) prev.add(item);
                                      return prev;
                                    })
                                    .map((item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: Text(item.name.toString()),
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCategoryId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select category";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.verticalSpace,
                      Consumer<StockProvider>(
                        builder: (context, stockProvider, child) {
                          return DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Select Product",
                              border: const OutlineInputBorder(),
                              prefixIcon: stockProvider.loaderState == LoaderState.loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    )
                                  : null,
                            ),
                            value: stockProvider.productList.any((e) => e.id == selectedProductId) ? selectedProductId : null,
                            items: stockProvider.productList.isEmpty
                                ? const [
                                    DropdownMenuItem<int>(
                                      value: null,
                                      child: Text("No products available"),
                                    )
                                  ]
                                : stockProvider.productList
                                    .fold<List<Datum>>([], (prev, item) {
                                      if (!prev.any((e) => e.id == item.id)) prev.add(item);
                                      return prev;
                                    })
                                    .map((item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: Text(item.name.toString()),
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedProductId = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select product";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                       10.verticalSpace,
                      Consumer<StockProvider>(
                        builder: (context, stockProvider, child) {
                          return DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: "Select Unit",
                              border: const OutlineInputBorder(),
                              prefixIcon: stockProvider.loaderState == LoaderState.loading
                                  ? const Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    )
                                  : null,
                            ),
                            value: stockProvider.unitList.any((e) => e.id == selectedUnitId) ? selectedUnitId : null,
                            items: stockProvider.unitList.isEmpty
                                ? const [
                                    DropdownMenuItem<int>(
                                      value: null,
                                      child: Text("No units available"),
                                    )
                                  ]
                                : stockProvider.unitList
                                    .fold<List<Unit>>([], (prev, item) {
                                      if (!prev.any((e) => e.id == item.id)) prev.add(item);
                                      return prev;
                                    })
                                    .map((item) => DropdownMenuItem<int>(
                                          value: item.id,
                                          child: Text(item.name.toString()),
                                        ))
                                    .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedUnitId = value;

                                selectedUnitName = context
                                    .read<StockProvider>()
                                    .unitList
                                    .firstWhere((e) => e.id == value)
                                    .name;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select unit";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      10.verticalSpace,
                      /// 🔹 Invoice Number
                      // TextFormField(
                      //   controller: invoiceController,
                      //   decoration: const InputDecoration(
                      //     labelText: "Invoice Number",
                      //     border: OutlineInputBorder(),
                      //   ),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return "Enter invoice number";
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // 10.verticalSpace,
                      //SizedBox(height: 10),
                      // InkWell(
                      //   onTap: pickDate,
                      //   child: InputDecorator(
                      //     decoration: const InputDecoration(
                      //       labelText: "Invoice Date",
                      //       border: OutlineInputBorder(),
                      //       suffixIcon: Icon(Icons.calendar_today), // nice UI
                      //     ),
                      //     child: Text(
                      //       selectedDate == null
                      //           ? "Select Date"
                      //           : "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                      //     ),
                      //   ),
                      // ),

                      /// 🔹 From & To Date
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () => selectDate(context, true),
                      //         child: InputDecorator(
                      //           decoration: const InputDecoration(
                      //             labelText: "From Date",
                      //             border: OutlineInputBorder(),
                      //           ),
                      //           child: Text(
                      //             fromDate == null
                      //                 ? "Select date"
                      //                 : "${fromDate!.day}/${fromDate!.month}/${fromDate!.year}",
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //      10.verticalSpace,
                      //     Expanded(
                      //       child: InkWell(
                      //         onTap: () => selectDate(context, false),
                      //         child: InputDecorator(
                      //           decoration: const InputDecoration(
                      //             labelText: "To Date",
                      //             border: OutlineInputBorder(),
                      //           ),
                      //           child: Text(
                      //             toDate == null
                      //                 ? "Select date"
                      //                 : "${toDate!.day}/${toDate!.month}/${toDate!.year}",
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      10.verticalSpace,
                      Row(
                        children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextFormField(
                          controller: qtyController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Qty",
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),

                          /// 🔹 Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter qty";
                            }

                            if (int.tryParse(value) == null) {
                              return "Invalid number";
                            }

                            if (int.parse(value) <= 0) {
                              return "Qty must be > 0";
                            }

                            return null;
                          },

                          /// 🔹 Optional: auto update provider / state
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              int qty = int.tryParse(value) ?? 0;

                              // 👉 If using BillingProvider
                              // context.read<BillingProvider>().qtyController.text = value;

                              // 👉 If you need to update rate dynamically
                              // context.read<BillingProvider>().updateRateWithProduct();
                            }
                          },
                        ),
                      ),
                       10.verticalSpace,
                          Expanded(
                            child: TextFormField(
                              controller: rateController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "Rate",
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                setState(() {}); //  THIS FIXES LIVE TOTAL
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter rate";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      // 10.verticalSpace,
                      // TextFormField(
                      //   controller: rateController,
                      //   keyboardType: TextInputType.number,
                      //   decoration: const InputDecoration(
                      //     labelText: "Rate",
                      //     border: OutlineInputBorder(),
                      //   ),
                      // ),
        
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
        
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                           // 'Grand Total: ₹${getCombinedTotal()}',
                            'Grand Total: ₹${getCombinedTotal().toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                      ),
        
                      10.verticalSpace,
                      CommonButton(
                        title: "Save and Add Next",
                        titleColor: Colors.white,
                        colors: const [Colors.green, Colors.greenAccent],
                        onPressed: _saveAndNext,
                      ),
                      // if (addedStocks.isNotEmpty) ...[
                      //   20.verticalSpace,
                      //   Text(
                      //     'Added Stocks',
                      //     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                      //   ),
                      //   10.verticalSpace,
                      //   ListView.builder(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemCount: addedStocks.length,
                      //     itemBuilder: (context, index) {
                      //       final stock = addedStocks[index];
                      //       return Card(
                      //         elevation: 2,
                      //         child: ListTile(
                      //           title: Text('${stock['product']}'),
                      //           subtitle: Text('Qty: ${stock['qty']}  |  Rate: ${stock['rate']}'),
                      //           trailing: IconButton(
                      //             icon: const Icon(Icons.delete, color: Colors.red),
                      //             onPressed: () {
                      //               setState(() {
                      //                 addedStocks.removeAt(index);
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ],
                    ],
                  ),
                ),
                10.verticalSpace,
                CommonButton(
                  title: "Save the Stock",
                  titleColor: Colors.white,
                  colors: const [Colors.lightGreen, Colors.lightGreenAccent],
                  onPressed: _saveAll,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
