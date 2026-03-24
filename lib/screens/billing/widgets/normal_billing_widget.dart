// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:provider/provider.dart';
// // // import 'package:stock_manager/common/custom_drop_down_search.dart';
// // // import 'package:stock_manager/common/date_picker.dart';
// // // import 'package:stock_manager/providers/billing_provider.dart';
// // // import 'package:stock_manager/screens/billing/widgets/loading_dropdown.dart';
// // // import 'package:stock_manager/services/provider_helper_class.dart';
// // // import 'package:stock_manager/services/validation_helper.dart';
// // // import 'package:stock_manager/models/category_model.dart';
// // // import '../../../widgets/punnyam_textfiled.dart';
// // // import '../../register/register_screen.dart';

// // // class NormalBillingWidget extends StatefulWidget {
// // //   const NormalBillingWidget({Key? key, required this.billingProvider})
// // //       : super(key: key);
// // //   final BillingProvider billingProvider;
// // //   @override
// // //   State<NormalBillingWidget> createState() => _NormalBillingWidgetState();
// // // }

// // // class _NormalBillingWidgetState extends State<NormalBillingWidget> {


// // //   @override
// // // void initState() {
// // //   super.initState();

// // //   WidgetsBinding.instance.addPostFrameCallback((_) {
// // //     final provider = context.read<BillingProvider>();

// // //     provider.getCategories();
// // //     provider.getProducts();
// // //   });
// // // }
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
// // //       SizedBox(
// // //         height: 20.h,
// // //       ),
// // //       widget.billingProvider.loaderState == LoaderState.loading
// // //           ? const LoadingDropDown(
// // //               title: 'Select Category',
// // //             )
// // //           : Selector<BillingProvider, List<Cat>>(
// // //               selector: (context, billingProvider) =>
// // //                   billingProvider.categoryList,
// // //               builder: (context, value, child) {
// // //                 debugPrint('value ${value.length}');
// // //                 return CustomDropDownSearch(
// // //                   labelText: 'Select Category',
// // //                   selected: widget.billingProvider.selectedCategoryName,
// // //                   isShowSearch: true,
// // //                   onChanged: (value) => widget.billingProvider
// // //                     ..selectedProductName = null
// // //                     ..selectedProductId = ''
// // //                     ..getCategoryIdFromName(value)
// // //                     // ..getPoojas(isEnableBtnLoader: true)
// // //                     // ..ayyapanpooja(value)
// // //                     ..updateBillingFormState(),
// // //                   items: List.generate(value.length, (index) {
// // //                     return value[index].name ?? '';
// // //                   }),
// // //                 );
// // //               }),
// // //       10.verticalSpace,
// // //       widget.billingProvider.loaderState == LoaderState.loading
// // //           ? const LoadingDropDown(
// // //               title: 'Select Product',
// // //             )
// // //           : CustomDropDownSearch(
// // //               labelText: 'Select Product',
// // //               selected: widget.billingProvider.selectedProductName,
// // //               isShowSearch: true,
// // //               onChanged: (value) => widget.billingProvider
// // //                 ..getProductIdFromName(value)
// // //                 ..updateBillingFormState(),
// // //               items: List.generate(
// // //                   widget.billingProvider.productList.length,
// // //                   (index) => widget.billingProvider.productList[index].name),
// // //             ),
// // //       10.verticalSpace,
// // //       !widget.billingProvider.isScheduled
// // //           ? PunnyamDatePicker(
// // //               title: widget.billingProvider.fromDate
// // //                   ?.split('-')
// // //                   .reversed
// // //                   .join('-'),
// // //               isFromDate: false,
// // //               onChanged: (date) {
// // //                 debugPrint('date $date');
// // //                 widget.billingProvider
// // //                   ..updateFromDate(date)
// // //                   ..updateBillingFormState();
// // //                 // debugPrint(DateFormat.yMMMMd().format(DateTime.now()));
// // //               },
// // //             )
// // //           : const SizedBox.shrink(),
// // //       !widget.billingProvider.isScheduled ? 10.verticalSpace : 0.verticalSpace,
// // //       Row(
// // //         children: [
// // //           Flexible(
// // //               child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               PunnyamTextField(
// // //                 hintText: "Qty",
// // //                 height: 45.h,
// // //                 inputFormatter: [FilteringTextInputFormatter.digitsOnly],
// // //                 textInputAction: TextInputAction.next,
// // //                 keyboardType: TextInputType.number,
// // //                 isEnabled: BillingProvider.ratefield == true ? false : true,
// // //                 textEditingController: widget.billingProvider.qtyController,
// // //                 hintStyle: TextStyle(
// // //                   fontSize: 14.sp,
// // //                   color: Colors.grey.shade600,
// // //                 ),
// // //                 onChanged: (value) {
// // //                   widget.billingProvider.updateValidationMessage(
// // //                       validationTypes: ValidationTypes.qty,
// // //                       validationMessage:
// // //                           ValidationHelperClass.validateQty(value.trim()) ??
// // //                               '');
// // //                   widget.billingProvider
// // //                     ..updateRateWithProduct()
// // //                     ..updateBillingFormState();
// // //                 },
// // //               ),
// // //             ],
// // //           )),
// // //           10.horizontalSpace,
// // //           Flexible(
// // //               child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               PunnyamTextField(
// // //                 hintText: "Rate/Amount",
// // //                 height: 45.h,
// // //                 textEditingController: widget.billingProvider.rateController,
// // //                 textInputAction: TextInputAction.done,
// // //                 keyboardType: TextInputType.number,
// // //                 isEnabled: BillingProvider.ratefield == true ? true : false,
// // //                 hintStyle: TextStyle(
// // //                   fontSize: 14.sp,
// // //                   color: Colors.grey.shade600,
// // //                 ),
// // //                 onChanged: (value) => widget.billingProvider
// // //                     .updateValidationMessage(
// // //                         validationTypes: ValidationTypes.rate,
// // //                         validationMessage:
// // //                             ValidationHelperClass.validateRate(value.trim()) ??
// // //                                 ''),
// // //               ),
// // //             ],
// // //           )),
// // //         ],
// // //       ),
// // //       10.verticalSpace,
// // //     ]);
// // //   }
// // // }





// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:provider/provider.dart';
// // import 'package:stock_manager/common/custom_drop_down_search.dart';
// // import 'package:stock_manager/common/date_picker.dart';
// // import 'package:stock_manager/providers/billing_provider.dart';
// // import 'package:stock_manager/screens/billing/widgets/loading_dropdown.dart';
// // import 'package:stock_manager/services/provider_helper_class.dart';
// // import 'package:stock_manager/services/validation_helper.dart';
// // import 'package:stock_manager/models/category_model.dart';
// // import '../../../widgets/punnyam_textfiled.dart';

// // class NormalBillingWidget extends StatefulWidget {
// //   const NormalBillingWidget({Key? key, required this.billingProvider})
// //       : super(key: key);

// //   final BillingProvider billingProvider;

// //   @override
// //   State<NormalBillingWidget> createState() => _NormalBillingWidgetState();
// // }

// // class _NormalBillingWidgetState extends State<NormalBillingWidget> {

// //   @override
// //   void initState() {
// //     super.initState();

// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       final provider = context.read<BillingProvider>();

// //       provider.getCategories();
// //       provider.getProducts();
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final provider = widget.billingProvider;

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [

// //         SizedBox(height: 20.h),

// //         /// ---------------- CATEGORY ----------------
// //         provider.loaderState == LoaderState.loading
// //             ? const LoadingDropDown(title: 'Select Category')
// //             : Selector<BillingProvider, List<Cat>>(
// //                 selector: (_, p) => p.categoryList,
// //                 builder: (_, value, __) {
// //                   return CustomDropDownSearch(
// //                     labelText: 'Select Category',
// //                     selected: provider.selectedCategoryName,
// //                     isShowSearch: true,
// //                     onChanged: (value) => provider
// //                       ..selectedProductName = null
// //                       ..selectedProductId = ''
// //                       ..getCategoryIdFromName(value)
// //                       ..updateBillingFormState(),
// //                     items: value.map((e) => e.name ?? '').toList(),
// //                   );
// //                 },
// //               ),

// //         10.verticalSpace,

// //         /// ---------------- PRODUCT ----------------
// //         provider.loaderState == LoaderState.loading
// //             ? const LoadingDropDown(title: 'Select Product')
// //             : CustomDropDownSearch(
// //                 labelText: 'Select Product',
// //                 selected: provider.selectedProductName,
// //                 isShowSearch: true,
// //                 onChanged: (value) => provider
// //                   ..getProductIdFromName(value)
// //                   ..fetchProductStock()   //  API CALL HERE
// //                   ..updateBillingFormState(),
// //                 items: provider.productList
// //                     .map((e) => e.name)
// //                     .toList(),
// //               ),

// //         10.verticalSpace,

// //         /// ---------------- STOCK DISPLAY ----------------
// //         Selector<BillingProvider, double>(
// //           selector: (_, p) => p.availableStock,
// //           builder: (_, stock, __) {
// //             return Text(
// //               stock > 0
// //                   ? "Available Stock: $stock"
// //                   : "Out of Stock",
// //               style: TextStyle(
// //                 fontSize: 14.sp,
// //                 fontWeight: FontWeight.w600,
// //                 color: stock > 0 ? Colors.green : Colors.red,
// //               ),
// //             );
// //           },
// //         ),

// //         10.verticalSpace,

// //         /// ---------------- DATE ----------------
// //         !provider.isScheduled
// //             ? PunnyamDatePicker(
// //                 title: provider.fromDate
// //                     ?.split('-')
// //                     .reversed
// //                     .join('-'),
// //                 isFromDate: false,
// //                 onChanged: (date) {
// //                   provider
// //                     ..updateFromDate(date)
// //                     ..updateBillingFormState();
// //                 },
// //               )
// //             : const SizedBox.shrink(),

// //         !provider.isScheduled
// //             ? 10.verticalSpace
// //             : 0.verticalSpace,

// //         /// ---------------- QTY & RATE ----------------
// //         Row(
// //           children: [

// //             /// QTY FIELD
// //             Flexible(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   PunnyamTextField(
// //                     hintText: "Qty",
// //                     height: 45.h,
// //                     inputFormatter: [FilteringTextInputFormatter.digitsOnly],
// //                     textInputAction: TextInputAction.next,
// //                     keyboardType: TextInputType.number,
// //                     isEnabled: BillingProvider.ratefield ? false : true,
// //                     textEditingController: provider.qtyController,
// //                     hintStyle: TextStyle(
// //                       fontSize: 14.sp,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                     onChanged: (value) {

// //                       ///  OPTIONAL: STOCK VALIDATION
// //                       if (value.isNotEmpty &&
// //                           int.tryParse(value)! > provider.availableStock) {
// //                         ScaffoldMessenger.of(context).showSnackBar(
// //                           const SnackBar(
// //                             content: Text("Quantity exceeds available stock"),
// //                           ),
// //                         );
// //                       }

// //                       provider.updateValidationMessage(
// //                         validationTypes: ValidationTypes.qty,
// //                         validationMessage:
// //                             ValidationHelperClass.validateQty(value.trim()) ?? '',
// //                       );

// //                       provider
// //                         ..updateRateWithProduct()
// //                         ..updateBillingFormState();
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),

// //             10.horizontalSpace,

// //             /// RATE FIELD
// //             Flexible(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   PunnyamTextField(
// //                     hintText: "Rate/Amount",
// //                     height: 45.h,
// //                     textEditingController: provider.rateController,
// //                     textInputAction: TextInputAction.done,
// //                     keyboardType: TextInputType.number,
// //                     isEnabled: BillingProvider.ratefield,
// //                     hintStyle: TextStyle(
// //                       fontSize: 14.sp,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                     onChanged: (value) {
// //                       provider.updateValidationMessage(
// //                         validationTypes: ValidationTypes.rate,
// //                         validationMessage:
// //                             ValidationHelperClass.validateRate(value.trim()) ?? '',
// //                       );
// //                     },
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),

// //         10.verticalSpace,
// //       ],
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/common/custom_drop_down_search.dart';
// import 'package:stock_manager/models/category_model.dart';
// import 'package:stock_manager/providers/billing_provider.dart';
// import 'package:stock_manager/screens/billing/widgets/loading_dropdown.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';
// import '../../../widgets/punnyam_textfiled.dart';

// class NormalBillingWidget extends StatefulWidget {
//   const NormalBillingWidget({Key? key, required this.billingProvider})
//       : super(key: key);

//   final BillingProvider billingProvider;

//   @override
//   State<NormalBillingWidget> createState() => _NormalBillingWidgetState();
// }

// class _NormalBillingWidgetState extends State<NormalBillingWidget> {

//   @override
//   Widget build(BuildContext context) {
//     final provider = widget.billingProvider;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         provider.loaderState == LoaderState.loading
//             ? const LoadingDropDown(title: 'Select Category')
//             : Selector<BillingProvider, List<Cat>>(
//                 selector: (_, p) => p.categoryList,
//                 builder: (_, value, __) {
//                   return CustomDropDownSearch(
//                     labelText: 'Select Category',
//                     selected: provider.selectedCategoryName,
//                     isShowSearch: true,
//                     onChanged: (value) => provider
//                       ..getCategoryIdFromName(value)
//                       ..updateBillingFormState(),
//                     items: value.map((e) => e.name ?? '').toList(),
//                   );
//                 },
//               ),
//         SizedBox(height: 20.h),

//         /// ---------------- PRODUCT ----------------
//         CustomDropDownSearch(
//           labelText: 'Select Product',
//           selected: provider.selectedProductName,
//           isShowSearch: true,
//           onChanged: (value) => provider
//             ..getProductIdFromName(value)   //  SET PRICE
//             ..fetchProductStock()           //  GET STOCK
//             ..updateBillingFormState(),
//           items: provider.productList
//               .map((e) => e.name)
//               .toList(),
//         ),

//         10.verticalSpace,

//         /// ---------------- STOCK ----------------
//         Selector<BillingProvider, double>(
//           selector: (_, p) => p.availableStock,
//           builder: (_, stock, __) {
//             return Text(
//               stock > 0
//                   ? "Available Stock: $stock"
//                   : "Out of Stock",
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w600,
//                 color: stock > 0 ? Colors.green : Colors.red,
//               ),
//             );
//           },
//         ),

//         10.verticalSpace,

//         /// ---------------- QTY ----------------
//         PunnyamTextField(
//           hintText: "Qty",
//           height: 45.h,
//           inputFormatter: [FilteringTextInputFormatter.digitsOnly],
//           keyboardType: TextInputType.number,
//           textEditingController: provider.qtyController,
//           onChanged: (value) {
//             ///  STOCK VALIDATION
//             if (value.isNotEmpty &&
//                 int.tryParse(value)! > provider.availableStock) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                   content: Text("Quantity exceeds available stock"),
//                 ),
//               );
//             }
//             provider
//               ..updateRateWithProduct()
//               ..updateBillingFormState();
//           },
//         ),

//         10.verticalSpace,

//         /// ---------------- RATE (AUTO FILLED) ----------------
//         PunnyamTextField(
//           hintText: "Rate",
//           height: 45.h,
//           textEditingController: provider.rateController,
//           keyboardType: TextInputType.number,

//           ///  MAKE READ ONLY (optional)
//           isEnabled: false,
//         ),

//         10.verticalSpace,
//       ],
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/custom_drop_down_search.dart';
import 'package:stock_manager/common/date_picker.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/screens/billing/widgets/loading_dropdown.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:stock_manager/services/validation_helper.dart';
import '../../../models/dieties_response_model.dart';
import '../../../widgets/punnyam_textfiled.dart';
import '../../register/register_screen.dart';

class NormalBillingWidget extends StatefulWidget {
  const NormalBillingWidget({Key? key, required this.billingProvider})
      : super(key: key);
  final BillingProvider billingProvider;
  @override
  State<NormalBillingWidget> createState() => _NormalBillingWidgetState();
}

class _NormalBillingWidgetState extends State<NormalBillingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 20.h,
      ),
      widget.billingProvider.loaderState == LoaderState.loading
          ? const LoadingDropDown(
              title: 'Select Category',
            )
          : Selector<BillingProvider, List<DeitiesData>>(
              selector: (context, billingProvider) =>
                  billingProvider.deitiesList,
              builder: (context, value, child) {
                debugPrint('value ${value.length}');
                return CustomDropDownSearch(
                  labelText: 'Select Category',
                  selected: widget.billingProvider.deityname,
                  isShowSearch: true,
                  onChanged: (value) => widget.billingProvider
                    ..poojaName = null
                    ..poojaId = ''
                    ..getDeityIdFromName(value)
                    ..getPoojas(isEnableBtnLoader: true)
                    // ..ayyapanpooja(value)
                    ..updateBillingFormState(),
                  items: List.generate(value.length, (index) {
                    return value[index].name ?? '';
                  }),
                );
              }),
      10.verticalSpace,
      widget.billingProvider.btnLoader
          ? Container(
              height: 45.h,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40.r),
                color: Colors.grey.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Product',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                    width: 15.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.r,
                    ),
                  ),
                ],
              ),
            )
          : CustomDropDownSearch(
              labelText: 'Select Product',
              selected: widget.billingProvider.poojaName,
              isShowSearch: true,
              onChanged: (value) => widget.billingProvider
                ..getPoojaIdFromName(value)
                ..fetchProductStock()
                ..updateBillingFormState(),
              items: List.generate(
                  widget.billingProvider.poojaDataList.length,
                  (index) =>
                      widget.billingProvider.poojaDataList[index].name ?? ''),
            ),
       10.verticalSpace,

        //         Selector<BillingProvider, double>(
        //   selector: (_, p) => p.availableStock,
        //   builder: (_, stock, __) {
        //     return Text(
        //       stock > 0
        //           ? "Available Stock: $stock"
        //           : "Out of Stock",
        //       style: TextStyle(
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w600,
        //         color: stock > 0 ? Colors.green : Colors.red,
        //       ),
        //     );
        //   },
        //  ),

        Selector<BillingProvider, BillingProvider>(
          selector: (_, p) => p,
          builder: (_, provider, __) {
            // if (provider.isStockLoading) {
            //   return Text("Checking stock...");
            // }
            if (!provider.hasFetchedStock) {
              return SizedBox.shrink();
            }
            return Text(
              provider.availableStock > 0
                  ? "Available Stock: ${provider.availableStock}"
                  : "Out of Stock",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: provider.availableStock > 0 ? Colors.green : Colors.red,
              ),
            );
          },
        ),

      !widget.billingProvider.isScheduled
          ? PunnyamDatePicker(
              title: widget.billingProvider.fromDate
                  ?.split('-')
                  .reversed
                  .join('-'),
              isFromDate: false,
              onChanged: (date) {
                debugPrint('date $date');
                widget.billingProvider
                  ..updateFromDate(date)
                  ..updateBillingFormState();
                // debugPrint(DateFormat.yMMMMd().format(DateTime.now()));
              },
            )
          : const SizedBox.shrink(),
      !widget.billingProvider.isScheduled ? 10.verticalSpace : 0.verticalSpace,
      Row(
        children: [
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PunnyamTextField(
                hintText: "Qty",
                height: 45.h,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                isEnabled: BillingProvider.ratefield == true ? false : true,
                textEditingController: widget.billingProvider.qtyController,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
                onChanged: (value) {
                  widget.billingProvider.updateValidationMessage(
                      validationTypes: ValidationTypes.qty,
                      validationMessage:
                          ValidationHelperClass.validateQty(value.trim()) ??
                              '');
                  widget.billingProvider
                    ..updateRate()
                    ..updateBillingFormState();
                },
              ),
            ],
          )),
          10.horizontalSpace,
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PunnyamTextField(
                hintText: "Rate/Amount",
                height: 45.h,
                textEditingController: widget.billingProvider.rateController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                isEnabled: BillingProvider.ratefield == true ? true : false,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
                onChanged: (value) => widget.billingProvider
                    .updateValidationMessage(
                        validationTypes: ValidationTypes.rate,
                        validationMessage:
                            ValidationHelperClass.validateRate(value.trim()) ??
                                ''),
              ),
            ],
          )),
        ],
      ),
      10.verticalSpace,
      // BillingProvider.address
      //     ? const SizedBox()
      //     : Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           InkWell(
      //             onTap: () {
      //               setState(() {
      //                 BillingProvider.address = true;
      //               });
      //             },
      //             child: Container(
      //               height: 40.h,
      //               width: 100.w,
      //               decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: Colors.grey),
      //               child: const Center(child: Text("Add address")),
      //             ),
      //           ),
      //         ],
      //       ),
      // BillingProvider.address
      //     ? PunnyamTextField(
      //         hintText: "Address",
      //         height: 45.h,
      //         textEditingController: widget.billingProvider.addressController,
      //         keyboardType: TextInputType.text,
      //         hintStyle: TextStyle(
      //           fontSize: 14.sp,
      //           color: Colors.grey.shade600,
      //         ),
      //         // onChanged: (value) => widget.billingProvider
      //         //     .updateValidationMessage(
      //         //         validationTypes: ValidationTypes.name,
      //         //         validationMessage:
      //         //             ValidationHelperClass.validateName(value.trim()) ??
      //         //                 ''),
      //       )
         // : const SizedBox(),
    ]);
  }
}
