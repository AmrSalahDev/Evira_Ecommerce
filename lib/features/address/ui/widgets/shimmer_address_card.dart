import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerAddressCard extends StatelessWidget {
  const ShimmerAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) => ShimmerBox(
        shimmerBaseColor: context.cardColor,
        height: 90.h,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 12.h),
      ),
    );
  }
}
