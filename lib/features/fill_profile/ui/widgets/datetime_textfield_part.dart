import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DateTimeTextFieldPart extends StatelessWidget {
  const DateTimeTextFieldPart({super.key, required this.dateController});

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: dateController,
      readOnly: true,
      keyboardType: TextInputType.number,
      hintText: EviraLang.of(context).dateOfBirth,
      suffixIcon: FontAwesomeIcons.calendar,
      suffixLoading: LoadingAnimationWidget.threeRotatingDots(
        color: context.iconColor,
        size: 27.h,
      ),

      onTap: () async {
        await showDatePicker(context);
      },
    );
  }

  Future<void> showDatePicker(BuildContext context) async {
    DateTime? datePicked = await DatePicker.showSimpleDatePicker(
      context,
      backgroundColor: context.containerColor,
      textColor: context.textColor,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      dateFormat: "yyyy/MM/dd",
      titleText: EviraLang.of(context).selectDate,
      confirmText: EviraLang.of(context).ok,
      cancelText: EviraLang.of(context).cancel,
      looping: true,
    );

    if (datePicked != null) {
      String formattedDate = DateFormat('yyyy/MM/dd').format(datePicked);
      dateController.text = formattedDate;
    }
  }
}
