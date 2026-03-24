// import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sunmi_printer_plus/column_maker.dart';
import 'package:flutter_sunmi_printer_plus/flutter_sunmi_printer_plus.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/screens/customer_creation/customer_selection_screen.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/validation_helper.dart';
import 'package:stock_manager/widgets/punnyam_textfiled.dart';
import '../../../common/common_button.dart';
import 'package:flutter_sunmi_printer_plus/sunmi_style.dart';
import 'package:flutter_sunmi_printer_plus/enums.dart';
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
      widget.previewBillProvider.checkPrinter();
      initAll();
    });
    super.initState();
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
                                    showpop(widget.buildContext);
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
                      : Colors.greenAccent.withOpacity(.5)
                ],
              ),
              SizedBox(height: 40.h,)
            ],
          ),
        ));
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

//? sunmi printer
  posPrinter(BillingProvider previewBillProvider) async {
    DateTime time = DateTime.now();
    String? today = "${time.day}/${time.month}/${time.year}";

    if (widget.previewBillProvider.isConnected) {
      if (widget.previewBillProvider.printerErrorMessage.isEmpty) {
        await SunmiPrinter.initPrinter();
        SunmiStyle(fontSize: 26, bold: true);
        await SunmiPrinter.setAlignment(align: SunmiPrintAlign.CENTER);
        await SunmiPrinter.lineWrap(1);
        previewBillProvider.saveBillResponse?.billImage == null ||
                previewBillProvider.saveBillResponse?.billImage == '' ||
                previewBillProvider.imageData == null
            ? null
            : await SunmiPrinter.printImage(
                image: previewBillProvider.imageData!,
                align: SunmiPrintAlign.CENTER);
        previewBillProvider.saveBillResponse?.billImage == null ||
                previewBillProvider.saveBillResponse?.billImage == ''
            ? null
            : await SunmiPrinter.lineWrap(2);
        await SunmiPrinter.printText(
            content: "${temple?.nameMal}",
            style: SunmiStyle(
                fontSize: 28,
                isUnderLine: false,
                bold: true,
                align: SunmiPrintAlign.CENTER));
        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.printText(
            content: "${temple?.addressLine1}\n",
            style: SunmiStyle(
                fontSize: 24,
                isUnderLine: false,
                bold: true,
                align: SunmiPrintAlign.CENTER));
        await SunmiPrinter.printText(
            content: "${temple?.addressLine2}\n",
            style: SunmiStyle(
                fontSize: 24,
                isUnderLine: false,
                bold: true,
                align: SunmiPrintAlign.CENTER));
        await SunmiPrinter.printText(
            content: "${temple?.phone}\n",
            style: SunmiStyle(
                fontSize: 25,
                isUnderLine: false,
                bold: true,
                align: SunmiPrintAlign.CENTER));
        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.printTable(
          // style: SunmiStyle(fontSize: 25),
          cols: [
            ColumnMaker(
                text: "Bill No: ${summary?.id}",
                align: SunmiPrintAlign.LEFT,
                width: 10),
            ColumnMaker(text: today, align: SunmiPrintAlign.RIGHT)
          ],
        );
        await SunmiPrinter.lineWrap(1);
        int? lenn = previewBillProvider.saveBillResponse?.details?.length;
        List<Details>? data = previewBillProvider.saveBillResponse?.details;
        for (int i = 0; i < lenn!; i++) {
          List datass = [];
          RegExp datePattern = RegExp(r'\d{2}-\d{2}-\d{4}');
          Iterable<Match> matches = datePattern.allMatches("${data![i].date}");

          for (Match match in matches) {
            datass.add("${match.group(0)}");
          }
          print(
              "...${previewBillProvider.person[i].id}) ${data[i].deityMal}\n${previewBillProvider.person[i].name} - ${data[i].starMal}\n${data[i].poojaMal} ${data[i].qty}x${data[i].rate}\n");
          await SunmiPrinter.printText(
              content:
                  "${previewBillProvider.person[i].id}) ${data[i].deityMal}\n",
              style: SunmiStyle(
                  fontSize: 26,
                  isUnderLine: false,
                  bold: false,
                  align: SunmiPrintAlign.LEFT));

          await SunmiPrinter.printText(
              content:
                  "${previewBillProvider.person[i].name} - ${data[i].starMal}\n",
              style: SunmiStyle(
                  fontSize: 26,
                  isUnderLine: false,
                  bold: false,
                  align: SunmiPrintAlign.LEFT));
          // await SunmiPrinter.printText(
          //     content:
          //         "${previewBillProvider.person[i].gothra} - ${previewBillProvider.person[i].rashi}\n",
          //     style: SunmiStyle(
          //         fontSize: 26,
          //         isUnderLine: false,
          //         bold: false,
          //         align: SunmiPrintAlign.LEFT));
          await SunmiPrinter.printText(
              content: "${data[i].poojaMal} ${data[i].qty}x${data[i].rate}\n",
              style: SunmiStyle(
                  fontSize: 26,
                  isUnderLine: false,
                  bold: false,
                  align: SunmiPrintAlign.LEFT));
          for (int n = 0; n < datass.length; n += 2) {
            if (n + 1 < datass.length) {
              print("..${datass[n]}, ${datass[n + 1]}");
              await SunmiPrinter.printText(
                  content: "${datass[n]}, ${datass[n + 1]}",
                  style: SunmiStyle(
                      fontSize: 26,
                      isUnderLine: false,
                      bold: false,
                      align: SunmiPrintAlign.LEFT));
            } else {
              if (datass.length > 1) {
                await SunmiPrinter.printText(
                    content: ",\n${datass[n]}\n",
                    style: SunmiStyle(
                        fontSize: 26,
                        isUnderLine: false,
                        bold: false,
                        align: SunmiPrintAlign.LEFT));
              } else {
                await SunmiPrinter.printText(
                    content: "${datass[n]}\n",
                    style: SunmiStyle(
                        fontSize: 26,
                        isUnderLine: false,
                        bold: false,
                        align: SunmiPrintAlign.LEFT));
              }
            }
          }
          data[i].address == null
              ? ''
              : await SunmiPrinter.printText(
                  content: "${data[i].address}\n",
                  style: SunmiStyle(
                      fontSize: 26,
                      isUnderLine: false,
                      bold: false,
                      align: SunmiPrintAlign.LEFT));
          await SunmiPrinter.lineWrap(1);
        }
        await SunmiPrinter.printTable(
          // style: SunmiStyle(fontSize: 27, bold: true),
          cols: [
            ColumnMaker(
              text: "Mode: ${summary?.mode}",
              align: SunmiPrintAlign.LEFT,
            ),
            ColumnMaker(
              text: "Total: ${summary?.total}",
              align: SunmiPrintAlign.RIGHT,
            ),
          ],
        );
        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.printText(
            content: "Book Online ${temple?.website} \n",
            style: SunmiStyle(
                fontSize: 24,
                isUnderLine: false,
                bold: true,
                align: SunmiPrintAlign.CENTER));
        await SunmiPrinter.lineWrap(1);
        await SunmiPrinter.feedPaper();
        await SunmiPrinter.cutPaper().then((value) {
          Helpers.successToast('Bill Saved & Printed Successfully');
        });
        // bill?.clearValues();
        // widget.previewBillProvider.clearValues();
        // widget.previewBillProvider.previewDetailsList.clear();
        // widget.previewBillProvider.poojaDetailsList.clear();
      } else {
        Helpers.successToast(widget.previewBillProvider.printerErrorMessage);
      }
    }

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
