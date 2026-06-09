// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:stock_manager/providers/stock_provider.dart';
// // // import 'package:stock_manager/services/provider_helper_class.dart';

// // // class AddProduct extends StatefulWidget {
// // //   const AddProduct({super.key});

// // //   @override
// // //   State<AddProduct> createState() => _AddProductState();
// // // }

// // // class _AddProductState extends State<AddProduct> {
// // //   final _formKey = GlobalKey<FormState>();

// // //   /// Controllers
// // //   final TextEditingController nameController = TextEditingController();
// // //   final TextEditingController codeController = TextEditingController();
// // //   final TextEditingController rateController = TextEditingController();
// // //   final TextEditingController unitController = TextEditingController();

// // //   /// Selected Category
// // //   int? selectedCategoryId;

// // //   /// Date
// // //   DateTime selectedDate = DateTime.now();

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     /// ✅ CALL API HERE
// // //     Future.microtask(() {
// // //       Provider.of<StockProvider>(context, listen: false).getCategories();
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     nameController.dispose();
// // //     codeController.dispose();
// // //     rateController.dispose();
// // //     unitController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final stockProvider = Provider.of<StockProvider>(context);

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text("Add Product", style: TextStyle(color: Colors.white)),
// // //         centerTitle: true,
// // //         backgroundColor: Colors.green,
// // //       ),
// // //       body: SingleChildScrollView(
// // //         padding: const EdgeInsets.all(16),
// // //         child: Form(
// // //           key: _formKey,
// // //           child: Column(
// // //             children: [

// // //               /// 🔽 CATEGORY DROPDOWN
// // //               if (stockProvider.loaderState == LoaderState.loading)
// // //                 const Center(child: CircularProgressIndicator())
// // //               else if (stockProvider.categoryList.isEmpty)
// // //                 const Text("No categories found")
// // //               else
// // //                 DropdownButtonFormField<int>(
// // //                   decoration: const InputDecoration(
// // //                     labelText: "Select Category",
// // //                     border: OutlineInputBorder(),
// // //                   ),
// // //                   value: selectedCategoryId,
// // //                   items: stockProvider.categoryList
// // //                       .map((item) => DropdownMenuItem<int>(
// // //                             value: item.id,
// // //                             child: Text(item.name ?? ""),
// // //                           ))
// // //                       .toList(),
// // //                   onChanged: (value) {
// // //                     setState(() {
// // //                       selectedCategoryId = value;
// // //                     });
// // //                   },
// // //                   validator: (value) =>
// // //                       value == null ? "Please select category" : null,
// // //                 ),

// // //               const SizedBox(height: 15),

// // //               /// PRODUCT NAME
// // //               TextFormField(
// // //                 controller: nameController,
// // //                 decoration: const InputDecoration(
// // //                   labelText: "Product Name",
// // //                   border: OutlineInputBorder(),
// // //                 ),
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "Enter product name" : null,
// // //               ),

// // //               const SizedBox(height: 15),

// // //               /// PRODUCT CODE
// // //               TextFormField(
// // //                 controller: codeController,
// // //                 decoration: const InputDecoration(
// // //                   labelText: "Product Code",
// // //                   border: OutlineInputBorder(),
// // //                 ),
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "Enter product code" : null,
// // //               ),

// // //               const SizedBox(height: 15),

// // //               /// UNIT
// // //               TextFormField(
// // //                 controller: unitController,
// // //                 decoration: const InputDecoration(
// // //                   labelText: "Unit",
// // //                   border: OutlineInputBorder(),
// // //                 ),
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "Enter unit" : null,
// // //               ),

// // //               const SizedBox(height: 15),

// // //               /// RATE
// // //               TextFormField(
// // //                 controller: rateController,
// // //                 keyboardType: TextInputType.number,
// // //                 decoration: const InputDecoration(
// // //                   labelText: "Rate",
// // //                   border: OutlineInputBorder(),
// // //                 ),
// // //                 validator: (value) =>
// // //                     value!.isEmpty ? "Enter rate" : null,
// // //               ),

// // //               const SizedBox(height: 15),

// // //               /// DATE PICKER
// // //               InkWell(
// // //                 onTap: () async {
// // //                   DateTime? pickedDate = await showDatePicker(
// // //                     context: context,
// // //                     initialDate: selectedDate,
// // //                     firstDate: DateTime(2020),
// // //                     lastDate: DateTime(2100),
// // //                   );

// // //                   if (pickedDate != null) {
// // //                     setState(() {
// // //                       selectedDate = pickedDate;
// // //                     });
// // //                   }
// // //                 },
// // //                 child: Container(
// // //                   width: double.infinity,
// // //                   padding: const EdgeInsets.all(15),
// // //                   decoration: BoxDecoration(
// // //                     border: Border.all(color: Colors.grey),
// // //                     borderRadius: BorderRadius.circular(5),
// // //                   ),
// // //                   child: Text(
// // //                     DateFormat('dd-MM-yyyy').format(selectedDate),
// // //                   ),
// // //                 ),
// // //               ),

// // //               const SizedBox(height: 25),

// // //               /// SAVE BUTTON
// // //               SizedBox(
// // //                 width: double.infinity,
// // //                 height: 50,
// // //                 child: ElevatedButton(
// // //                   style: ElevatedButton.styleFrom(
// // //                     backgroundColor: Colors.green,
// // //                   ),
// // //                   onPressed: () {
// // //                     if (_formKey.currentState!.validate()) {
// // //                       print("Category ID: $selectedCategoryId");
// // //                       print("Name: ${nameController.text}");
// // //                       print("Code: ${codeController.text}");
// // //                       print("Unit: ${unitController.text}");
// // //                       print("Rate: ${rateController.text}");
// // //                       print("Date: $selectedDate");

// // //                       ScaffoldMessenger.of(context).showSnackBar(
// // //                         const SnackBar(content: Text("Product Saved")),
// // //                       );

// // //                       Navigator.pop(context);
// // //                     }
// // //                   },
// // //                   child: const Text(
// // //                     "Save the product",
// // //                     style: TextStyle(color: Colors.white),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }





// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
// // import 'package:stock_manager/providers/stock_provider.dart';
// // import 'package:stock_manager/services/provider_helper_class.dart';

// // class AddProduct extends StatefulWidget {
// //   const AddProduct({super.key});

// //   @override
// //   State<AddProduct> createState() => _AddProductState();
// // }

// // class _AddProductState extends State<AddProduct> {
// //   final _formKey = GlobalKey<FormState>();

// //   /// Controllers
// //   final TextEditingController nameController = TextEditingController();
// //   final TextEditingController codeController = TextEditingController();
// //   final TextEditingController rateController = TextEditingController();
// //   final TextEditingController unitController = TextEditingController();
// //   int? selectedUnitId;
// //   String? selectedUnitName;
// //   int? selectedCategoryId;
// //   DateTime selectedDate = DateTime.now();

// //   @override
// //   void initState() {
// //     super.initState();

// //     ///  Load categories
// //     Future.microtask(() {
// //       Provider.of<StockProvider>(context, listen: false).getCategories();

// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //       context.read<StockProvider>().getUnits();
// //     });

// //     });
// //   }

// //   @override
// //   void dispose() {
// //     nameController.dispose();
// //     codeController.dispose();
// //     rateController.dispose();
// //     unitController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text("Add Product", style: TextStyle(color: Colors.white)),
// //         backgroundColor: Colors.green,
// //         centerTitle: true,
// //       ),
// //       body: Consumer<StockProvider>(
// //         builder: (context, provider, child) {
// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(16),
// //             child: Form(
// //               key: _formKey,
// //               child: Column(
// //                 children: [

// //                   /// 🔽 CATEGORY DROPDOWN
// //                   if (provider.loaderState == LoaderState.loading &&
// //                       provider.categoryList.isEmpty)
// //                     const Center(child: CircularProgressIndicator())
// //                   else if (provider.categoryList.isEmpty)
// //                     const Text("No categories found")
// //                   else
// //                     DropdownButtonFormField<int>(
// //                       decoration: const InputDecoration(
// //                         labelText: "Select Category",
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       value: selectedCategoryId,
// //                       items: provider.categoryList
// //                           .map((item) => DropdownMenuItem<int>(
// //                                 value: item.id,
// //                                 child: Text(item.name ?? ""),
// //                               ))
// //                           .toList(),
// //                       // onChanged: (value) {
// //                       //   setState(() {
// //                       //     selectedCategoryId = value;
// //                       //   });
// //                       // },
// //                       onChanged: (value) {
// //                         setState(() {
// //                           selectedCategoryId = value;
// //                         });

// //                         //  CALL API WITH CATEGORY ID
// //                         context.read<StockProvider>().getCategories(categoryId: value);
// //                       },
// //                       validator: (value) =>
// //                           value == null ? "Please select category" : null,
// //                     ),

// //                   const SizedBox(height: 15),

// //                   /// PRODUCT NAME
// //                   TextFormField(
// //                     controller: nameController,
// //                     decoration: const InputDecoration(
// //                       labelText: "Product Name",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     validator: (value) =>
// //                         value!.isEmpty ? "Enter product name" : null,
// //                   ),

// //                   const SizedBox(height: 15),

// //                   /// PRODUCT CODE
// //                   TextFormField(
// //                     controller: codeController,
// //                     decoration: const InputDecoration(
// //                       labelText: "Product Code",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     validator: (value) =>
// //                         value!.isEmpty ? "Enter product code" : null,
// //                   ),

// //                   const SizedBox(height: 15),

// //                   // /// UNIT
// //                   // TextFormField(
// //                   //   controller: unitController,
// //                   //   decoration: const InputDecoration(
// //                   //     labelText: "Unit (e.g., kg, pcs)",
// //                   //     border: OutlineInputBorder(),
// //                   //   ),
// //                   //   validator: (value) =>
// //                   //       value!.isEmpty ? "Enter unit" : null,
// //                   // ),

// //                   Consumer<StockProvider>(
// //                     builder: (context, stockProvider, child) {
// //                       return DropdownButtonFormField<int>(
// //                         decoration: const InputDecoration(
// //                           labelText: "Select Unit",
// //                           border: OutlineInputBorder(),
// //                         ),
// //                         value: stockProvider.unitList.any((e) => e.id == selectedUnitId)
// //                             ? selectedUnitId
// //                             : null,
// //                         items: stockProvider.unitList
// //                             .map((item) => DropdownMenuItem<int>(
// //                                   value: item.id,
// //                                   child: Text(item.name.toString()),
// //                                 ))
// //                             .toList(),
// //                         onChanged: (value) {
// //                           setState(() {
// //                             selectedUnitId = value;
// //                             selectedUnitName = context
// //                                 .read<StockProvider>()
// //                                 .unitList
// //                                 .firstWhere((e) => e.id == value)
// //                                 .name;
// //                           });
// //                         },
// //                       );
// //                     },
// //                   ),

// //                   const SizedBox(height: 15),

// //                   /// RATE
// //                   TextFormField(
// //                     controller: rateController,
// //                     keyboardType: TextInputType.number,
// //                     decoration: const InputDecoration(
// //                       labelText: "Price",
// //                       border: OutlineInputBorder(),
// //                     ),
// //                     validator: (value) =>
// //                         value!.isEmpty ? "Enter price" : null,
// //                   ),

// //                   const SizedBox(height: 15),

// //                   /// DATE PICKER (Optional - not sent to API now)
// //                   InkWell(
// //                     onTap: () async {
// //                       DateTime? pickedDate = await showDatePicker(
// //                         context: context,
// //                         initialDate: selectedDate,
// //                         firstDate: DateTime(2020),
// //                         lastDate: DateTime(2100),
// //                       );

// //                       if (pickedDate != null) {
// //                         setState(() {
// //                           selectedDate = pickedDate;
// //                         });
// //                       }
// //                     },
// //                     child: Container(
// //                       width: double.infinity,
// //                       padding: const EdgeInsets.all(15),
// //                       decoration: BoxDecoration(
// //                         border: Border.all(color: Colors.grey),
// //                         borderRadius: BorderRadius.circular(5),
// //                       ),
// //                       child: Text(
// //                         DateFormat('dd-MM-yyyy').format(selectedDate),
// //                       ),
// //                     ),
// //                   ),

// //                   const SizedBox(height: 25),

// //                   /// 🔘 SAVE BUTTON
// //                   SizedBox(
// //                     width: double.infinity,
// //                     height: 50,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.green,
// //                       ),
// //                       onPressed: () {
// //                         if (_formKey.currentState!.validate()) {

// //                           if (selectedCategoryId == null) {
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                   content: Text("Please select category")),
// //                             );
// //                             return;
// //                           }

// //                           if (selectedUnitId == null) {
// //                             ScaffoldMessenger.of(context).showSnackBar(
// //                               const SnackBar(
// //                                   content: Text("Please select a unit")),
// //                             );
// //                             return;
// //                           }

// //                           provider.saveProduct(
// //                             name: nameController.text.trim(),
// //                             code: codeController.text.trim(),
// //                             unit: selectedUnitId.toString(),
// //                             price: rateController.text.trim(),
// //                             categoryId:
// //                                 selectedCategoryId.toString(),

// //                             onSuccess: () {
// //                               Navigator.pop(context);
// //                             },
// //                           );
// //                         }
// //                       },
// //                       child: provider.loaderState == LoaderState.loading
// //                           ? const CircularProgressIndicator(
// //                               color: Colors.white,
// //                             )
// //                           : const Text(
// //                               "Save Product",
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }






// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
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

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController nameMalController = TextEditingController();
//   final TextEditingController codeController = TextEditingController();
//   final TextEditingController rateController = TextEditingController();

//   int? selectedUnitId;
//   String? selectedUnitName;
//   int? selectedCategoryId;
//   DateTime selectedDate = DateTime.now();

//   bool _isTranslating = false;
//   Timer? _debounce;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<StockProvider>(context, listen: false).getCategories();
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         context.read<StockProvider>().getUnits();
//       });
//     });
//     nameController.addListener(_onNameChanged);
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     nameController.removeListener(_onNameChanged);
//     nameController.dispose();
//     nameMalController.dispose();
//     codeController.dispose();
//     rateController.dispose();
//     super.dispose();
//   }

//   void _onNameChanged() {
//     final text = nameController.text.trim();
//     if (text.isEmpty) {
//       nameMalController.clear();
//       return;
//     }
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 700), () {
//       _translate(text);
//     });
//   }

//   Future<void> _translate(String text) async {
//     setState(() => _isTranslating = true);
//     try {
//       final uri = Uri.parse(
//         'https://api.mymemory.translated.net/get'
//         '?q=${Uri.encodeComponent(text)}&langpair=en|ml',
//       );
//       final res = await http.get(uri).timeout(const Duration(seconds: 6));
//       if (res.statusCode == 200) {
//         final json = jsonDecode(res.body);
//         final result = json['responseData']['translatedText'] as String? ?? '';
//         if (mounted) nameMalController.text = result;
//       }
//     } catch (e) {
//       debugPrint('Translation error: $e');
//     } finally {
//       if (mounted) setState(() => _isTranslating = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Product", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: Consumer<StockProvider>(
//         builder: (context, provider, child) {
//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [

//                   // Category
//                   if (provider.loaderState == LoaderState.loading &&
//                       provider.categoryList.isEmpty)
//                     const Center(child: CircularProgressIndicator())
//                   else if (provider.categoryList.isEmpty)
//                     const Text("No categories found")
//                   else
//                     DropdownButtonFormField<int>(
//                       decoration: const InputDecoration(
//                         labelText: "Select Category",
//                         border: OutlineInputBorder(),
//                       ),
//                       value: selectedCategoryId,
//                       items: provider.categoryList
//                           .map((item) => DropdownMenuItem<int>(
//                                 value: item.id,
//                                 child: Text(item.name ?? ""),
//                               ))
//                           .toList(),
//                       onChanged: (value) {
//                         setState(() => selectedCategoryId = value);
//                         context.read<StockProvider>().getCategories(categoryId: value);
//                       },
//                       validator: (value) =>
//                           value == null ? "Please select category" : null,
//                     ),

//                   const SizedBox(height: 15),

//                   // Product Name English
//                   TextFormField(
//                     controller: nameController,
//                     decoration: InputDecoration(
//                       labelText: "Product Name (English)",
//                       border: const OutlineInputBorder(),
//                       suffixIcon: _isTranslating
//                           ? const Padding(
//                               padding: EdgeInsets.all(12),
//                               child: SizedBox(
//                                 width: 18,
//                                 height: 18,
//                                 child: CircularProgressIndicator(
//                                     strokeWidth: 2, color: Colors.green),
//                               ),
//                             )
//                           : const Icon(Icons.text_format_outlined, color: Colors.grey),
//                     ),
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter product name" : null,
//                   ),

//                   const SizedBox(height: 6),

//                   // Translate hint
//                   Row(
//                     children: [
//                       Icon(Icons.translate, size: 13, color: Colors.green.shade600),
//                       const SizedBox(width: 4),
//                       Text(
//                         _isTranslating
//                             ? 'Translating to Malayalam...'
//                             : 'Malayalam auto-filled below • You can edit it',
//                         style: TextStyle(
//                           fontSize: 11,
//                           color: Colors.green.shade600,
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 6),

//                   // Product Name Malayalam - editable, auto-filled
//                   TextFormField(
//                     controller: nameMalController,
//                     decoration: InputDecoration(
//                       labelText: "Product Name (മലയാളം)",
//                       border: const OutlineInputBorder(),
//                       filled: true,
//                       fillColor: Colors.white,
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 12),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 6, vertical: 2),
//                           decoration: BoxDecoration(
//                             color: Colors.green.shade700,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Text(
//                             'മ',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     style: TextStyle(
//                       color: Colors.green.shade900,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter Malayalam name" : null,
//                   ),

//                   const SizedBox(height: 15),

//                   // Product Code
//                   TextFormField(
//                     controller: codeController,
//                     decoration: const InputDecoration(
//                       labelText: "Product Code",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter product code" : null,
//                   ),

//                   const SizedBox(height: 15),

//                   // Unit
//                   Consumer<StockProvider>(
//                     builder: (context, stockProvider, child) {
//                       return DropdownButtonFormField<int>(
//                         decoration: const InputDecoration(
//                           labelText: "Select Unit",
//                           border: OutlineInputBorder(),
//                         ),
//                         value: stockProvider.unitList
//                                 .any((e) => e.id == selectedUnitId)
//                             ? selectedUnitId
//                             : null,
//                         items: stockProvider.unitList
//                             .map((item) => DropdownMenuItem<int>(
//                                   value: item.id,
//                                   child: Text(item.name.toString()),
//                                 ))
//                             .toList(),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedUnitId = value;
//                             selectedUnitName = context
//                                 .read<StockProvider>()
//                                 .unitList
//                                 .firstWhere((e) => e.id == value)
//                                 .name;
//                           });
//                         },
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 15),

//                   // Price
//                   TextFormField(
//                     controller: rateController,
//                     keyboardType: TextInputType.number,
//                     decoration: const InputDecoration(
//                       labelText: "Price",
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) =>
//                         value!.isEmpty ? "Enter price" : null,
//                   ),

//                   const SizedBox(height: 15),

//                   // Date picker
//                   InkWell(
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                         context: context,
//                         initialDate: selectedDate,
//                         firstDate: DateTime(2020),
//                         lastDate: DateTime(2100),
//                       );
//                       if (pickedDate != null) {
//                         setState(() => selectedDate = pickedDate);
//                       }
//                     },
//                     child: Container(
//                       width: double.infinity,
//                       padding: const EdgeInsets.all(15),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
//                     ),
//                   ),

//                   const SizedBox(height: 25),

//                   // Save button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.green),
//                       onPressed: () {
//                         if (_formKey.currentState!.validate()) {
//                           if (selectedCategoryId == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text("Please select category")),
//                             );
//                             return;
//                           }
//                           if (selectedUnitId == null) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text("Please select a unit")),
//                             );
//                             return;
//                           }
//                           provider.saveProduct(
//                             name: nameController.text.trim(),
//                             namemal: nameMalController.text.trim(),
//                             code: codeController.text.trim(),
//                             unit: selectedUnitId.toString(),
//                             price: rateController.text.trim(),
//                             categoryId: selectedCategoryId.toString(),
//                             onSuccess: () => Navigator.pop(context),
//                           );
//                         }
//                       },
//                       child: provider.loaderState == LoaderState.loading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                               "Save Product",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }





import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  final TextEditingController nameController = TextEditingController();
  final TextEditingController nameMalController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController rateController = TextEditingController();

  int? selectedUnitId;
  String? selectedUnitName;
  int? selectedCategoryId;
  DateTime selectedDate = DateTime.now();

  bool _isTranslating = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StockProvider>(context, listen: false).getCategories();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<StockProvider>().getUnits();
      });
    });
    nameController.addListener(_onNameChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    nameController.removeListener(_onNameChanged);
    nameController.dispose();
    nameMalController.dispose();
    codeController.dispose();
    rateController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    final text = nameController.text.trim();
    if (text.isEmpty) {
      nameMalController.clear();
      return;
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      _transliterate(text);
    });
  }

  /// Converts Manglish (phonetic English) → Malayalam script
  /// using Google Inputtools transliteration.
  /// e.g. "mango" → "മാങ്ങ", "veedu" → "വീട്"
  Future<void> _transliterate(String text) async {
    if (text.isEmpty) return;
    setState(() => _isTranslating = true);
    try {
      final uri = Uri.parse(
        'https://inputtools.google.com/request'
        '?text=${Uri.encodeComponent(text)}'
        '&itc=ml-t-i0-und' // ml = Malayalam, t = transliteration
        '&num=1'
        '&cp=0&cs=1'
        '&ie=utf-8&oe=utf-8',
      );
      final res = await http.get(uri).timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final dynamic json = jsonDecode(res.body);        
        if (json is List &&
            json.length >= 2 &&
            json[0] == 'SUCCESS' &&
            json[1] is List &&
            (json[1] as List).isNotEmpty) {
          final firstEntry = (json[1] as List)[0];
          if (firstEntry is List &&
              firstEntry.length >= 2 &&
              firstEntry[1] is List &&
              (firstEntry[1] as List).isNotEmpty) {
            final result = firstEntry[1][0] as String;
            if (mounted) nameMalController.text = result;
          }
        }
      }
    } catch (e) {
      debugPrint('Transliteration error: $e');
    } finally {
      if (mounted) setState(() => _isTranslating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<StockProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Category
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
                      onChanged: (value) {
                        setState(() => selectedCategoryId = value);
                        context.read<StockProvider>().getCategories(categoryId: value);
                      },
                      validator: (value) =>
                          value == null ? "Please select category" : null,
                    ),

                  const SizedBox(height: 15),

                  // Product Name English
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Product Name (English)",
                      border: const OutlineInputBorder(),
                      suffixIcon: _isTranslating
                          ? const Padding(
                              padding: EdgeInsets.all(12),
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.green),
                              ),
                            )
                          : const Icon(Icons.text_format_outlined,
                              color: Colors.grey),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter product name" : null,
                  ),

                  const SizedBox(height: 6),

                  // Transliteration hint
                  Row(
                    children: [
                      Icon(Icons.translate, size: 13, color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        _isTranslating
                            ? 'Converting to Malayalam...'
                            : 'Type Manglish → auto-converts to Malayalam • You can edit it',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Product Name Malayalam - editable, auto-filled
                  TextFormField(
                    controller: nameMalController,
                    decoration: InputDecoration(
                      labelText: "Product Name (മലയാളം)",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.green.shade700,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'മ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter Malayalam name" : null,
                  ),

                  const SizedBox(height: 15),

                  // Product Code
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

                  // Unit
                  Consumer<StockProvider>(
                    builder: (context, stockProvider, child) {
                      return DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          labelText: "Select Unit",
                          border: OutlineInputBorder(),
                        ),
                        value: stockProvider.unitList
                                .any((e) => e.id == selectedUnitId)
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

                  // Price
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

                  // Date picker
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (pickedDate != null) {
                        setState(() => selectedDate = pickedDate);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                          Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
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
                            namemal: nameMalController.text.trim(),
                            code: codeController.text.trim(),
                            unit: selectedUnitId.toString(),
                            price: rateController.text.trim(),
                            categoryId: selectedCategoryId.toString(),
                            onSuccess: () => Navigator.pop(context),
                          );
                        }
                      },
                      child: provider.loaderState == LoaderState.loading
                          ? const CircularProgressIndicator(color: Colors.white)
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
