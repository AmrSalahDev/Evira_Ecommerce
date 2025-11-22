import 'package:bounce/bounce.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/payment/ui/widgets/credit_card_forms.dart';
import 'package:evira_e_commerce/features/payment/ui/widgets/credit_card_ui.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:flutter_flip_card/flipcard/flip_card.dart';
import 'package:flutter_flip_card/modal/flip_side.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({super.key});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen>
    with StatefulScreenMixin {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController cardNumberController;
  late final TextEditingController cardHolderNameController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cvvController;
  late final FlipCardController flipCardController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    cardNumberController = TextEditingController();
    cardHolderNameController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();
    flipCardController = FlipCardController();
  }

  @override
  String get title => EviraLang.of(context).addNewCard;

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
        icon: Assets.icons.roundMenu.svg(
          height: 30.h,
          width: 30.h,
          colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
        ),
        onPressed: () {},
      ),
      SizedBox(width: 10.w),
    ];
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Bounce(
            child: FlipCard(
              rotateSide: RotateSide.bottom,
              onTapFlipping: true,
              axis: FlipAxis.vertical,
              controller: flipCardController,
              frontWidget: CreditCardUI(
                isFrontSide: true,
                cardHolderNameController: cardHolderNameController,
                cardNumberController: cardNumberController,
                expiryDateController: expiryDateController,
              ),
              backWidget: CreditCardUI(
                isFrontSide: false,
                cvvController: cvvController,
              ),
            ),
          ),
          SizedBox(height: 30.h),
          CreditCardForms(
            formKey: formKey,
            cardNumberController: cardNumberController,
            cardHolderNameController: cardHolderNameController,
            expiryDateController: expiryDateController,
            cvvController: cvvController,
            flipCardController: flipCardController,
          ),
          SizedBox(height: 50.h),
          CustomButton(
            handleNoInternet: true,
            title: EviraLang.of(context).add,
            onPressed: () {},
            backgroundColor: context.buttonColor,
            textColor: context.buttonTextColor,
          ),
          SizedBox(height: 50.h),
        ],
      ),
    );
  }
}
