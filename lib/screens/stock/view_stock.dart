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

            // ///  SUPPLIER DROPDOWN
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

            ///  INVOICE DROPDOWN
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

            ///  INVOICE DATE
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

            ///  PURCHASE DETAILS LIST
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
                                      "Code : ${item.product?.code ?? '1'}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
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