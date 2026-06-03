// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:share_plus/share_plus.dart';

// class ProductStockReportScreen extends StatefulWidget {
//   const ProductStockReportScreen({super.key});

//   @override
//   State<ProductStockReportScreen> createState() =>
//       _ProductStockReportScreenState();
// }

// class _ProductStockReportScreenState
//     extends State<ProductStockReportScreen> {
//   final TextEditingController searchController =
//       TextEditingController();

//   List<Map<String, dynamic>> reportList = [
//     {
//       "code": "P001",
//       "name": "Vegetable Seeds",
//       "purchase": 100,
//       "sold": 30,
//       "stock": 70,
//       "unit": "Nos"
//     },
//     {
//       "code": "P002",
//       "name": "Organic Manure",
//       "purchase": 50,
//       "sold": 10,
//       "stock": 40,
//       "unit": "Kg"
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     int totalStock = reportList.fold(
//       0,
//       (sum, item) => sum + (item["stock"] as int),
//     );

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Product Stock Report"),
//         actions: [
//           IconButton(
//             onPressed: () async {
//               await generatePdf();
//             },
//             icon: const Icon(Icons.picture_as_pdf),
//           ),
//           IconButton(
//             onPressed: () async  {
//               await sharePdfToWhatsApp();
//             },
//             icon: const Icon(Icons.share),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           children: [
//             TextField(
//               controller: searchController,
//               decoration: InputDecoration(
//                 hintText: "Search Product",
//                 prefixIcon: const Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius:
//                       BorderRadius.circular(10),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 15),

//             // Row(
//             //   children: [
//             //     Expanded(
//             //       child: Card(
//             //         child: ListTile(
//             //           title:
//             //               const Text("Total Products"),
//             //           subtitle: Text(
//             //             reportList.length.toString(),
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //     Expanded(
//             //       child: Card(
//             //         child: ListTile(
//             //           title: const Text("Stock"),
//             //           subtitle:
//             //               Text(totalStock.toString()),
//             //         ),
//             //       ),
//             //     ),
//             //   ],
//             // ),

//             // const SizedBox(height: 10),

//             Expanded(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: DataTable(
//                   border:
//                       TableBorder.all(color: Colors.grey),
//                   headingRowColor:
//                       MaterialStateProperty.all(
//                     Colors.green,
//                   ),
//                   columns: const [
//                     DataColumn(
//                       label: Text(
//                         "Sl No",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Code",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Product",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Purchased",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Sold",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Balance",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     DataColumn(
//                       label: Text(
//                         "Unit",
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                   rows: reportList
//                       .asMap()
//                       .entries
//                       .map((entry) {
//                     final index = entry.key;
//                     final item = entry.value;

//                     return DataRow(
//                       cells: [
//                         DataCell(
//                           Text("${index + 1}"),
//                         ),
//                         DataCell(
//                           Text(item["code"]),
//                         ),
//                         DataCell(
//                           Text(item["name"]),
//                         ),
//                         DataCell(
//                           Text(
//                             item["purchase"]
//                                 .toString(),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             item["sold"].toString(),
//                           ),
//                         ),
//                         DataCell(
//                           Text(
//                             item["stock"]
//                                 .toString(),
//                             style: const TextStyle(
//                               color: Colors.green,
//                               fontWeight:
//                                   FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         DataCell(
//                           Text(item["unit"]),
//                         ),
//                       ],
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


//   Future<File> _createPdfFile() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.MultiPage(
//       pageFormat: PdfPageFormat.a4.landscape,
//       build: (context) => [
//         pw.Text(
//           'Product Wise Stock Report',
//           style: pw.TextStyle(
//             fontSize: 18,
//             fontWeight: pw.FontWeight.bold,
//           ),
//         ),

//         pw.SizedBox(height: 20),

//         pw.Table(
//           border: pw.TableBorder.all(),
//           children: [
//             pw.TableRow(
//               decoration: const pw.BoxDecoration(
//                 color: PdfColors.green,
//               ),
//               children: [
//                 _headerCell('Sl No'),
//                 _headerCell('Code'),
//                 _headerCell('Product'),
//                 _headerCell('Purchased'),
//                 _headerCell('Sold'),
//                 _headerCell('Balance'),
//                 _headerCell('Unit'),
//               ],
//             ),

//             ...reportList.asMap().entries.map(
//               (entry) {
//                 final index = entry.key;
//                 final item = entry.value;

//                 return pw.TableRow(
//                   children: [
//                     _cell("${index + 1}"),
//                     _cell(item["code"]),
//                     _cell(item["name"]),
//                     _cell(item["purchase"].toString()),
//                     _cell(item["sold"].toString()),
//                     _cell(item["stock"].toString()),
//                     _cell(item["unit"]),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     ),
//   );

//     final directory = await getTemporaryDirectory();

//     final file = File(
//       "${directory.path}/product_stock_report.pdf",
//     );

//     await file.writeAsBytes(
//       await pdf.save(),
//     );

//     return file;
//   }

//   Future<void> generatePdf() async {
//   final file = await _createPdfFile();

//     await Printing.layoutPdf(
//       onLayout: (_) async => file.readAsBytes(),
//     );
//   }

//   Future<void> sharePdfToWhatsApp() async {
//     final file = await _createPdfFile();

//     await Share.shareXFiles(
//       [XFile(file.path)],
//       text: 'Product Wise Stock Report',
//     );
//   }

//   pw.Widget _headerCell(String text) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.all(5),
//     child: pw.Text(
//       text,
//       style: pw.TextStyle(
//         color: PdfColors.white,
//         fontWeight: pw.FontWeight.bold,
//       ),
//     ),
//   );
// }

// pw.Widget _cell(String text) {
//   return pw.Padding(
//     padding: const pw.EdgeInsets.all(5),
//     child: pw.Text(text),
//   );
// }
  
// }




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================================
// MODEL
// ============================================================================
class Supplier {
  final int id;
  final String supplierName;
  final String contactPerson;
  final String contactNumber;
  final String address;

  Supplier({
    required this.id,
    required this.supplierName,
    required this.contactPerson,
    required this.contactNumber,
    required this.address,
  });
}

// ============================================================================
// SUPPLIER SCREEN
// ============================================================================
class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Form controllers
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _contactPersonController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // Supplier list
  final List<Supplier> _suppliers = [];
  int _idCounter = 1;

  // Edit mode
  Supplier? _editingSupplier;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Dummy data
    _suppliers.addAll([
      Supplier(
        id: _idCounter++,
        supplierName: "Kerala Traders Co.",
        contactPerson: "Rajan Nair",
        contactNumber: "9876543210",
        address: "MG Road, Thrissur, Kerala - 680001",
      ),
      Supplier(
        id: _idCounter++,
        supplierName: "Malabar Supplies Pvt Ltd",
        contactPerson: "Suresh Kumar",
        contactNumber: "9845123456",
        address: "Palayam, Kozhikode, Kerala - 673001",
      ),
    ]);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _supplierNameController.dispose();
    _contactPersonController.dispose();
    _contactNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // SUBMIT FORM
  // -------------------------------------------------------------------------
  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_editingSupplier != null) {
      // UPDATE
      final index = _suppliers.indexWhere((s) => s.id == _editingSupplier!.id);
      if (index != -1) {
        setState(() {
          _suppliers[index] = Supplier(
            id: _editingSupplier!.id,
            supplierName: _supplierNameController.text.trim(),
            contactPerson: _contactPersonController.text.trim(),
            contactNumber: _contactNumberController.text.trim(),
            address: _addressController.text.trim(),
          );
          _editingSupplier = null;
        });
      }
      _showSnackBar("Supplier updated successfully", Colors.green);
    } else {
      // ADD
      setState(() {
        _suppliers.add(
          Supplier(
            id: _idCounter++,
            supplierName: _supplierNameController.text.trim(),
            contactPerson: _contactPersonController.text.trim(),
            contactNumber: _contactNumberController.text.trim(),
            address: _addressController.text.trim(),
          ),
        );
      });
      _showSnackBar("Supplier added successfully", Colors.green);
    }

    _clearForm();
    _tabController.animateTo(1); // Switch to view tab
  }

  void _clearForm() {
    _supplierNameController.clear();
    _contactPersonController.clear();
    _contactNumberController.clear();
    _addressController.clear();
    setState(() => _editingSupplier = null);
  }

  void _populateForEdit(Supplier supplier) {
    setState(() => _editingSupplier = supplier);
    _supplierNameController.text = supplier.supplierName;
    _contactPersonController.text = supplier.contactPerson;
    _contactNumberController.text = supplier.contactNumber;
    _addressController.text = supplier.address;
    _tabController.animateTo(0); // Switch to add tab
  }

  void _deleteSupplier(Supplier supplier) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          "Delete Supplier",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Are you sure you want to delete \"${supplier.supplierName}\"?",
          style: GoogleFonts.roboto(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: GoogleFonts.roboto(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _suppliers.removeWhere((s) => s.id == supplier.id));
              Navigator.pop(context);
              _showSnackBar("Supplier deleted", Colors.red);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Delete", style: GoogleFonts.roboto(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: GoogleFonts.roboto(color: Colors.white)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // BUILD
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Colors.white,)),
        backgroundColor: Colors.green,
        title: Text(
          "Suppliers",
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 14),
          unselectedLabelStyle: GoogleFonts.roboto(fontSize: 14),
          tabs: const [
            Tab(icon: Icon(Icons.add_circle_outline), text: "Add Supplier"),
            Tab(icon: Icon(Icons.list_alt_outlined), text: "View Suppliers"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildAddTab(),
          _buildViewTab(),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // ADD TAB
  // -------------------------------------------------------------------------
  Widget _buildAddTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.storefront, color: Color(0xFFEAC413), size: 28),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _editingSupplier != null
                            ? "Edit Supplier"
                            : "New Supplier",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        _editingSupplier != null
                            ? "Update supplier details below"
                            : "Fill in the supplier details below",
                        style: GoogleFonts.roboto(
                          color: Colors.white60,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Supplier Name
            _buildLabel("Supplier Name"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _supplierNameController,
              hint: "e.g. Kerala Traders Co.",
              icon: Icons.business,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? "Supplier name is required" : null,
            ),

            const SizedBox(height: 16),

            // Contact Person
            _buildLabel("Contact Person"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _contactPersonController,
              hint: "e.g. Rajan Nair",
              icon: Icons.person_outline,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? "Contact person is required" : null,
            ),

            const SizedBox(height: 16),

            // Contact Number
            _buildLabel("Contact Number"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _contactNumberController,
              hint: "e.g. 9876543210",
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return "Contact number is required";
                if (v.trim().length < 10) return "Enter a valid phone number";
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Address
            _buildLabel("Address"),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _addressController,
              hint: "e.g. MG Road, Thrissur, Kerala",
              icon: Icons.location_on_outlined,
              maxLines: 3,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? "Address is required" : null,
            ),

            const SizedBox(height: 28),

            // Buttons
            Row(
              children: [
                if (_editingSupplier != null) ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _clearForm,
                      icon: const Icon(Icons.close, size: 18),
                      label: Text("Cancel", style: GoogleFonts.roboto()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        side: const BorderSide(color: Colors.black),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    icon: Icon(
                      _editingSupplier != null
                          ? Icons.check_circle_outline
                          : Icons.add_circle_outline,
                      size: 18,
                    ),
                    label: Text(
                      _editingSupplier != null
                          ? "Update Supplier"
                          : "Add Supplier",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // VIEW TAB
  // -------------------------------------------------------------------------
  Widget _buildViewTab() {
    return Column(
      children: [
        // Count banner
        Container(
          width: double.infinity,
          color: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "${_suppliers.length} Supplier${_suppliers.length != 1 ? 's' : ''} registered",
            style: GoogleFonts.roboto(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),

        // List
        Expanded(
          child: _suppliers.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.storefront_outlined,
                          size: 72, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        "No suppliers yet",
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tap 'Add Supplier' to get started",
                        style: GoogleFonts.roboto(color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => _tabController.animateTo(0),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text("Add Supplier", style: GoogleFonts.roboto()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _suppliers.length,
                  itemBuilder: (context, index) {
                    final supplier = _suppliers[index];
                    return _buildSupplierCard(supplier, index);
                  },
                ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // SUPPLIER CARD
  // -------------------------------------------------------------------------
  Widget _buildSupplierCard(Supplier supplier, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Color(0xFFEAC413), width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row — name + actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      supplier.supplierName[0].toUpperCase(),
                      style: GoogleFonts.roboto(
                        color: const Color(0xFFEAC413),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplier.supplierName,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "ID #${supplier.id.toString().padLeft(3, '0')}",
                        style: GoogleFonts.roboto(
                          color: Colors.grey[500],
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // Edit & Delete
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     InkWell(
                //       onTap: () => _populateForEdit(supplier),
                //       borderRadius: BorderRadius.circular(6),
                //       child: Container(
                //         padding: const EdgeInsets.all(6),
                //         decoration: BoxDecoration(
                //           color: Colors.black,
                //           borderRadius: BorderRadius.circular(6),
                //         ),
                //         child: const Icon(Icons.edit_outlined,
                //             size: 16, color: Color(0xFFEAC413)),
                //       ),
                //     ),
                //     const SizedBox(width: 8),
                //     InkWell(
                //       onTap: () => _deleteSupplier(supplier),
                //       borderRadius: BorderRadius.circular(6),
                //       child: Container(
                //         padding: const EdgeInsets.all(6),
                //         decoration: BoxDecoration(
                //           color: Colors.red[50],
                //           borderRadius: BorderRadius.circular(6),
                //         ),
                //         child: const Icon(Icons.delete_outline,
                //             size: 16, color: Colors.red),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),

            const SizedBox(height: 14),
            const Divider(height: 1),
            const SizedBox(height: 12),

            // Details
            _buildDetailRow(Icons.person_outline, "Contact Person",
                supplier.contactPerson),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.phone_outlined, "Phone",
                supplier.contactNumber),
            const SizedBox(height: 8),
            _buildDetailRow(Icons.location_on_outlined, "Address",
                supplier.address),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$label: ",
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: value,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // HELPERS
  // -------------------------------------------------------------------------
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.roboto(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: GoogleFonts.roboto(fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.roboto(color: Colors.grey[400], fontSize: 13),
        prefixIcon: Icon(icon, size: 20, color: Colors.grey[600]),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}