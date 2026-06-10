// import 'package:flutter/material.dart';

// class AddCategoryScreen extends StatefulWidget {
//   const AddCategoryScreen({Key? key}) : super(key: key);

//   @override
//   State<AddCategoryScreen> createState() => _AddCategoryScreenState();
// }

// class _AddCategoryScreenState extends State<AddCategoryScreen> {
//   final TextEditingController _categoryController = TextEditingController();
//   final List<String> _categories = [];
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   int? _editingIndex; // Tracks which category is being edited

//   void _addOrUpdateCategory() {
//     if (_formKey.currentState!.validate()) {
//       final categoryName = _categoryController.text.trim();

//       setState(() {
//         if (_editingIndex == null) {
//           // Add new category
//           _categories.add(categoryName);
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Category added successfully'),
//               backgroundColor: Colors.green,
//             ),
//           );
//         } else {
//           // Update existing category
//           _categories[_editingIndex!] = categoryName;
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Category updated successfully'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           _editingIndex = null; // Reset editing state
//         }
//         _categoryController.clear();
//       });
//     }
//   }

//   void _editCategory(int index) {
//     setState(() {
//       _editingIndex = index;
//       _categoryController.text = _categories[index];
//     });
//   }

//   void _cancelEdit() {
//     setState(() {
//       _editingIndex = null;
//       _categoryController.clear();
//     });
//   }

//   @override
//   void dispose() {
//     _categoryController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEditing = _editingIndex != null;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Add Category',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// Category Input Field
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),
//                   TextFormField(
//                     controller: _categoryController,
//                     decoration: InputDecoration(
//                       labelText: 'Category Name',
//                       hintText: 'Enter category name',
//                       border: const OutlineInputBorder(),
//                       suffixIcon: isEditing
//                           ? IconButton(
//                               icon: const Icon(Icons.close),
//                               onPressed: _cancelEdit,
//                             )
//                           : null,
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter a category name';
//                       }

//                       final lowerCaseList =
//                           _categories.map((e) => e.toLowerCase()).toList();

//                       if (_editingIndex == null &&
//                           lowerCaseList
//                               .contains(value.trim().toLowerCase())) {
//                         return 'Category already exists';
//                       }

//                       if (_editingIndex != null &&
//                           lowerCaseList
//                               .contains(value.trim().toLowerCase()) &&
//                           value.trim().toLowerCase() !=
//                               _categories[_editingIndex!].toLowerCase()) {
//                         return 'Category already exists';
//                       }

//                       return null;
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: SizedBox(
//                           height: 56,
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.green,
//                             ),
//                             onPressed: _addOrUpdateCategory,
//                             child: Text(
//                               isEditing ? 'Update' : 'Save',
//                               style: const TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (isEditing) ...[
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: SizedBox(
//                             height: 56,
//                             child: OutlinedButton(
//                               onPressed: _cancelEdit,
//                               child: const Text('Cancel'),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// Title for the Category List
//             // const Text(
//             //   'Added Categories',
//             //   style: TextStyle(
//             //     fontSize: 18,
//             //     fontWeight: FontWeight.bold,
//             //   ),
//             // ),

//             // const SizedBox(height: 10),

//             // /// Display Added Categories
//             // Expanded(
//             //   child: _categories.isEmpty
//             //       ? const Center(
//             //           child: Text(
//             //             'No categories added yet',
//             //             style: TextStyle(fontSize: 16, color: Colors.grey),
//             //           ),
//             //         )
//             //       : ListView.separated(
//             //           itemCount: _categories.length,
//             //           separatorBuilder: (_, __) =>
//             //               const SizedBox(height: 8),
//             //           itemBuilder: (context, index) {
//             //             return Card(
//             //               elevation: 2,
//             //               child: ListTile(
//             //                 leading: const Icon(
//             //                   Icons.category,
//             //                   color: Colors.blue,
//             //                 ),
//             //                 title: Text(_categories[index]),
//             //                 trailing: const Icon(
//             //                   Icons.edit,
//             //                   color: Colors.green,
//             //                 ),
//             //                 onTap: () => _editCategory(index),
//             //               ),
//             //             );
//             //           },
//             //         ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// class AddCategoryScreen extends StatefulWidget {
//   const AddCategoryScreen({Key? key}) : super(key: key);

//   @override
//   State<AddCategoryScreen> createState() => _AddCategoryScreenState();
// }

// class _AddCategoryScreenState extends State<AddCategoryScreen> {
//   final TextEditingController _categoryController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();

//     /// 🔹 Load categories on screen open
//     Future.microtask(() {
//       Provider.of<StockProvider>(context, listen: false)
//           .getCategories();
//     });
//   }

//   /// 🔹 ADD CATEGORY (API)
//   void _addCategory() {
//     if (_formKey.currentState!.validate()) {
//       final categoryName = _categoryController.text.trim();

//       final provider =
//           Provider.of<StockProvider>(context, listen: false);

//       provider.saveCat(
//         name: categoryName,
//         onSuccess: () {
//           _categoryController.clear();

//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Category added successfully'),
//               backgroundColor: Colors.green,
//             ),
//           );

//           /// 🔹 Refresh category list
//           provider.getCategories();
//         },
//         onFailure: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Failed to add category'),
//               backgroundColor: Colors.red,
//             ),
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<StockProvider>(context);
//     final categories = provider.categoryList;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Add Category',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// 🔹 FORM
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   const SizedBox(height: 10),

//                   /// 🔹 INPUT FIELD
//                   TextFormField(
//                     controller: _categoryController,
//                     decoration: const InputDecoration(
//                       labelText: 'Category Name',
//                       hintText: 'Enter category name',
//                       border: OutlineInputBorder(),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter a category name';
//                       }

//                       /// 🔹 DUPLICATE CHECK (API LIST)
//                       final lowerCaseList = categories
//                           .map((e) => (e.name ?? '').toLowerCase())
//                           .toList();

//                       if (lowerCaseList
//                           .contains(value.trim().toLowerCase())) {
//                         return 'Category already exists';
//                       }

//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   /// 🔹 SAVE BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.green,
//                       ),
//                       onPressed: provider.loaderState ==
//                               LoaderState.loading
//                           ? null
//                           : _addCategory,
//                       child: provider.loaderState ==
//                               LoaderState.loading
//                           ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : const Text(
//                               'Save',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             /// 🔹 TITLE
//             const Text(
//               'Added Categories',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 10),

//             /// 🔹 CATEGORY LIST
//             Expanded(
//               child: categories.isEmpty
//                   ? const Center(
//                       child: Text(
//                         'No categories found',
//                         style: TextStyle(
//                             fontSize: 16, color: Colors.grey),
//                       ),
//                     )
//                   : ListView.separated(
//                       itemCount: categories.length,
//                       separatorBuilder: (_, __) =>
//                           const SizedBox(height: 8),
//                       itemBuilder: (context, index) {
//                         final cat = categories[index];

//                         return Card(
//                           elevation: 2,
//                           child: ListTile(
//                             leading: const Icon(
//                               Icons.category,
//                               color: Colors.blue,
//                             ),
//                             title: Text(cat.name ?? ''),
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _categoryController.dispose();
//     super.dispose();
//   }
// }



import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _categoryMalController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isTranslating = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<StockProvider>(context, listen: false).getCategories();
    });
    _categoryController.addListener(_onNameChanged);
  }

  void _onNameChanged() {
    final text = _categoryController.text.trim();
    if (text.isEmpty) {
      _categoryMalController.clear();
      return;
    }
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 700), () {
      _transliterate(text);
    });
  }

  Future<void> _transliterate(String text) async {
    if (text.isEmpty) return;
    setState(() => _isTranslating = true);
    try {
      final uri = Uri.parse(
        'https://inputtools.google.com/request'
        '?text=${Uri.encodeComponent(text)}'
        '&itc=ml-t-i0-und'
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
            if (mounted) _categoryMalController.text = result;
          }
        }
      }
    } catch (e) {
      debugPrint('Transliteration error: $e');
    } finally {
      if (mounted) setState(() => _isTranslating = false);
    }
  }

  void _addCategory() {
    if (_formKey.currentState!.validate()) {
      final englishName = _categoryController.text.trim();
      final malayalamName = _categoryMalController.text.trim();

      // Join both fields → "Fruits (പഴങ്ങൾ)"
      final combinedName = malayalamName.isNotEmpty
          ? '$englishName ($malayalamName)'
          : englishName;

      final provider = Provider.of<StockProvider>(context, listen: false);

      provider.saveCat(
        name: combinedName, // "Fruits (പഴങ്ങൾ)"
        onSuccess: () {
          _categoryController.clear();
          _categoryMalController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Category added successfully'),
              backgroundColor: Colors.green,
            ),
          );

          provider.getCategories();
        },
        onFailure: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to add category'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<StockProvider>(context);
    final categories = provider.categoryList;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Category',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  // ── English field ───────────────────────────────────
                  TextFormField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      labelText: 'Category Name (English)',
                      hintText: 'e.g. Fruits, Seeds',
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
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a category name';
                      }
                      final lowerCaseList = categories
                          .map((e) => (e.name ?? '').toLowerCase())
                          .toList();
                      if (lowerCaseList
                          .contains(value.trim().toLowerCase())) {
                        return 'Category already exists';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 6),

                  // Hint
                  Row(
                    children: [
                      Icon(Icons.translate,
                          size: 13, color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        _isTranslating
                            ? 'Converting to Malayalam...'
                            : 'Malayalam auto-fills below • You can edit it',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green.shade600,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // ── Malayalam field — editable ──────────────────────
                  TextFormField(
                    controller: _categoryMalController,
                    decoration: InputDecoration(
                      labelText: 'Category Name (മലയാളം)',
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
                        value!.isEmpty ? 'Enter Malayalam name' : null,
                  ),

                  const SizedBox(height: 8),

                  // ── Preview of combined name ────────────────────────
                  if (_categoryController.text.isNotEmpty &&
                      _categoryMalController.text.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.merge_type,
                              size: 14, color: Colors.green.shade600),
                          const SizedBox(width: 6),
                          Text(
                            'Saves as: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade600,
                            ),
                          ),
                          Text(
                            '${_categoryController.text.trim()} (${_categoryMalController.text.trim()})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green.shade800,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 20),

                  // ── Save button ─────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: provider.loaderState == LoaderState.loading
                          ? null
                          : _addCategory,
                      child: provider.loaderState == LoaderState.loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Added Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // ── Category list ───────────────────────────────────────
            Expanded(
              child: categories.isEmpty
                  ? const Center(
                      child: Text(
                        'No categories found',
                        style:
                            TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      itemCount: categories.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final cat = categories[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: const Icon(Icons.category,
                                color: Colors.blue),
                            title: Text(cat.name ?? ''),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _categoryController.removeListener(_onNameChanged);
    _categoryController.dispose();
    _categoryMalController.dispose();
    super.dispose();
  }
}