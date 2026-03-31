// // // import 'package:flutter/material.dart';

// // // class ViewStock extends StatefulWidget {
// // //   const ViewStock({super.key});

// // //   @override
// // //   State<ViewStock> createState() => _ViewStockState();
// // // }

// // // class _ViewStockState extends State<ViewStock> {

// // //   final List<Map<String, dynamic>> stockItems = [
// // //     {
// // //       'invoiceNo': 'INV-001',
// // //       'productName': 'Wireless Headphones',
// // //       'total': 6495.00,
// // //     },
// // //     {
// // //       'invoiceNo': 'INV-002',
// // //       'productName': 'Smart Watch',
// // //       'total': 7497.00,
// // //     },
// // //     {
// // //       'invoiceNo': 'INV-003',
// // //       'productName': 'Laptop Stand',
// // //       'total': 8990.00,
// // //     },
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         centerTitle: true,
// // //         title: const Text('View Stock',style: TextStyle(color: Colors.white,fontSize: 19),),
// // //         backgroundColor: Colors.green,
// // //         leading: IconButton(
// // //           onPressed: () => Navigator.pop(context),
// // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
// // //           //tooltip: 'Back',
// // //         ),
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(12.0),
// // //         child: stockItems.isEmpty
// // //             ? const Center(
// // //                 child: Text(
// // //                   'No stock items found',
// // //                   style: TextStyle(fontSize: 18, color: Colors.grey),
// // //                 ),
// // //               )
// // //             : ListView.builder(
// // //                 itemCount: stockItems.length,
// // //                 itemBuilder: (context, index) {
// // //                   final item = stockItems[index];
// // //                   return Card(
// // //                     elevation: 4,
// // //                     margin: const EdgeInsets.only(bottom: 12),
// // //                     shape: RoundedRectangleBorder(
// // //                       borderRadius: BorderRadius.circular(12),
// // //                     ),
// // //                     child: Padding(
// // //                       padding: const EdgeInsets.all(16.0),
// // //                       child: Column(
// // //                         crossAxisAlignment: CrossAxisAlignment.start,
// // //                         children: [
// // //                           // Invoice No Row
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               Text(
// // //                                 'Invoice No: ${item['invoiceNo']}',
// // //                                 style: const TextStyle(
// // //                                   fontSize: 16,
// // //                                   fontWeight: FontWeight.bold,
// // //                                   color: Colors.blueAccent,
// // //                                 ),
// // //                               ),
// // //                               // Delete Button
// // //                               IconButton(
// // //                                 onPressed: () {
// // //                                   // TODO: Add delete functionality here
// // //                                   _showDeleteDialog(context, index);
// // //                                 },
// // //                                 icon: const Icon(Icons.delete, color: Colors.red),
// // //                                 tooltip: 'Delete Item',
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           const Divider(thickness: 1),

// // //                           const SizedBox(height: 8),

// // //                           // Product Name
// // //                           Text(
// // //                             item['productName'],
// // //                             style: const TextStyle(
// // //                               fontSize: 20,
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),

// // //                           const SizedBox(height: 12),

// // //                           // Details Row
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               _buildDetailColumn(
// // //                                 'Total',
// // //                                 '${item['total']}',
// // //                                 isTotal: true,
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildDetailColumn(String label, String value, {bool isTotal = false}) {
// // //     return Row(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Text(
// // //           label,
// // //           style: TextStyle(
// // //             fontSize: 14,
// // //             color: Colors.grey[600],
// // //           ),
// // //         ),
// // //         const SizedBox(width: 8),
// // //         Text(
// // //           value,
// // //           style: TextStyle(
// // //             fontSize: 14,
// // //             fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
// // //             color: isTotal ? Colors.green : Colors.black87,
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // Delete confirmation dialog
// // //   void _showDeleteDialog(BuildContext context, int index) {
// // //     showDialog(
// // //       context: context,
// // //       builder: (context) => AlertDialog(
// // //         title: const Text('Delete Item'),
// // //         content: const Text('Are you sure you want to delete this product?'),
// // //         actions: [
// // //           TextButton(
// // //             onPressed: () => Navigator.pop(context),
// // //             child: const Text('Cancel'),
// // //           ),
// // //           TextButton(
// // //             onPressed: () {
// // //               // TODO: Remove item from your data source (list, database, etc.)
// // //               // For now, we'll just show a snackbar
// // //               Navigator.pop(context);
// // //               ScaffoldMessenger.of(context).showSnackBar(
// // //                 const SnackBar(
// // //                   content: Text('Item deleted successfully'),
// // //                   backgroundColor: Colors.green,
// // //                 ),
// // //               );
// // //             },
// // //             style: TextButton.styleFrom(foregroundColor: Colors.red),
// // //             child: const Text('Delete'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }



//  import 'package:flutter/material.dart';

// // // class ViewStock extends StatelessWidget {
// // //   const ViewStock({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         centerTitle: true,
// // //         title: const Text('View Purchase',style: TextStyle(color: Colors.white,fontSize: 19),),
// // //         backgroundColor: Colors.green,
// // //         leading: IconButton(
// // //           onPressed: () => Navigator.pop(context),
// // //           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
// // //           //tooltip: 'Back',
// // //         ),
// // //       ),
// // //       body: Row()
      
// // //     );
// // //   }
// // // }




// // // class PurchaseHistoryScreen extends StatefulWidget {
// // //   @override
// // //   _PurchaseHistoryScreenState createState() => _PurchaseHistoryScreenState();
// // // }

// // // class _PurchaseHistoryScreenState extends State<PurchaseHistoryScreen> {

// // //   String? selectedSupplierId;
// // //   String? selectedInvoiceNo;

// // //   List suppliers = []; // from API
// // //   List purchases = []; // from API

// // //   Purchase? selectedPurchase;

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text("Purchase History")),
// // //       body: Column(
// // //         children: [

// // //           /// Supplier Dropdown
// // //           DropdownButtonFormField(
// // //             hint: Text("Select Supplier"),
// // //             value: selectedSupplierId,
// // //             items: suppliers.map<DropdownMenuItem>((e) {
// // //               return DropdownMenuItem(
// // //                 value: e['id'],
// // //                 child: Text(e['name']),
// // //               );
// // //             }).toList(),
// // //             onChanged: (value) {
// // //               setState(() {
// // //                 selectedSupplierId = value;
// // //                 selectedInvoiceNo = null;
// // //                 selectedPurchase = null;
// // //               });
// // //             },
// // //           ),

// // //           /// Invoice Dropdown (Filtered)
// // //           DropdownButtonFormField(
// // //             hint: Text("Select Invoice"),
// // //             value: selectedInvoiceNo,
// // //             items: purchases
// // //                 .where((p) => p.supplierId == selectedSupplierId)
// // //                 .map<DropdownMenuItem>((p) {
// // //               return DropdownMenuItem(
// // //                 value: p.invoiceNo,
// // //                 child: Text(p.invoiceNo),
// // //               );
// // //             }).toList(),
// // //             onChanged: (value) {
// // //               setState(() {
// // //                 selectedInvoiceNo = value;
// // //                 selectedPurchase = purchases.firstWhere(
// // //                         (p) => p.invoiceNo == value);
// // //               });
// // //             },
// // //           ),

// // //           SizedBox(height: 20),

// // //           /// Invoice Details
// // //           if (selectedPurchase != null) ...[
// // //             Text("Invoice Date: ${selectedPurchase!.invoiceDate}"),

// // //             Expanded(
// // //               child: ListView.builder(
// // //                 itemCount: selectedPurchase!.items.length,
// // //                 itemBuilder: (context, index) {
// // //                   final item = selectedPurchase!.items[index];

// // //                   return ListTile(
// // //                     title: Text(item.name),
// // //                     subtitle: Text("Qty: ${item.qty}"),

// // //                     trailing: IconButton(
// // //                       icon: Icon(Icons.delete, color: Colors.red),
// // //                       onPressed: () => deleteItem(item.id),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ),

// // //             /// Delete Full Invoice
// // //             ElevatedButton(
// // //               style: ElevatedButton.styleFrom(
// // //                   backgroundColor: Colors.red),
// // //               onPressed: deleteInvoice,
// // //               child: Text("Delete Invoice"),
// // //             )
// // //           ]
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   /// Delete Item
// // //   void deleteItem(String itemId) {
// // //     setState(() {
// // //       selectedPurchase!.items.removeWhere((e) => e.id == itemId);
// // //     });

// // //     // API call here
// // //   }

// // //   /// Delete Invoice
// // //   void deleteInvoice() {
// // //     setState(() {
// // //       purchases.removeWhere(
// // //               (p) => p.invoiceNo == selectedInvoiceNo);
// // //       selectedPurchase = null;
// // //       selectedInvoiceNo = null;
// // //     });

// // //     // API call here
// // //   }
// // // }





// class ViewStock extends StatelessWidget {
//   const ViewStock({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: const Text("Purchase List",style: TextStyle(fontWeight: FontWeight.bold,),),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [

//             /// 🔽 Supplier Dropdown
//             DropdownButtonFormField(
//               decoration: InputDecoration(
//                 labelText: "Select Supplier",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               items: const [],
//               onChanged: (value) {},
//             ),

//             const SizedBox(height: 16),

//             /// 🔽 Invoice Dropdown
//             DropdownButtonFormField(
//               decoration: InputDecoration(
//                 labelText: "Select Invoice",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               items: const [],
//               onChanged: (value) {},
//             ),

//             const SizedBox(height: 20),
//             DropdownButtonFormField(
//               decoration: InputDecoration(
//                 labelText: "Select Invoice Date",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               items: const [],
//               onChanged: (value) {},
//             ),

//             const SizedBox(height: 16),

//             /// 🧾 Purchase Items List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: 5, // dummy count
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: const EdgeInsets.only(bottom: 12),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Row(
//                       children: [

//                         /// Item Info
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Product ${index + 1}",
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w600),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "Qty: 10",
//                                 style: TextStyle(
//                                     color: Colors.grey.shade600),
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 "total: 10",
//                                 style: TextStyle(
//                                     color: Colors.grey.shade600),
//                               ),
//                             ],
//                           ),
//                         ),

//                         /// 🗑 Delete Button
//                         IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // /// ❌ Delete Invoice Button
//             // SizedBox(
//             //   width: double.infinity,
//             //   child: ElevatedButton.icon(
//             //     onPressed: () {},
//             //     icon: const Icon(Icons.delete),
//             //     label: const Text("Delete Invoice"),
//             //     style: ElevatedButton.styleFrom(
//             //       backgroundColor: Colors.red,
//             //       padding: const EdgeInsets.symmetric(vertical: 14),
//             //       shape: RoundedRectangleBorder(
//             //         borderRadius: BorderRadius.circular(12),
//             //       ),
//             //     ),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';

class ViewStock extends StatefulWidget {
  const ViewStock({super.key});

  @override
  State<ViewStock> createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {
  @override
  void initState() {
    super.initState();

    // Load purchase list initially
    Future.microtask(() {
      context.read<StockProvider>().getViewPurchases();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          "Purchase List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            // /// 🔽 SUPPLIER DROPDOWN
            // DropdownButtonFormField<int>(
            //   value: provider.selectedSupplierId,
            //   decoration: InputDecoration(
            //     labelText: "Select Supplier",
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //   ),
            //   items: provider.supplierIds.map((id) {
            //     return DropdownMenuItem(
            //       value: id,
            //       child: Text(purchase.),
            //     );
            //   }).toList(),
            //   onChanged: (value) {
            //     provider.setSupplier(value);
            //   },
            // ),

            DropdownButtonFormField<int>(
              value: provider.selectedSupplierId,
              decoration: InputDecoration(
                labelText: "Select Supplier",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              items: provider.uniqueSuppliers.map((supplier) {
                return DropdownMenuItem<int>(
                  value: supplier.id,
                  child: Text(supplier.name ?? "Unknown"),
                );
              }).toList(),

              onChanged: (value) {
                provider.setSupplier(value);
              },
            ),

            const SizedBox(height: 16),

            /// 🔽 INVOICE DROPDOWN
            DropdownButtonFormField<int>(
              value: provider.selectedPurchaseId,
              decoration: InputDecoration(
                labelText: "Select Invoice",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: provider.filteredInvoices.map((purchase) {
                return DropdownMenuItem(
                  value: purchase.id,
                  child: Text(purchase.invoiceNo ?? ""),
                );
              }).toList(),
              onChanged: (value) {
                final selectedPurchase = provider.filteredInvoices
                    .firstWhere((e) => e.id == value);

                provider.setInvoice(selectedPurchase);
              },
            ),

            const SizedBox(height: 16),

            /// 🔽 INVOICE DATE
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Invoice Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              controller: TextEditingController(
                text: provider.selectedInvoiceDate != null
                    ? provider.formatDate(provider.selectedInvoiceDate!)
                    : "",
              ),
            ),

            const SizedBox(height: 20),

            /// 🧾 PURCHASE DETAILS LIST
            Expanded(
              child: provider.purchasedetailList.isEmpty
                  ? const Center(child: Text("No Data"))
                  : ListView.builder(
                      itemCount: provider.purchasedetailList.length,
                      itemBuilder: (context, index) {
                        final item = provider.purchasedetailList[index];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [

                              /// DETAILS
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product : ${item.product?.name ?? 'Unknown'}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 4),
                                    Text("Qty: ${item.qty}"),
                                    const SizedBox(height: 4),
                                    Text("Total: ${item.subTot}"),
                                  ],
                                ),
                              ),

                              // /// DELETE
                              // IconButton(
                              //   onPressed: () {
                              //     provider.purchasedetailList
                              //         .removeAt(index);
                              //     provider.notifyListeners();
                              //   },
                              //   icon: const Icon(
                              //     Icons.delete,
                              //     color: Colors.red,
                              //   ),
                              // )
                              IconButton(
                                onPressed: () {
                                  final provider = context.read<StockProvider>();
                                  final item = provider.purchasedetailList[index];

                                  provider.deletePurchaseItem(
                                    id: item.id.toString(), //  important
                                    index: index,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
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
}