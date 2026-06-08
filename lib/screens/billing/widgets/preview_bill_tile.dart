// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';
// // import 'package:stock_manager/providers/billing_provider.dart';
// // import 'package:stock_manager/screens/billing/widgets/preview_bill_row_widget.dart';
// // import 'package:stock_manager/screens/register/register_screen.dart';
// // import 'package:stock_manager/services/helpers.dart';
// // import 'package:stock_manager/widgets/punnyam_textfiled.dart';
// // import '../../../common/color_palette.dart';
// // import '../../../common/custom_drop_down_search.dart';
// // import '../../../models/save_bill_body.dart';

// // class PreviewBillTile extends StatelessWidget {
// //   const PreviewBillTile(
// //       {Key? key, required this.previewBillProvider, required this.trans})
// //       : super(key: key);
// //   final BillingProvider previewBillProvider;
// //   final TextEditingController trans;

// //   @override
// //   Widget build(BuildContext context) {
// //     return SingleChildScrollView(
// //       child: Container(
// //         padding: EdgeInsets.symmetric(horizontal: 20.w),
// //         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// //           Row(
// //             children: [
// //               Expanded(
// //                 flex: 4,
// //                 child: Text(
// //                   "Sub Total",
// //                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               Expanded(
// //                 flex: 6,
// //                 child: PunnyamTextField(
// //                   isEnabled: false,
// //                   textEditingController:
// //                       context.read<BillingProvider>().subTotalController,
// //                   textInputAction: TextInputAction.next,
// //                   keyboardType: TextInputType.number,
// //                   hintStyle: TextStyle(
// //                     fontSize: 14.sp,
// //                     color: Colors.grey.shade600,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           10.verticalSpace,
// //           Row(
// //             children: [
// //               Expanded(
// //                 flex: 4,
// //                 child: Text(
// //                   "Discount",
// //                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               Expanded(
// //                 flex: 6,
// //                 child: PunnyamTextField(
// //                   height: 45.h,
// //                   textEditingController: previewBillProvider.discountController,
// //                   textInputAction: TextInputAction.next,
// //                   keyboardType: TextInputType.number,

// //                   ///  CHANGE THIS
// //                   hintText: "Discount",

// //                   hintStyle: TextStyle(
// //                     fontSize: 14.sp,
// //                     color: Colors.grey.shade600,
// //                   ),
// //                   onChanged: (value) {
// //                     previewBillProvider.updatePreviewRate();
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //           10.verticalSpace,
// //           Row(
// //             children: [
// //               Expanded(
// //                 flex: 4,
// //                 child: Text(
// //                   "Grand Total",
// //                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
// //                 ),
// //               ),
// //               Expanded(
// //                 flex: 6,
// //                 child: PunnyamTextField(
// //                   isEnabled: false,
// //                   textEditingController:
// //                       context.read<BillingProvider>().totalRateController,
// //                   textInputAction: TextInputAction.next,
// //                   keyboardType: TextInputType.number,
// //                   hintStyle: TextStyle(
// //                     fontSize: 14.sp,
// //                     color: Colors.grey.shade600,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           10.verticalSpace,
// //           // PunnyamTextField(
// //           //   hintText: "paid Amount",
// //           //   textInputAction: TextInputAction.done,
// //           //   keyboardType: TextInputType.number,
// //           //   textEditingController:
// //           //       context.read<BillingProvider>().paidAmountController,
// //           //   hintStyle: TextStyle(
// //           //     fontSize: 14.sp,
// //           //     // fontWeight: FontWeight.bold,
// //           //     color: Colors.grey.shade600,
// //           //   ),
// //           //   onChanged: (value) => context.read<BillingProvider>()
// //           //     ..updateValidationMessage(
// //           //         validationTypes: ValidationTypes.paidAmount,
// //           //         validationMessage: ValidationHelperClass.validatePaidAmount(
// //           //                 value.trim(),
// //           //                 int.parse(
// //           //                     previewBillProvider.totalRateController.text)) ??
// //           //             '')
// //           //     ..updatePreviewBillingFormValidated(),
// //           // ),
// //           // if (context.read<BillingProvider>().paidAmountErrorMessage != null)
// //           //   ValidationWidget(
// //           //       validationMessage:
// //           //           context.read<BillingProvider>().paidAmountErrorMessage ??
// //           //               ''),
// //           // 10.verticalSpace,
// //           CustomDropDownSearch(
// //             labelText: previewBillProvider.paymentMode ?? "Select Payment Mode",
// //             maxHeight: 170.h,
// //             labelColor: Colors.black,
// //             onChanged: (value) => previewBillProvider
// //               ..updatePaymentMode(value)
// //               ..updatePaymentModeId()
// //               ..updateBillingFormState(),
// //             items: List.generate(
// //                 previewBillProvider.paymentModeDataList.length,
// //                 (index) =>
// //                     previewBillProvider.paymentModeDataList[index].name ?? ''),
// //           ),
// //           10.verticalSpace,
// //           previewBillProvider.paymentModeId == 6 ||
// //                   previewBillProvider.paymentMode == 'QR Code'
// //               ? PunnyamTextField(
// //                   hintText: "Transaction Id",
// //                   textEditingController: trans,
// //                   textInputAction: TextInputAction.done,
// //                   keyboardType: TextInputType.text,
// //                   isEnabled: true,
// //                   hintStyle: TextStyle(
// //                     fontSize: 14.sp,
// //                     // fontWeight: FontWeight.bold,
// //                     color: Colors.grey.shade600,
// //                   ),
// //                 )
// //               : const SizedBox(),
// //           ListView.builder(
// //             physics: const BouncingScrollPhysics(),
// //             padding: EdgeInsets.only(bottom: 150.h),
// //             itemCount: previewBillProvider.previewDetailsList.length,
// //             shrinkWrap: true,
// //             itemBuilder: (context, index) {
// //               PoojaDetails poojaDetails =
// //                   previewBillProvider.previewDetailsList[index];
// //               // String? name = previewBillProvider
// //               //     .getgothranameFromid(poojaDetails.gothra ?? 0);
// //               // String? rashiname = previewBillProvider
// //               //     .getrashianameFromid(poojaDetails.rashi ?? 0);
// //               // print(name);
// //               return Container(
// //                 height: 250.h,
// //                 width: double.maxFinite,
// //                 margin: EdgeInsets.symmetric(vertical: 10.h),
// //                 padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
// //                 decoration: BoxDecoration(
// //                     color: ColorPalette.orange,
// //                     borderRadius: BorderRadius.circular(20.r)),
// //                 child: Column(
// //                   children: [
// //                     _PreviewBillButton(onTap: () async {
// //                       previewBillProvider
// //                         ..removeFromPoojaList(index)
// //                         ..updateRate();
// //                       previewBillProvider.removeElementFromPoojaList(index,
// //                           onSuccess: () => Helpers.successToast(
// //                               'Item removed successfully...!'));
// //                     }),
// //                     PreviewBillRowWidget(
// //                       labelText: 'Category',
// //                       valueText: poojaDetails.diety ?? '',
// //                     ),
// //                     5.verticalSpace,
// //                     PreviewBillRowWidget(
// //                       labelText: 'Product',
// //                       valueText: poojaDetails.pooja ?? '',
// //                     ),
// //                     5.verticalSpace,
// //                     PreviewBillRowWidget(
// //                       labelText: 'Name',
// //                       valueText: poojaDetails.name ?? '',
// //                     ),
// //                     5.verticalSpace,
// //                     PreviewBillRowWidget(
// //                       labelText: 'Qty',
// //                       valueText: poojaDetails.qty.toString(),
// //                     ),
// //                     5.verticalSpace,
// //                     PreviewBillRowWidget(
// //                       labelText: 'Rate',
// //                       valueText: poojaDetails.rate.toString(),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //           30.verticalSpace
// //         ]),
// //       ),
// //     );
// //   }
// // }

// // class _PreviewBillButton extends StatefulWidget {
// //   const _PreviewBillButton({Key? key, required this.onTap}) : super(key: key);

// //   final Future<void> Function() onTap;
// //   @override
// //   _PreviewBillButtonState createState() => _PreviewBillButtonState();
// // }

// // class _PreviewBillButtonState extends State<_PreviewBillButton> {
// //   bool isLoading = false;
// //   @override
// //   Widget build(BuildContext context) {
// //     return Expanded(
// //         child: InkWell(
// //       onTap: onTap,
// //       child: Align(
// //           alignment: Alignment.topRight,
// //           child: Container(
// //             height: 50.h,
// //             width: 100.w,
// //             alignment: Alignment.center,
// //             decoration: BoxDecoration(
// //                 color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
// //             child: isLoading
// //                 ? Center(
// //                     child: SizedBox(
// //                       height: 17,
// //                       width: 17,
// //                       child: CircularProgressIndicator(
// //                         strokeWidth: 3.r,
// //                       ),
// //                     ),
// //                   )
// //                 : const Text('Remove'),
// //           )),
// //     ));
// //   }

// //   onTap() async {
// //     if (!isLoading) {
// //       setState(() {
// //         isLoading = true;
// //       });
// //       Future.delayed(
// //         const Duration(seconds: 1),
// //         () async => await widget.onTap().then((value) => isLoading = false),
// //       );
// //     }
// //   }
// // }





// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/billing_provider.dart';
// import 'package:stock_manager/screens/billing/widgets/preview_bill_row_widget.dart';
// import 'package:stock_manager/services/helpers.dart';
// import 'package:stock_manager/widgets/punnyam_textfiled.dart';
// import '../../../common/color_palette.dart';
// import '../../../common/custom_drop_down_search.dart';
// import '../../../models/save_bill_body.dart';

// class PreviewBillTile extends StatelessWidget {
//   const PreviewBillTile(
//       {Key? key, required this.previewBillProvider, required this.trans})
//       : super(key: key);
//   final BillingProvider previewBillProvider;
//   final TextEditingController trans;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           // ── Sub Total ──────────────────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Sub Total",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   isEnabled: false,
//                   textEditingController:
//                       context.read<BillingProvider>().subTotalController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,

//           // ── Discount ───────────────────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Discount",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   height: 45.h,
//                   textEditingController: previewBillProvider.discountController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintText: "Discount",
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                   onChanged: (value) {
//                     previewBillProvider.updatePreviewRate();
//                   },
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,

//           // ── GST ────────────────────────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "GST (%)",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: _GstDropdown(previewBillProvider: previewBillProvider),
//               ),
//             ],
//           ),
//           10.verticalSpace,

//           // ── GST Amount (read-only) ─────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "GST Amount",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   isEnabled: false,
//                   textEditingController:
//                       previewBillProvider.gstAmountController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,

//           // ── Grand Total ────────────────────────────────────────
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Grand Total",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   isEnabled: false,
//                   textEditingController:
//                       context.read<BillingProvider>().totalRateController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,

//           // ── Payment Mode ───────────────────────────────────────
//           CustomDropDownSearch(
//             labelText: previewBillProvider.paymentMode ?? "Select Payment Mode",
//             maxHeight: 170.h,
//             labelColor: Colors.black,
//             onChanged: (value) => previewBillProvider
//               ..updatePaymentMode(value)
//               ..updatePaymentModeId()
//               ..updateBillingFormState(),
//             items: List.generate(
//                 previewBillProvider.paymentModeDataList.length,
//                 (index) =>
//                     previewBillProvider.paymentModeDataList[index].name ?? ''),
//           ),
//           10.verticalSpace,

//           // ── Transaction ID (QR Code only) ─────────────────────
//           previewBillProvider.paymentModeId == 6 ||
//                   previewBillProvider.paymentMode == 'QR Code'
//               ? PunnyamTextField(
//                   hintText: "Transaction Id",
//                   textEditingController: trans,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: TextInputType.text,
//                   isEnabled: true,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 )
//               : const SizedBox(),

//           // ── Bill Item Cards ────────────────────────────────────
//           ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.only(bottom: 150.h),
//             itemCount: previewBillProvider.previewDetailsList.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               PoojaDetails poojaDetails =
//                   previewBillProvider.previewDetailsList[index];
//               return Container(
//                 height: 250.h,
//                 width: double.maxFinite,
//                 margin: EdgeInsets.symmetric(vertical: 10.h),
//                 padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//                 decoration: BoxDecoration(
//                     color: ColorPalette.orange,
//                     borderRadius: BorderRadius.circular(20.r)),
//                 child: Column(
//                   children: [
//                     _PreviewBillButton(onTap: () async {
//                       previewBillProvider
//                         ..removeFromPoojaList(index)
//                         ..updateRate();
//                       previewBillProvider.removeElementFromPoojaList(index,
//                           onSuccess: () => Helpers.successToast(
//                               'Item removed successfully...!'));
//                     }),
//                     PreviewBillRowWidget(
//                       labelText: 'Category',
//                       valueText: poojaDetails.diety ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Product',
//                       valueText: poojaDetails.pooja ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Name',
//                       valueText: poojaDetails.name ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Qty',
//                       valueText: poojaDetails.qty.toString(),
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Rate',
//                       valueText: poojaDetails.rate.toString(),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           30.verticalSpace
//         ]),
//       ),
//     );
//   }
// }

// // ── GST Dropdown Widget ──────────────────────────────────────────────────────

// class _GstDropdown extends StatelessWidget {
//   const _GstDropdown({Key? key, required this.previewBillProvider})
//       : super(key: key);

//   final BillingProvider previewBillProvider;

//   static const List<int> _gstOptions = [0, 5, 18, 40];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 45.h,
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8.r),
//         color: Colors.white,
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<int>(
//           value: previewBillProvider.gstPercent,
//           isExpanded: true,
//           icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
//           style: TextStyle(
//             fontSize: 14.sp,
//             color: Colors.black87,
//           ),
//           hint: Text(
//             "Select GST %",
//             style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
//           ),
//           items: _gstOptions
//               .map(
//                 (gst) => DropdownMenuItem<int>(
//                   value: gst,
//                   child: Text(
//                     "$gst%",
//                     style: TextStyle(fontSize: 14.sp),
//                   ),
//                 ),
//               )
//               .toList(),
//           onChanged: (value) {
//             if (value != null) {
//               previewBillProvider.updateGst(value);
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// // ── _PreviewBillButton (unchanged) ──────────────────────────────────────────

// class _PreviewBillButton extends StatefulWidget {
//   const _PreviewBillButton({Key? key, required this.onTap}) : super(key: key);

//   final Future<void> Function() onTap;
//   @override
//   _PreviewBillButtonState createState() => _PreviewBillButtonState();
// }

// class _PreviewBillButtonState extends State<_PreviewBillButton> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: InkWell(
//       onTap: _onTap,
//       child: Align(
//           alignment: Alignment.topRight,
//           child: Container(
//             height: 50.h,
//             width: 100.w,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
//             child: isLoading
//                 ? Center(
//                     child: SizedBox(
//                       height: 17,
//                       width: 17,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 3.r,
//                       ),
//                     ),
//                   )
//                 : const Text('Remove'),
//           )),
//     ));
//   }

//   _onTap() async {
//     if (!isLoading) {
//       setState(() {
//         isLoading = true;
//       });
//       Future.delayed(
//         const Duration(seconds: 1),
//         () async => await widget.onTap().then((value) => isLoading = false),
//       );
//     }
//   }
// }






// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/billing_provider.dart';
// import 'package:stock_manager/screens/billing/widgets/preview_bill_row_widget.dart';
// import 'package:stock_manager/screens/register/register_screen.dart';
// import 'package:stock_manager/services/helpers.dart';
// import 'package:stock_manager/widgets/punnyam_textfiled.dart';
// import '../../../common/color_palette.dart';
// import '../../../common/custom_drop_down_search.dart';
// import '../../../models/save_bill_body.dart';

// class PreviewBillTile extends StatelessWidget {
//   const PreviewBillTile(
//       {Key? key, required this.previewBillProvider, required this.trans})
//       : super(key: key);
//   final BillingProvider previewBillProvider;
//   final TextEditingController trans;

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Sub Total",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   isEnabled: false,
//                   textEditingController:
//                       context.read<BillingProvider>().subTotalController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Discount",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   height: 45.h,
//                   textEditingController: previewBillProvider.discountController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,

//                   ///  CHANGE THIS
//                   hintText: "Discount",

//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                   onChanged: (value) {
//                     previewBillProvider.updatePreviewRate();
//                   },
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,
//           Row(
//             children: [
//               Expanded(
//                 flex: 4,
//                 child: Text(
//                   "Grand Total",
//                   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               Expanded(
//                 flex: 6,
//                 child: PunnyamTextField(
//                   isEnabled: false,
//                   textEditingController:
//                       context.read<BillingProvider>().totalRateController,
//                   textInputAction: TextInputAction.next,
//                   keyboardType: TextInputType.number,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           10.verticalSpace,
//           // PunnyamTextField(
//           //   hintText: "paid Amount",
//           //   textInputAction: TextInputAction.done,
//           //   keyboardType: TextInputType.number,
//           //   textEditingController:
//           //       context.read<BillingProvider>().paidAmountController,
//           //   hintStyle: TextStyle(
//           //     fontSize: 14.sp,
//           //     // fontWeight: FontWeight.bold,
//           //     color: Colors.grey.shade600,
//           //   ),
//           //   onChanged: (value) => context.read<BillingProvider>()
//           //     ..updateValidationMessage(
//           //         validationTypes: ValidationTypes.paidAmount,
//           //         validationMessage: ValidationHelperClass.validatePaidAmount(
//           //                 value.trim(),
//           //                 int.parse(
//           //                     previewBillProvider.totalRateController.text)) ??
//           //             '')
//           //     ..updatePreviewBillingFormValidated(),
//           // ),
//           // if (context.read<BillingProvider>().paidAmountErrorMessage != null)
//           //   ValidationWidget(
//           //       validationMessage:
//           //           context.read<BillingProvider>().paidAmountErrorMessage ??
//           //               ''),
//           // 10.verticalSpace,
//           CustomDropDownSearch(
//             labelText: previewBillProvider.paymentMode ?? "Select Payment Mode",
//             maxHeight: 170.h,
//             labelColor: Colors.black,
//             onChanged: (value) => previewBillProvider
//               ..updatePaymentMode(value)
//               ..updatePaymentModeId()
//               ..updateBillingFormState(),
//             items: List.generate(
//                 previewBillProvider.paymentModeDataList.length,
//                 (index) =>
//                     previewBillProvider.paymentModeDataList[index].name ?? ''),
//           ),
//           10.verticalSpace,
//           previewBillProvider.paymentModeId == 6 ||
//                   previewBillProvider.paymentMode == 'QR Code'
//               ? PunnyamTextField(
//                   hintText: "Transaction Id",
//                   textEditingController: trans,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: TextInputType.text,
//                   isEnabled: true,
//                   hintStyle: TextStyle(
//                     fontSize: 14.sp,
//                     // fontWeight: FontWeight.bold,
//                     color: Colors.grey.shade600,
//                   ),
//                 )
//               : const SizedBox(),
//           ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: EdgeInsets.only(bottom: 150.h),
//             itemCount: previewBillProvider.previewDetailsList.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               PoojaDetails poojaDetails =
//                   previewBillProvider.previewDetailsList[index];
//               // String? name = previewBillProvider
//               //     .getgothranameFromid(poojaDetails.gothra ?? 0);
//               // String? rashiname = previewBillProvider
//               //     .getrashianameFromid(poojaDetails.rashi ?? 0);
//               // print(name);
//               return Container(
//                 height: 250.h,
//                 width: double.maxFinite,
//                 margin: EdgeInsets.symmetric(vertical: 10.h),
//                 padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
//                 decoration: BoxDecoration(
//                     color: ColorPalette.orange,
//                     borderRadius: BorderRadius.circular(20.r)),
//                 child: Column(
//                   children: [
//                     _PreviewBillButton(onTap: () async {
//                       previewBillProvider
//                         ..removeFromPoojaList(index)
//                         ..updateRate();
//                       previewBillProvider.removeElementFromPoojaList(index,
//                           onSuccess: () => Helpers.successToast(
//                               'Item removed successfully...!'));
//                     }),
//                     PreviewBillRowWidget(
//                       labelText: 'Category',
//                       valueText: poojaDetails.diety ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Product',
//                       valueText: poojaDetails.pooja ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Name',
//                       valueText: poojaDetails.name ?? '',
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Qty',
//                       valueText: poojaDetails.qty.toString(),
//                     ),
//                     5.verticalSpace,
//                     PreviewBillRowWidget(
//                       labelText: 'Rate',
//                       valueText: poojaDetails.rate.toString(),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           30.verticalSpace
//         ]),
//       ),
//     );
//   }
// }

// class _PreviewBillButton extends StatefulWidget {
//   const _PreviewBillButton({Key? key, required this.onTap}) : super(key: key);

//   final Future<void> Function() onTap;
//   @override
//   _PreviewBillButtonState createState() => _PreviewBillButtonState();
// }

// class _PreviewBillButtonState extends State<_PreviewBillButton> {
//   bool isLoading = false;
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: InkWell(
//       onTap: onTap,
//       child: Align(
//           alignment: Alignment.topRight,
//           child: Container(
//             height: 50.h,
//             width: 100.w,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
//             child: isLoading
//                 ? Center(
//                     child: SizedBox(
//                       height: 17,
//                       width: 17,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 3.r,
//                       ),
//                     ),
//                   )
//                 : const Text('Remove'),
//           )),
//     ));
//   }

//   onTap() async {
//     if (!isLoading) {
//       setState(() {
//         isLoading = true;
//       });
//       Future.delayed(
//         const Duration(seconds: 1),
//         () async => await widget.onTap().then((value) => isLoading = false),
//       );
//     }
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/screens/billing/widgets/preview_bill_row_widget.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/widgets/punnyam_textfiled.dart';
import '../../../common/color_palette.dart';
import '../../../common/custom_drop_down_search.dart';
import '../../../models/save_bill_body.dart';

class PreviewBillTile extends StatelessWidget {
  const PreviewBillTile(
      {Key? key, required this.previewBillProvider, required this.trans})
      : super(key: key);
  final BillingProvider previewBillProvider;
  final TextEditingController trans;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Sub Total ──────────────────────────────────────────
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Sub Total",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 6,
                child: PunnyamTextField(
                  isEnabled: false,
                  textEditingController:
                      context.read<BillingProvider>().subTotalController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,

          // ── Discount (% only) ──────────────────────────────────
          Consumer<BillingProvider>(
            builder: (context, bp, _) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          "Discount",
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            // ── Text field ────────────────────────────
                            Expanded(
                              child: PunnyamTextField(
                                height: 45.h,
                                textEditingController: bp.discountController,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                hintText: "Enter %",
                                hintStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                                onChanged: (value) {
                                  bp.updatePreviewRate();
                                },
                              ),
                            ),
                            SizedBox(width: 6.w),
                            // ── Static % label ────────────────────────
                            Container(
                              height: 45.h,
                              width: 46.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorPalette.orange,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: ColorPalette.orange),
                              ),
                              child: Text(
                                "%",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // ── Computed ₹ amount shown below the field ────────
                  if (bp.discountController.text.isNotEmpty &&
                      (double.tryParse(bp.discountController.text) ?? 0) > 0)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h, left: 4.w),
                      child: Builder(builder: (context) {
                        final double pct =
                            double.tryParse(bp.discountController.text) ?? 0;
                        final double discountAmt = bp.totalAmount * pct / 100;
                        return Text(
                          "= ₹ ${discountAmt.toStringAsFixed(2)} off",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }),
                    ),
                ],
              );
            },
          ),
          10.verticalSpace,

          // ── GST ────────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "GST (%)",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 6,
                child: _GstDropdown(previewBillProvider: previewBillProvider),
              ),
            ],
            
          ),
          if (previewBillProvider.gstPercent == null)
      Padding(
        padding: EdgeInsets.only(top: 4.h, left: 8.w),
        child: Text(
          'Please select GST percentage',
          style: TextStyle(
            color: Colors.red,
            fontSize: 12.sp,
          ),
        ),
      ),
          10.verticalSpace,

          // ── GST Amount (read-only) ─────────────────────────────
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "GST Amount",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 6,
                child: PunnyamTextField(
                  isEnabled: false,
                  textEditingController:
                      previewBillProvider.gstAmountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,

          // ── Grand Total ────────────────────────────────────────
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Grand Total",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 6,
                child: PunnyamTextField(
                  isEnabled: false,
                  textEditingController:
                      context.read<BillingProvider>().totalRateController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          10.verticalSpace,

          // ── Payment Mode ───────────────────────────────────────
          CustomDropDownSearch(
            labelText: previewBillProvider.paymentMode ?? "Select Payment Mode",
            maxHeight: 170.h,
            labelColor: Colors.black,
            onChanged: (value) => previewBillProvider
              ..updatePaymentMode(value)
              ..updatePaymentModeId()
              ..updateBillingFormState(),
            items: List.generate(
                previewBillProvider.paymentModeDataList.length,
                (index) =>
                    previewBillProvider.paymentModeDataList[index].name ?? ''),
          ),
          10.verticalSpace,

          // ── Transaction ID (QR Code only) ─────────────────────
          previewBillProvider.paymentModeId == 6 ||
                  previewBillProvider.paymentMode == 'QR Code'
              ? PunnyamTextField(
                  hintText: "Transaction Id",
                  textEditingController: trans,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  isEnabled: true,
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                )
              : const SizedBox(),

          // ── Bill Item Cards ────────────────────────────────────
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 150.h),
            itemCount: previewBillProvider.previewDetailsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              PoojaDetails poojaDetails =
                  previewBillProvider.previewDetailsList[index];
              return Container(
                height: 250.h,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                decoration: BoxDecoration(
                    color: ColorPalette.orange,
                    borderRadius: BorderRadius.circular(20.r)),
                child: Column(
                  children: [
                    _PreviewBillButton(onTap: () async {
                      previewBillProvider
                        ..removeFromPoojaList(index)
                        ..updateRate();
                      previewBillProvider.removeElementFromPoojaList(index,
                          onSuccess: () => Helpers.successToast(
                              'Item removed successfully...!'));
                    }),
                    PreviewBillRowWidget(
                      labelText: 'Category',
                      valueText: poojaDetails.diety ?? '',
                    ),
                    5.verticalSpace,
                    PreviewBillRowWidget(
                      labelText: 'Product',
                      valueText: poojaDetails.pooja ?? '',
                    ),
                    5.verticalSpace,
                    PreviewBillRowWidget(
                      labelText: 'Name',
                      valueText: poojaDetails.name ?? '',
                    ),
                    5.verticalSpace,
                    PreviewBillRowWidget(
                      labelText: 'Qty',
                      valueText: poojaDetails.qty.toString(),
                    ),
                    5.verticalSpace,
                    PreviewBillRowWidget(
                      labelText: 'Rate',
                      valueText: poojaDetails.rate.toString(),
                    ),
                  ],
                ),
              );
            },
          ),
          30.verticalSpace
        ]),
      ),
    );
  }
}

// ── GST Dropdown Widget ──────────────────────────────────────────────────────

class _GstDropdown extends StatelessWidget {
  const _GstDropdown({Key? key, required this.previewBillProvider})
      : super(key: key);

  final BillingProvider previewBillProvider;

  static const List<int> _gstOptions = [0, 5, 18, 40];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8.r),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: previewBillProvider.gstPercent,
          isExpanded: true,
          icon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.sp),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black87,
          ),
          hint: Text(
            "Select GST %",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
          items: _gstOptions
              .map(
                (gst) => DropdownMenuItem<int>(
                  value: gst,
                  child: Text(
                    "$gst%",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) {
              previewBillProvider.updateGst(value);
            }
          },
        ),
      ),
    );
  }
}

// ── _PreviewBillButton (unchanged) ──────────────────────────────────────────

class _PreviewBillButton extends StatefulWidget {
  const _PreviewBillButton({Key? key, required this.onTap}) : super(key: key);

  final Future<void> Function() onTap;
  @override
  _PreviewBillButtonState createState() => _PreviewBillButtonState();
}

class _PreviewBillButtonState extends State<_PreviewBillButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: _onTap,
      child: Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 50.h,
            width: 100.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: 17,
                      width: 17,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.r,
                      ),
                    ),
                  )
                : const Text('Remove'),
          )),
    ));
  }

  _onTap() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(
        const Duration(seconds: 1),
        () async => await widget.onTap().then((value) => isLoading = false),
      );
    }
  }
}