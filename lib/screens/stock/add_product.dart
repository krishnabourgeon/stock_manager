// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// class AddProduct extends StatefulWidget {
//   const AddProduct({super.key});

//   @override
//   State<AddProduct> createState() => _AddProductState();
// }

// class _AddProductState extends State<AddProduct> {
//   final _formKey = GlobalKey<FormState>();

//   /// Controllers
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController codeController = TextEditingController();
//   final TextEditingController rateController = TextEditingController();
//   final TextEditingController unitController = TextEditingController();

//   /// Selected Category
//   int? selectedCategoryId;

//   /// Date
//   DateTime selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();

//     /// ✅ CALL API HERE
//     Future.microtask(() {
//       Provider.of<StockProvider>(context, listen: false).getCategories();
//     });
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     codeController.dispose();
//     rateController.dispose();
//     unitController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stockProvider = Provider.of<StockProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Product", style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [

//               /// 🔽 CATEGORY DROPDOWN
//               if (stockProvider.loaderState == LoaderState.loading)
//                 const Center(child: CircularProgressIndicator())
//               else if (stockProvider.categoryList.isEmpty)
//                 const Text("No categories found")
//               else
//                 DropdownButtonFormField<int>(
//                   decoration: const InputDecoration(
//                     labelText: "Select Category",
//                     border: OutlineInputBorder(),
//                   ),
//                   value: selectedCategoryId,
//                   items: stockProvider.categoryList
//                       .map((item) => DropdownMenuItem<int>(
//                             value: item.id,
//                             child: Text(item.name ?? ""),
//                           ))
//                       .toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       selectedCategoryId = value;
//                     });
//                   },
//                   validator: (value) =>
//                       value == null ? "Please select category" : null,
//                 ),

//               const SizedBox(height: 15),

//               /// PRODUCT NAME
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Product Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? "Enter product name" : null,
//               ),

//               const SizedBox(height: 15),

//               /// PRODUCT CODE
//               TextFormField(
//                 controller: codeController,
//                 decoration: const InputDecoration(
//                   labelText: "Product Code",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? "Enter product code" : null,
//               ),

//               const SizedBox(height: 15),

//               /// UNIT
//               TextFormField(
//                 controller: unitController,
//                 decoration: const InputDecoration(
//                   labelText: "Unit",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? "Enter unit" : null,
//               ),

//               const SizedBox(height: 15),

//               /// RATE
//               TextFormField(
//                 controller: rateController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   labelText: "Rate",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                     value!.isEmpty ? "Enter rate" : null,
//               ),

//               const SizedBox(height: 15),

//               /// DATE PICKER
//               InkWell(
//                 onTap: () async {
//                   DateTime? pickedDate = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime(2020),
//                     lastDate: DateTime(2100),
//                   );

//                   if (pickedDate != null) {
//                     setState(() {
//                       selectedDate = pickedDate;
//                     });
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   child: Text(
//                     DateFormat('dd-MM-yyyy').format(selectedDate),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               /// SAVE BUTTON
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.green,
//                   ),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       print("Category ID: $selectedCategoryId");
//                       print("Name: ${nameController.text}");
//                       print("Code: ${codeController.text}");
//                       print("Unit: ${unitController.text}");
//                       print("Rate: ${rateController.text}");
//                       print("Date: $selectedDate");

//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text("Product Saved")),
//                       );

//                       Navigator.pop(context);
//                     }
//                   },
//                   child: const Text(
//                     "Save the product",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();

  /// Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  int? selectedUnitId;
  String? selectedUnitName;
  int? selectedCategoryId;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    ///  Load categories
    Future.microtask(() {
      Provider.of<StockProvider>(context, listen: false).getCategories();

      WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getUnits();
    });

    });
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    rateController.dispose();
    unitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Consumer<StockProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  /// 🔽 CATEGORY DROPDOWN
                  if (provider.loaderState == LoaderState.loading &&
                      provider.categoryList.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else if (provider.categoryList.isEmpty)
                    const Text("No categories found")
                  else
                    DropdownButtonFormField<int>(
                      decoration: const InputDecoration(
                        labelText: "Select Category",
                        border: OutlineInputBorder(),
                      ),
                      value: selectedCategoryId,
                      items: provider.categoryList
                          .map((item) => DropdownMenuItem<int>(
                                value: item.id,
                                child: Text(item.name ?? ""),
                              ))
                          .toList(),
                      // onChanged: (value) {
                      //   setState(() {
                      //     selectedCategoryId = value;
                      //   });
                      // },
                      onChanged: (value) {
                        setState(() {
                          selectedCategoryId = value;
                        });

                        //  CALL API WITH CATEGORY ID
                        context.read<StockProvider>().getCategories(categoryId: value);
                      },
                      validator: (value) =>
                          value == null ? "Please select category" : null,
                    ),

                  const SizedBox(height: 15),

                  /// PRODUCT NAME
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Product Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter product name" : null,
                  ),

                  const SizedBox(height: 15),

                  /// PRODUCT CODE
                  TextFormField(
                    controller: codeController,
                    decoration: const InputDecoration(
                      labelText: "Product Code",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter product code" : null,
                  ),

                  const SizedBox(height: 15),

                  // /// UNIT
                  // TextFormField(
                  //   controller: unitController,
                  //   decoration: const InputDecoration(
                  //     labelText: "Unit (e.g., kg, pcs)",
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   validator: (value) =>
                  //       value!.isEmpty ? "Enter unit" : null,
                  // ),

                  Consumer<StockProvider>(
                    builder: (context, stockProvider, child) {
                      return DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: "Select Unit",
                          border: OutlineInputBorder(),
                        ),
                        value: stockProvider.unitList.any((e) => e.id == selectedUnitId)
                            ? selectedUnitId
                            : null,
                        items: stockProvider.unitList
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
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  /// RATE
                  TextFormField(
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter price" : null,
                  ),

                  const SizedBox(height: 15),

                  /// DATE PICKER (Optional - not sent to API now)
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (pickedDate != null) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        DateFormat('dd-MM-yyyy').format(selectedDate),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// 🔘 SAVE BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          if (selectedCategoryId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please select category")),
                            );
                            return;
                          }

                          if (selectedUnitId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please select a unit")),
                            );
                            return;
                          }

                          provider.saveProduct(
                            name: nameController.text.trim(),
                            code: codeController.text.trim(),
                            unit: selectedUnitId.toString(),
                            price: rateController.text.trim(),
                            categoryId:
                                selectedCategoryId.toString(),

                            onSuccess: () {
                              Navigator.pop(context);
                            },
                          );
                        }
                      },
                      child: provider.loaderState == LoaderState.loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Save Product",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}