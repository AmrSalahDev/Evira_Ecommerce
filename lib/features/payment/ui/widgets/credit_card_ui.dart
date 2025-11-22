import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class CreditCardUI extends StatelessWidget {
  final bool isFrontSide;
  final TextEditingController? cardNumberController;
  final TextEditingController? cardHolderNameController;
  final TextEditingController? expiryDateController;
  final TextEditingController? cvvController;

  const CreditCardUI({
    super.key,
    required this.isFrontSide,
    this.cardNumberController,
    this.cardHolderNameController,
    this.expiryDateController,
    this.cvvController,
  });

  @override
  Widget build(BuildContext context) {
    return isFrontSide
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
            height: context.screenHeight * 0.3,
            width: context.screenWidth * 0.90,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Mocard",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: context.textColor,
                      ),
                    ),
                    Spacer(),
                    Assets.icons.amazonLogo.svg(
                      height: 45.h,
                      width: 45.h,
                      colorFilter: ColorFilter.mode(
                        context.iconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
                TextField(
                  readOnly: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                    CreditCardNumberInputFormatter(),
                  ],
                  controller: cardNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                    hintText: "0000 0000 0000 0000",
                    hintStyle: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: context.textColor,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            EviraLang.of(context).cardHolderName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.textColor,
                            ),
                          ),
                          TextField(
                            controller: cardHolderNameController,
                            readOnly: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: EviraLang.of(context).blackcode,
                              hintStyle: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: context.textColor,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: context.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            EviraLang.of(context).expiryDate,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: context.textColor,
                            ),
                          ),
                          TextField(
                            controller: expiryDateController,
                            readOnly: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                              CreditCardExpirationDateFormatter(),
                            ],
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              hintText: "00/00",
                              hintStyle: TextStyle(
                                color: context.textColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                              color: context.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: context.iconColor.withValues(alpha: 0.4),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            bottom: 0,
                            left: -40,
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.iconColor.withValues(alpha: 0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        : Container(
            height: context.screenHeight * 0.3,
            width: context.screenWidth * 0.90,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 70.h),
                Container(
                  width: context.screenWidth,
                  height: 50.h,
                  decoration: BoxDecoration(color: Colors.black),
                ),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.only(right: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        EviraLang.of(context).cvv,
                        style: TextStyle(
                          color: context.textSmallGrayColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,

                        margin: EdgeInsets.only(top: 5.h),
                        width: context.screenWidth / 2,
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: context.iconColor,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: TextField(
                          controller: cvvController,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            contentPadding: EdgeInsets.only(bottom: 10.h),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(
                            color: context.buttonTextColor,
                            fontSize: 20.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
