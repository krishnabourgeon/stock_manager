// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
// import 'package:flutter/material.dart' as pw;
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_sunmi_printer_plus/column_maker.dart';
// import 'package:flutter_sunmi_printer_plus/flutter_sunmi_printer_plus.dart';
// import 'package:pdf/widgets.dart';
// import 'package:pdf/widgets.dart' as pw;
// // import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/screens/customer_creation/customer_selection_screen.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/validation_helper.dart';
import 'package:stock_manager/widgets/punnyam_textfiled.dart';
import '../../../common/common_button.dart';
// import 'package:flutter_sunmi_printer_plus/sunmi_style.dart';
// import 'package:flutter_sunmi_printer_plus/enums.dart';
import '../../../models/save_bill_response.dart';

class PreviewBillButton extends StatefulWidget {
  const PreviewBillButton(
      {Key? key,
      required this.previewBillProvider,
      required this.buildContext,
      required this.trans})
      : super(key: key);
  final BillingProvider previewBillProvider;
  final BuildContext buildContext;
  final TextEditingController trans;
  @override
  State<PreviewBillButton> createState() => _PreviewBillButtonState();
}

class _PreviewBillButtonState extends State<PreviewBillButton> {
  // BlueThermalPrinter printer = BlueThermalPrinter.instance;
  List<PoojaPersons> person = [];
  List<Details> details = [];
  Temple? temple;
  Summary? summary;
  @override
  void initState() {
    Future.microtask(() {
      // widget.previewBillProvider.checkPrinter();
      initAll();
    });
    super.initState();
  }

//   Future<void> generatePdf() async {
//   final pdf = pw.Document();

//   final provider = widget.previewBillProvider;

//   List<String> poojaString = [];
//   for (int i = 0; i < provider.person.length; i++) {
//     poojaString.add(
//         "${provider.person[i].id}) ${provider.person[i].date}\n"
//         "Category: ${provider.person[i].dietyName}\n"
//         "Product: ${provider.person[i].poojaName} - ${provider.person[i].rate}\n");
//   }

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) {
//         return pw.Padding(
//           padding: const pw.EdgeInsets.all(16),
//           child: pw.Column(
//             crossAxisAlignment: pw.CrossAxisAlignment.start,
//             children: [
//               pw.Text("Bill Receipt",
//                   style: pw.TextStyle(
//                       fontSize: 20, fontWeight: pw.FontWeight.bold)),

//               pw.SizedBox(height: 10),

//               pw.Text("Date: ${provider.summary?.billDate ?? ''}"),
//               pw.Text("Bill No: ${provider.summary?.id ?? ''}"),
//               pw.Text("Name: ${provider.temple?.name ?? ''}"),
//               pw.Text("Email: ${provider.temple?.email ?? ''}"),
//               pw.Text("Branch: ${provider.summary?.counter ?? ''}"),

//               pw.SizedBox(height: 10),

//               pw.Text("Product Details:",
//                   style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),

//               pw.SizedBox(height: 5),

//               pw.Column(
//                 crossAxisAlignment: pw.CrossAxisAlignment.start,
//                 children: poojaString
//                     .map((e) => pw.Text(e))
//                     .toList(),
//               ),

//               pw.SizedBox(height: 10),

//               pw.Text("Payment Mode: ${provider.summary?.mode ?? ''}"),
//               pw.Text("Total Amount: ${provider.summary?.total ?? ''}"),
//               pw.Text("Amount Paid: ${provider.summary?.recvAmt ?? ''}"),

//               pw.SizedBox(height: 10),

//               pw.Text("Book Online: ${provider.temple?.website ?? ''}"),
//             ],
//           ),
//         );
//       },
//     ),
//   );

//   await Printing.layoutPdf(
//     onLayout: (format) async => pdf.save(),
//   );
// }

  Future<void> downloadPreviewBillPdf() async {
    final pdf = pw.Document();

    final provider = widget.previewBillProvider;

    /// ✅ Extract data BEFORE pdf build
    final summary = provider.summary;
    final temple = provider.temple;
    final persons = provider.person;

    /// ✅ Create pooja list string
    List<String> poojaString = [];

    for (int i = 0; i < persons.length; i++) {
      poojaString.add(
        "${persons[i].id}) ${persons[i].date}\n"
        "Category: ${persons[i].dietyName}\n"
        "Product: ${persons[i].poojaName} - ${persons[i].rate}\n",
      );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                /// 🔷 TITLE
                pw.Center(
                  child: pw.Text(
                    "TEMPLE RECEIPT",
                    style: pw.TextStyle(
                      fontSize: 20,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 20),

                /// 🔷 DETAILS
                pw.Text("Date: ${summary?.billDate ?? ''}"),
                pw.Text("Bill No: ${summary?.id ?? ''}"),
                pw.Text("Customer: ${temple?.name ?? ''}"),
                pw.Text("Branch: ${summary?.counter ?? ''}"),
                pw.Text("Email: ${temple?.email ?? ''}"),

                pw.SizedBox(height: 10),

                /// 🔷 PRODUCT DETAILS
                pw.Text(
                  "Product Details:\n${poojaString.join("\n")}",
                ),

                pw.SizedBox(height: 10),

                /// 🔷 PAYMENT
                pw.Text("Payment Mode: ${summary?.mode ?? ''}"),
                pw.Text("Total Amount: ${summary?.total ?? ''}"),
                pw.Text("Amount Paid: ${summary?.recvAmt ?? ''}"),

                pw.SizedBox(height: 10),

                pw.Text("Book Online: ${temple?.website ?? ''}"),
              ],
            ),
          );
        },
      ),
    );

    /// ✅ DOWNLOAD / PREVIEW
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  BillingProvider? bill;
  routeTo(BuildContext buildContext) {
    Navigator.pushAndRemoveUntil(
      buildContext,
      MaterialPageRoute(
          builder: (buildContext) => const CustomerSelectionScreen()),
      (route) => true,
    ).then((value) {
      widget.previewBillProvider.previewDetailsList.clear();
      widget.previewBillProvider.poojaDetailsList.clear();
    });
  }

  Future<void> initAll() async {
    Future.microtask(() {
      final provider = widget.previewBillProvider;
      person.clear();
      widget.previewBillProvider.updatetransid(widget.trans.text);
      details = provider.saveBillResponse?.details ?? [];
      temple = provider.saveBillResponse?.temple;
      summary = provider.saveBillResponse?.summary;
      widget.previewBillProvider
          .updateTemple(provider.saveBillResponse?.temple);
      widget.previewBillProvider
          .updateSummary(provider.saveBillResponse?.summary);
      for (int i = 0; i < details.length; i++) {
        person.add(PoojaPersons(
            id: (i + 1).toString(),
            date: details[i].date.toString(),
            // gothra: details[i].gothra?.nameEng,
            // rashi: details[i].rashi?.nameEng,
            dietyName: details[i].deity.toString(),
            name: details[i].name ?? 'Customer'.toString(),
            address: details[i].address.toString(),
            poojaName: details[i].pooja.toString(),
            rate: "${details[i].qty}/${details[i].rate}",
            star: details[i].star.toString()));
      }
    });

    bill = widget.previewBillProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 5.r,
                blurRadius: 10.r),
            BoxShadow(
                color: Colors.black.withOpacity(.2),
                spreadRadius: 5.r,
                blurRadius: 10.r)
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CommonButton(
                onPressed: () {
                  widget.previewBillProvider.previewDetailsList.clear();
                  widget.previewBillProvider.poojaDetailsList.clear();
                  widget.previewBillProvider.nameController.clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerSelectionScreen()),
                    (route) => route.isFirst,
                  );
                },
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                title: 'Discard',
              ),
              CommonButton(
                onPressed:
                    widget.previewBillProvider.paidAmountErrorMessage == null &&
                            widget.previewBillProvider.paidAmountController.text
                                .trim()
                                .isNotEmpty
                        ? () async {
                            await widget.previewBillProvider
                                .updatetransid(widget.trans.text);
                            widget.previewBillProvider.saveBill(
                                onSuccess: () {
                                  initAll().then((value) {
                                    posPrinter(bill!);
                                  }).then((value) {
                                    routeTo(widget.buildContext);
                                    //showpop(widget.buildContext);
                                    showAfterSaveOptions(widget.buildContext);
                                  });
                                },
                                onFailure: () => Helpers.successToast(
                                    'Oops...! Something went wrong...'));
                          }
                        : null,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                title: 'Save Bill',
                colors: [
                  widget.previewBillProvider.paidAmountErrorMessage == null &&
                          widget.previewBillProvider.paidAmountController.text
                              .trim()
                              .isNotEmpty
                      ? Colors.green
                      : Colors.green.withOpacity(.5),
                  widget.previewBillProvider.paidAmountErrorMessage == null &&
                          widget.previewBillProvider.paidAmountController.text
                              .trim()
                              .isNotEmpty
                      ? Colors.greenAccent
                      : Colors.green
                ],
              ),
              // CommonButton(
              //   onPressed: () async {
              //     await downloadPreviewBillPdf();
              //   },
              //   margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //   title: 'Download PDF',
              // ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ));
  }

  void showAfterSaveOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Bill Saved Successfully"),
          // content: const Text("Choose an option"),
          actions: [
            // /// 📄 DOWNLOAD PDF
            // TextButton(
            //   onPressed: () async {
            //     Navigator.pop(context);
            //     await downloadPreviewBillPdf();
            //   },
            //   child: const Text("Download PDF"),
            // ),

            /// 📲 SHARE PDF
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await sharePdfToWhatsApp();
              },
              child: const Text("Share WhatsApp"),
            ),
          ],
        );
      },
    );
  }

  Future<void> sharePdfToWhatsApp() async {
    final pdf = pw.Document();

    final provider = widget.previewBillProvider;
    final summary = provider.summary;
    final temple = provider.temple;
    final persons = provider.person;

    List<String> poojaString = [];

    for (int i = 0; i < persons.length; i++) {
      poojaString.add(
        "${persons[i].id}) ${persons[i].date}\n"
        "Category: ${persons[i].dietyName}\n"
        "Product: ${persons[i].poojaName} - ${persons[i].rate}\n",
      );
    }

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("BILL RECEIPT",
                  style: pw.TextStyle(
                    fontSize: 20,
                  )),
              pw.SizedBox(height: 15),
              pw.Text("Bill No: ${summary?.id ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Customer: ${temple?.name ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Date: ${summary?.billDate ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Branch: ${summary?.counter}"),
              pw.SizedBox(height: 10),
              pw.Text("Email: ${temple?.email}"),
              pw.SizedBox(height: 10),
              pw.Text("Details:\n${poojaString.join("\n")}"),
              pw.SizedBox(height: 10),
              pw.Text("Payment Mode: ${summary?.mode ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Total Amount: ${summary?.total ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Amount Paid: ${summary?.recvAmt ?? ''}"),
              pw.SizedBox(height: 10),
              pw.Text("Book Online: ${temple?.website ?? ''}"),
              pw.SizedBox(height: 10),
            ],
          );
        },
      ),
    );

    ///  Convert to bytes
    final bytes = await pdf.save();

    ///  Share
    await Printing.sharePdf(
      bytes: bytes,
      filename: "bill_${summary?.id ?? 'receipt'}.pdf",
    );
  }

  showPopUp(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Please enter a mobile number",
            style: TextStyle(fontSize: 13.sp),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: PunnyamTextField(
                    hintText: 'Mobile Number',
                    maxLength: 10,
                    height: 35.h,
                    textEditingController:
                        context.read<BillingProvider>().mobileNumberController,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => context.read<BillingProvider>()
                      ..updateValidationMessage(
                          validationTypes: ValidationTypes.mobileNumber,
                          validationMessage:
                              ValidationHelperClass.validateMobileNumber(
                                      value.trim()) ??
                                  '')
                      ..updatePreviewBillingFormValidated(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                        widget.trans.clear();
                        widget.previewBillProvider.clearValues();
                        widget.previewBillProvider.previewDetailsList.clear();
                        widget.previewBillProvider.poojaDetailsList.clear();
                        widget.previewBillProvider.nameController.clear();
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        if (context
                                .read<BillingProvider>()
                                .mobileErrorMessage !=
                            null) {
                          Helpers.successToast(
                              'Please provide a valid mobile number');
                        } else {
                          Navigator.pop(context);
                          FocusScope.of(context).unfocus();
                          List<String> poojaString = [];
                          for (int i = 0;
                              i < context.read<BillingProvider>().person.length;
                              i++) {
                            poojaString.add(
                                "\n*${context.read<BillingProvider>().person[i].id?.trim()})*\Bill Date: *${context.read<BillingProvider>().person[i].date?.trim()}*,\nCategory Name: *${context.read<BillingProvider>().person[i].dietyName?.trim()}*\nProduct: *${context.read<BillingProvider>().person[i].poojaName?.trim()}* - *${context.read<BillingProvider>().person[i].rate}*");
                          }

                          String text =
                              'Date: *${context.read<BillingProvider>().summary?.billDate?.trim()}*\n\nBill No: *${context.read<BillingProvider>().summary?.id}*\n\n Name: *${context.read<BillingProvider>().temple?.name?.trim()}*\n\n Email: *${context.read<BillingProvider>().temple?.email?.trim()}*\n\nBranch: *${context.read<BillingProvider>().summary?.counter?.trim()}*\n\nProduct Details:\n${poojaString.toString().substring(1, poojaString.toString().length - 1)}\n\nPayment Mode: *${context.read<BillingProvider>().summary?.mode}*\n\nTotal Amount: *${context.read<BillingProvider>().summary?.total?.trim()}*\n\nAmount Paid: *${context.read<BillingProvider>().summary?.recvAmt?.trim()}*\n\nBook Online: *${context.read<BillingProvider>().temple?.website}*';

                          context
                              .read<BillingProvider>()
                              .launchWhatsAppUri(text);
                        }
                        widget.trans.clear();
                        widget.previewBillProvider.clearValues();
                        widget.previewBillProvider.previewDetailsList.clear();
                        widget.previewBillProvider.poojaDetailsList.clear();
                        widget.previewBillProvider.nameController.clear();
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  showpop(BuildContext context) {
    showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Do you want to share the receipt in whatsapp",
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                          title: "No",
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            widget.trans.clear();
                            widget.previewBillProvider.clearValues();
                            widget.previewBillProvider.previewDetailsList
                                .clear();
                            widget.previewBillProvider.poojaDetailsList.clear();
                            widget.previewBillProvider.nameController.clear();
                          }),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: CommonButton(
                          title: "Yes",
                          onPressed: () {
                            Navigator.of(context).pop(false);
                            showPopUp(widget.buildContext);
                          }),
                    )
                  ],
                )
              ]);
        });
  }

  static const platform = MethodChannel('cloudpos/printer');

  // Future<void> printReceipt() async {
  //   try {
  //     await platform.invokeMethod('printReceipt', {
  //       "shop": "MY SHOP",
  //       "items": [
  //         {"name": "Milk", "qty": 2, "rate": 30},
  //         {"name": "Bread", "qty": 1, "rate": 50},
  //       ]
  //     });
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

//? sunmi printer
  posPrinter(BillingProvider previewBillProvider) async {
    List<Map<String, dynamic>> items = [];

    final details = previewBillProvider.saveBillResponse?.details ?? [];
    DateTime dateTime = DateTime.parse(DateTime.now().toString());

// 🔹 Format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    for (var item in details) {
      items.add({
        "type": item.deity ?? '',
        "name": item.pooja ?? "",
        "qty": item.qty ?? 0,
        "rate": item.rate ?? 0,
      });
    }
    try {
      await platform.invokeMethod('printReceipt', {
        "shop": temple?.name,
        "shopaddress": temple?.addressLine1,
        "shopaddress2": temple?.addressLine2,
        "items": items,
        "mode": summary?.mode,
        "bill": summary?.id,
        "billdate": formattedDate,
        "billtime": formattedTime
      });
    } catch (e) {
      print("Error: $e");
    }
    // if (widget.previewBillProvider.isConnected) {
    //   if (widget.previewBillProvider.printerErrorMessage.isEmpty) {
    //     await SunmiPrinter.initPrinter();
    //     SunmiStyle(fontSize: 26, bold: true);
    //     await SunmiPrinter.setAlignment(align: SunmiPrintAlign.CENTER);
    //     await SunmiPrinter.lineWrap(1);
    //     previewBillProvider.saveBillResponse?.billImage == null ||
    //             previewBillProvider.saveBillResponse?.billImage == '' ||
    //             previewBillProvider.imageData == null
    //         ? null
    //         : await SunmiPrinter.printImage(
    //             image: previewBillProvider.imageData!,
    //             align: SunmiPrintAlign.CENTER);
    //     previewBillProvider.saveBillResponse?.billImage == null ||
    //             previewBillProvider.saveBillResponse?.billImage == ''
    //         ? null
    //         : await SunmiPrinter.lineWrap(2);
    //     await SunmiPrinter.printText(
    //         content: "${temple?.nameMal}",
    //         style: SunmiStyle(
    //             fontSize: 28,
    //             isUnderLine: false,
    //             bold: true,
    //             align: SunmiPrintAlign.CENTER));
    //     await SunmiPrinter.lineWrap(1);
    //     await SunmiPrinter.printText(
    //         content: "${temple?.addressLine1}\n",
    //         style: SunmiStyle(
    //             fontSize: 24,
    //             isUnderLine: false,
    //             bold: true,
    //             align: SunmiPrintAlign.CENTER));
    //     await SunmiPrinter.printText(
    //         content: "${temple?.addressLine2}\n",
    //         style: SunmiStyle(
    //             fontSize: 24,
    //             isUnderLine: false,
    //             bold: true,
    //             align: SunmiPrintAlign.CENTER));
    //     await SunmiPrinter.printText(
    //         content: "${temple?.phone}\n",
    //         style: SunmiStyle(
    //             fontSize: 25,
    //             isUnderLine: false,
    //             bold: true,
    //             align: SunmiPrintAlign.CENTER));
    //     await SunmiPrinter.lineWrap(1);
    //     await SunmiPrinter.printTable(
    //       // style: SunmiStyle(fontSize: 25),
    //       cols: [
    //         ColumnMaker(
    //             text: "Bill No: ${summary?.id}",
    //             align: SunmiPrintAlign.LEFT,
    //             width: 10),
    //         ColumnMaker(text: today, align: SunmiPrintAlign.RIGHT)
    //       ],
    //     );
    //     await SunmiPrinter.lineWrap(1);
    //     int? lenn = previewBillProvider.saveBillResponse?.details?.length;
    //     List<Details>? data = previewBillProvider.saveBillResponse?.details;
    //     for (int i = 0; i < lenn!; i++) {
    //       List datass = [];
    //       RegExp datePattern = RegExp(r'\d{2}-\d{2}-\d{4}');
    //       Iterable<Match> matches = datePattern.allMatches("${data![i].date}");

    //       for (Match match in matches) {
    //         datass.add("${match.group(0)}");
    //       }
    //       print(
    //           "...${previewBillProvider.person[i].id}) ${data[i].deityMal}\n${previewBillProvider.person[i].name} - ${data[i].starMal}\n${data[i].poojaMal} ${data[i].qty}x${data[i].rate}\n");
    //       await SunmiPrinter.printText(
    //           content:
    //               "${previewBillProvider.person[i].id}) ${data[i].deityMal}\n",
    //           style: SunmiStyle(
    //               fontSize: 26,
    //               isUnderLine: false,
    //               bold: false,
    //               align: SunmiPrintAlign.LEFT));

    //       await SunmiPrinter.printText(
    //           content:
    //               "${previewBillProvider.person[i].name} - ${data[i].starMal}\n",
    //           style: SunmiStyle(
    //               fontSize: 26,
    //               isUnderLine: false,
    //               bold: false,
    //               align: SunmiPrintAlign.LEFT));
    //       // await SunmiPrinter.printText(
    //       //     content:
    //       //         "${previewBillProvider.person[i].gothra} - ${previewBillProvider.person[i].rashi}\n",
    //       //     style: SunmiStyle(
    //       //         fontSize: 26,
    //       //         isUnderLine: false,
    //       //         bold: false,
    //       //         align: SunmiPrintAlign.LEFT));
    //       await SunmiPrinter.printText(
    //           content: "${data[i].poojaMal} ${data[i].qty}x${data[i].rate}\n",
    //           style: SunmiStyle(
    //               fontSize: 26,
    //               isUnderLine: false,
    //               bold: false,
    //               align: SunmiPrintAlign.LEFT));
    //       for (int n = 0; n < datass.length; n += 2) {
    //         if (n + 1 < datass.length) {
    //           print("..${datass[n]}, ${datass[n + 1]}");
    //           await SunmiPrinter.printText(
    //               content: "${datass[n]}, ${datass[n + 1]}",
    //               style: SunmiStyle(
    //                   fontSize: 26,
    //                   isUnderLine: false,
    //                   bold: false,
    //                   align: SunmiPrintAlign.LEFT));
    //         } else {
    //           if (datass.length > 1) {
    //             await SunmiPrinter.printText(
    //                 content: ",\n${datass[n]}\n",
    //                 style: SunmiStyle(
    //                     fontSize: 26,
    //                     isUnderLine: false,
    //                     bold: false,
    //                     align: SunmiPrintAlign.LEFT));
    //           } else {
    //             await SunmiPrinter.printText(
    //                 content: "${datass[n]}\n",
    //                 style: SunmiStyle(
    //                     fontSize: 26,
    //                     isUnderLine: false,
    //                     bold: false,
    //                     align: SunmiPrintAlign.LEFT));
    //           }
    //         }
    //       }
    //       data[i].address == null
    //           ? ''
    //           : await SunmiPrinter.printText(
    //               content: "${data[i].address}\n",
    //               style: SunmiStyle(
    //                   fontSize: 26,
    //                   isUnderLine: false,
    //                   bold: false,
    //                   align: SunmiPrintAlign.LEFT));
    //       await SunmiPrinter.lineWrap(1);
    //     }
    //     await SunmiPrinter.printTable(
    //       // style: SunmiStyle(fontSize: 27, bold: true),
    //       cols: [
    //         ColumnMaker(
    //           text: "Mode: ${summary?.mode}",
    //           align: SunmiPrintAlign.LEFT,
    //         ),
    //         ColumnMaker(
    //           text: "Total: ${summary?.total}",
    //           align: SunmiPrintAlign.RIGHT,
    //         ),
    //       ],
    //     );
    //     await SunmiPrinter.lineWrap(1);
    //     await SunmiPrinter.printText(
    //         content: "Book Online ${temple?.website} \n",
    //         style: SunmiStyle(
    //             fontSize: 24,
    //             isUnderLine: false,
    //             bold: true,
    //             align: SunmiPrintAlign.CENTER));
    //     await SunmiPrinter.lineWrap(1);
    //     await SunmiPrinter.feedPaper();
    //     await SunmiPrinter.cutPaper().then((value) {
    //       Helpers.successToast('Bill Saved & Printed Successfully');
    //     });
    //     // bill?.clearValues();
    //     // widget.previewBillProvider.clearValues();
    //     // widget.previewBillProvider.previewDetailsList.clear();
    //     // widget.previewBillProvider.poojaDetailsList.clear();
    //   } else {
    //     Helpers.successToast(widget.previewBillProvider.printerErrorMessage);
    //   }
    // }

//? .....thermal bluetooth print

//     else {
//       DateTime time = DateTime.now();
//       String? today = "${time.day}/${time.month}/${time.year}";
//       // List<LineText> list = [];
//       previewBillProvider.saveBillResponse?.billimage == null ||
//               previewBillProvider.saveBillResponse?.billimage == ''
//           ? null
//           : await printer.printImageBytes(previewBillProvider.imageData!);
//       previewBillProvider.saveBillResponse?.billimage == null ||
//               previewBillProvider.saveBillResponse?.billimage == ''
//           ? null
//           : await printer.printNewLine();

//       await printer.printCustom('${temple?.name}', 3, 1);
// //  await printer.printCustom('${temple?.addressLine1}', 1, 1);
// //     await printer.printCustom('${temple?.addressLine2}', 1, 1);
//       await printer.printCustom('${temple?.phone}', 1, 1);
//       // await printer.printNewLine();

//       await printer.printCustom(
//           "________________________________________", 1, 1);
//       await printer.printLeftRight(
//         'Bill No : ${summary?.id} ',
//         today,
//         1,
//       );

//       await printer.printCustom(
//           "________________________________________", 1, 1);
//       previewBillProvider.person.length == 1
//           ? await printer.printNewLine()
//           : null;

// //       // list.add(LineText(
// //       //     type: LineText.TYPE_TEXT,
// //       //     content: '${temple?.name}',
// //       //     size: 33,
// //       //     align: LineText.ALIGN_CENTER,
// //       //     linefeed: 1));
// //       // list.add(LineText(
// //       //     type: LineText.TYPE_TEXT,
// //       //     content: '${temple?.addressLine1}',
// //       //     size: 22,
// //       //     align: LineText.ALIGN_CENTER,
// //       //     linefeed: 1));
// //       // list.add(LineText(
// //       //     type: LineText.TYPE_TEXT,
// //       //     content: '${temple?.addressLine1}',
// //       //     size: 22,
// //       //     align: LineText.ALIGN_CENTER,
// //       //     linefeed: 1));
// //       // list.add(LineText(
// //       //     type: LineText.TYPE_TEXT,
// //       //     content: '${temple?.phone}',
// //       //     size: 22,
// //       //     align: LineText.ALIGN_CENTER,
// //       //     linefeed: 1));
// //       // list.add(LineText(linefeed: 1));
// //       // list.add(LineText(
// //       //     type: LineText.TYPE_TEXT,
// //       //     content: 'Bill No : ${summary?.id} ',
// //       //     size: 25,
// //       //     align: LineText.ALIGN_LEFT,
// //       //     linefeed: 0));

//       for (int i = 0; i < previewBillProvider.person.length; i++) {
//         String? date = DateFormat('dd-MM-yyyy').format(DateTime.parse(
//             "${previewBillProvider.previewDetailsList[i].fromDate}"));
//         print("..date...$date");
//         await printer.printCustom(
//             "${previewBillProvider.person[i].id}) $date ${details[i].name} - ${details[i].star}",
//             1,
//             1);
//         // await printer.printCustom('${details[i].deity}', 1, 1);
//         await printer.printCustom(
//             '${details[i].pooja} ${details[i].qty}x${details[i].rate}', 1, 1);
//         details[i].address == null
//             ? ''
//             : await printer.printCustom('${details[i].address} ', 1, 1);

// //     //? another blutooth printing

// //     //     list.add(LineText(
// //     //       type: LineText.TYPE_TEXT,
// //     //       content:
// //     //           "${previewBillProvider.person[i].id}) $date ${details[i].starMal}",
// //     //       size: 25,
// //     //       align: LineText.ALIGN_RIGHT,
// //     //     ));

// //     //     list.add(LineText(
// //     //       type: LineText.TYPE_TEXT,
// //     //       content:
// //     //           '${details[i].poojaMal} ${details[i].qty}x${details[i].rate}',
// //     //       size: 22,
// //     //       align: LineText.ALIGN_LEFT,
// //     //     ));
// //     //     details[i].address == null
// //     //         ? ''
// //     //         : list.add(LineText(
// //     //             type: LineText.TYPE_TEXT,
// //     //             content: '${details[i].address} ',
// //     //             size: 22,
// //     //             align: LineText.ALIGN_LEFT,
// //     //           ));
//         await printer.printNewLine();
//       }
//       await printer.printCustom(
//           "________________________________________", 1, 1);

//       previewBillProvider.person.length == 1
//           ? await printer.printNewLine()
//           : null;

//       await printer.printLeftRight(
//           'Mode: ${summary?.mode}', 'Total: ${summary?.total}', 1);
//       await printer.printNewLine();
//       await printer.printCustom(
//           "________________________________________", 1, 1);
//       await printer.printCustom('Book online ${temple?.email}', 1, 1);
//       await printer.printNewLine();

//       await printer.paperCut();
// //     //? another blutooth printing

// //     //   list.add(LineText(linefeed: 1));
// //     //   list.add(LineText(
// //     //       type: LineText.TYPE_TEXT,
// //     //       content: 'Mode:${summary?.mode}        ',
// //     //       size: 24,
// //     //       align: LineText.ALIGN_LEFT,
// //     //       linefeed: 0));
// //     //   list.add(LineText(
// //     //       type: LineText.TYPE_TEXT,
// //     //       content: '    Total${summary?.total}',
// //     //       size: 24,
// //     //       align: LineText.ALIGN_RIGHT,
// //     //       linefeed: 1));
// //     //   list.add(LineText(
// //     //       type: LineText.TYPE_TEXT,
// //     //       content: 'Book online ${temple?.email}',
// //     //       weight: 1,
// //     //       align: LineText.ALIGN_CENTER,
// //     //       linefeed: 1));
// //     //   list.add(LineText(linefeed: 1));
// //     //   await bluetoothPrint.printReceipt(config, list);
// //     //   Helpers.successToast("POS Printer not connected");
//     }
    bill?.clearValues();
  }
}

class PoojaPersons {
  String? name = 'Customer';
  String? address;
  String? id;
  String? date;
  String? rate;
  String? qty;
  String? poojaName;
  String? star;
  String? dietyName;
  String? gothra;
  String? rashi;
  PoojaPersons({
    this.id,
    this.name,
    this.address,
    this.rate,
    this.qty,
    this.gothra,
    this.rashi,
    this.poojaName,
    this.star,
    this.dietyName,
    this.date,
  });
}
