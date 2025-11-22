import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_cvc_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditCardForms extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderNameController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final FlipCardController flipCardController;
  const CreditCardForms({
    super.key,
    required this.formKey,
    required this.cardNumberController,
    required this.cardHolderNameController,
    required this.expiryDateController,
    required this.cvvController,
    required this.flipCardController,
  });

  @override
  Widget build(BuildContext context) {
    final isFront = flipCardController.state!.isFront;
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(
            onTap: () => !isFront ? flipCardController.flipcard() : null,
            label: EviraLang.of(context).cardName,
            controller: cardHolderNameController,
            hintText: EviraLang.of(context).blackcode,
          ),
          SizedBox(height: 30.h),
          CustomTextField(
            onTap: () => !isFront ? flipCardController.flipcard() : null,
            label: EviraLang.of(context).cardNumber,
            keyboardType: TextInputType.number,
            hintText: "0000 0000 0000 0000",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
              CreditCardNumberInputFormatter(),
            ],
            controller: cardNumberController,
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  onTap: () => !isFront ? flipCardController.flipcard() : null,
                  label: EviraLang.of(context).expiryDate,
                  controller: expiryDateController,
                  suffix: IconButton(
                    iconSize: 27.sp,
                    onPressed: () {},
                    icon: Icon(
                      Icons.date_range_outlined,
                      color: context.iconColor,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                    CreditCardExpirationDateFormatter(),
                  ],
                  hintText: "00/00",
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: CustomTextField(
                  onTap: () => isFront ? flipCardController.flipcard() : null,
                  label: EviraLang.of(context).cvv,
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  hintText: "000",
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                    CreditCardCvcInputFormatter(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
