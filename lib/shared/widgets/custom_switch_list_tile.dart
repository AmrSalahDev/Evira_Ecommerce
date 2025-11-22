import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSwitchListTile extends StatelessWidget {
  final String title;
  final void Function(bool value)? onChanged;
  final bool? value;
  const CustomSwitchListTile({
    super.key,
    required this.title,
    this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      activeTrackColor: context.cardColor,
      inactiveTrackColor: context.cardColor,
      inactiveThumbColor: context.iconColor,
      trackOutlineColor: WidgetStatePropertyAll(Colors.transparent),
      thumbColor: WidgetStatePropertyAll(context.iconColor),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: context.textColor,
        ),
      ),
      value: value ?? false,
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
    );
  }
}
