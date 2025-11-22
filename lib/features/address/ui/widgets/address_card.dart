import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback onTap;

  const AddressCard({super.key, required this.address, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.textFieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.iconColor,
            border: Border.all(color: context.cardColor, width: 7),
          ),
          child: Icon(Icons.location_on, color: context.cardColor),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textColor,
                  ),
                ),
                SizedBox(height: 5.h),
                if (address.isDefault) ...[
                  SizedBox(width: 10.w),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: context.cardColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      EviraLang.of(context).defaultt,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: context.textColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (address.isDefault) SizedBox(height: 5.h),
            Text(
              address.address,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                color: context.textSmallGrayColor,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: onTap,
          icon: Icon(Icons.edit, color: context.iconColor),
        ),
      ),
    );
  }
}
