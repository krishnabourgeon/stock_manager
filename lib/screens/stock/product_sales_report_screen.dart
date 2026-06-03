
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

class ProductSalesReportScreen extends StatefulWidget {
  const ProductSalesReportScreen({super.key});

  @override
  State<ProductSalesReportScreen> createState() =>
      _ProductSalesReportScreenState();
}

class _ProductSalesReportScreenState
    extends State<ProductSalesReportScreen> {

  final TextEditingController searchController =
      TextEditingController();

  final List<Map<String, dynamic>> salesReportList = [
    {
      "code": "P001",
      "product": "Vegetable Seeds",
      "qtySold": 120,
      "rate": 20,
      "amount": 2400,
      "unit": "Nos"
    },
    {
      "code": "P002",
      "product": "Organic Manure",
      "qtySold": 50,
      "rate": 150,
      "amount": 7500,
      "unit": "Kg"
    },
    {
      "code": "P003",
      "product": "Vermicompost",
      "qtySold": 35,
      "rate": 250,
      "amount": 8750,
      "unit": "Kg"
    },
  ];

  @override
  Widget build(BuildContext context) {

    // int totalQtySold = salesReportList.fold(
    //   0,
    //   (sum, item) => sum + (item['qtySold'] as int),
    // );

    // double totalSalesAmount = salesReportList.fold(
    //   0,
    //   (sum, item) => sum + (item['amount'] as num),
    // ).toDouble();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Product Sales Report",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await generatePdf();
            },
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            onPressed: () async {
              await sharePdfToWhatsApp();
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: 
        Column(
          children: [

            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Product",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Row(
            //   children: [

            //     Expanded(
            //       child: Card(
            //         child: ListTile(
            //           title:
            //               const Text("Products"),
            //           subtitle: Text(
            //             salesReportList.length
            //                 .toString(),
            //           ),
            //         ),
            //       ),
            //     ),

            //     Expanded(
            //       child: Card(
            //         child: ListTile(
            //           title:
            //               const Text("Qty Sold"),
            //           subtitle: Text(
            //             totalQtySold.toString(),
            //           ),
            //         ),
            //       ),
            //     ),

                // Expanded(
                //   child: Card(
                //     child: ListTile(
                //       title:
                //           const Text("Sales"),
                //       subtitle: Text(
                //         "₹${totalSalesAmount.toStringAsFixed(0)}",
                //       ),
                //     ),
                //   ),
                // ),
            //   ],
            // ),

            // const SizedBox(height: 15),

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  border:
                      TableBorder.all(color: Colors.grey),
                  headingRowColor:
                      MaterialStateProperty.all(
                    Colors.deepPurple,
                  ),
                  columns: const [
                    DataColumn(
                      label: Text(
                        "Sl No",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Code",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Product",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Qty Sold",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Rate",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Unit",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Action",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                  rows: salesReportList
                      .asMap()
                      .entries
                      .map((entry) {

                    int index = entry.key;
                    var sale = entry.value;

                    return DataRow(
                      cells: [
                        DataCell(
                          Text("${index + 1}"),
                        ),
                        DataCell(
                          Text(sale['code']),
                        ),
                        DataCell(
                          Text(sale['product']),
                        ),
                        DataCell(
                          Text(
                            sale['qtySold']
                                .toString(),
                          ),
                        ),
                        DataCell(
                          Text(
                            "₹${sale['rate']}",
                          ),
                        ),
                        DataCell(
                          Text(
                            "₹${sale['amount']}",
                            style:
                                const TextStyle(
                              color:
                                  Colors.green,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ),
                        DataCell(
                          Text(sale['unit']),
                        ),
                        DataCell(
                          InkWell(
                            onTap: () {
                              // Open sales details
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(
                                color:
                                    Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    Future<File> _createPdfFile() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      build: (context) => [
        pw.Text(
          'Product Wise Sales Report',
          style: pw.TextStyle(
            fontSize: 18,
            fontWeight: pw.FontWeight.bold,
          ),
        ),

        pw.SizedBox(height: 20),

        pw.Table(
          border: pw.TableBorder.all(),
          children: [
            pw.TableRow(
              decoration: const pw.BoxDecoration(
                color: PdfColors.green,
              ),
              children: [
                _headerCell('Sl No'),
                _headerCell('Code'),
                _headerCell('Product'),
                _headerCell('Qty Sold'),
                _headerCell('Rate'),
                _headerCell('Amount'),
                _headerCell('Unit'),
              ],
            ),

            ...salesReportList.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final item = entry.value;

                return pw.TableRow(
                  children: [
                    _cell("${index + 1}"),
                    _cell(item["code"].toString()),
                    _cell(item["product"].toString()),
                    _cell(item["qtySold"].toString()),
                    _cell(item["rate"].toString()),
                    _cell(item["amount"].toString()),
                    _cell(item["unit"].toString()),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    ),
  );

    final directory = await getTemporaryDirectory();

    final file = File(
      "${directory.path}/product_sales_report.pdf",
    );

    await file.writeAsBytes(
      await pdf.save(),
    );

    return file;
  }

  Future<void> generatePdf() async {
  final file = await _createPdfFile();

    await Printing.layoutPdf(
      onLayout: (_) async => file.readAsBytes(),
    );
  }

  Future<void> sharePdfToWhatsApp() async {
    final file = await _createPdfFile();

    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Product Wise Sales Report',
    );
  }

  pw.Widget _headerCell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(
      text,
      style: pw.TextStyle(
        color: PdfColors.white,
        fontWeight: pw.FontWeight.bold,
      ),
    ),
  );
}

pw.Widget _cell(String text) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(5),
    child: pw.Text(text),
  );
}
}

