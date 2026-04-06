import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/screens/billing/widgets/preview_bill_row_widget.dart';
import 'package:stock_manager/screens/register/register_screen.dart';
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
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Text(
                  "Discount",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 6,
                child: PunnyamTextField(
                  height: 45.h,
                  textEditingController: previewBillProvider.discountController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,

                  ///  CHANGE THIS
                  hintText: "Discount",

                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade600,
                  ),
                  onChanged: (value) {
                    previewBillProvider.updatePreviewRate();
                  },
                ),
              ),
            ],
          ),
          10.verticalSpace,
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
          // PunnyamTextField(
          //   hintText: "paid Amount",
          //   textInputAction: TextInputAction.done,
          //   keyboardType: TextInputType.number,
          //   textEditingController:
          //       context.read<BillingProvider>().paidAmountController,
          //   hintStyle: TextStyle(
          //     fontSize: 14.sp,
          //     // fontWeight: FontWeight.bold,
          //     color: Colors.grey.shade600,
          //   ),
          //   onChanged: (value) => context.read<BillingProvider>()
          //     ..updateValidationMessage(
          //         validationTypes: ValidationTypes.paidAmount,
          //         validationMessage: ValidationHelperClass.validatePaidAmount(
          //                 value.trim(),
          //                 int.parse(
          //                     previewBillProvider.totalRateController.text)) ??
          //             '')
          //     ..updatePreviewBillingFormValidated(),
          // ),
          // if (context.read<BillingProvider>().paidAmountErrorMessage != null)
          //   ValidationWidget(
          //       validationMessage:
          //           context.read<BillingProvider>().paidAmountErrorMessage ??
          //               ''),
          // 10.verticalSpace,
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
                    // fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                )
              : const SizedBox(),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(bottom: 150.h),
            itemCount: previewBillProvider.previewDetailsList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              PoojaDetails poojaDetails =
                  previewBillProvider.previewDetailsList[index];
              // String? name = previewBillProvider
              //     .getgothranameFromid(poojaDetails.gothra ?? 0);
              // String? rashiname = previewBillProvider
              //     .getrashianameFromid(poojaDetails.rashi ?? 0);
              // print(name);
              return Container(
                height: 170.h,
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
      onTap: onTap,
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

  onTap() async {
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
