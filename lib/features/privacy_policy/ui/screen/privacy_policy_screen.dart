import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).privacyPolicy;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20.h),
          PolicySection(
            title: "1. Types of Data We Collect",
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in'
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla'
                'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in'
                'culpa qui officia deserunt mollit anim id est laborum."',
          ),
          SizedBox(height: 20.h),
          PolicySection(
            title: "2. Use of Your Personal Data",
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in'
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla'
                'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in'
                'culpa qui officia deserunt mollit anim id est laborum."',
          ),
          SizedBox(height: 20.h),
          PolicySection(
            title: "3. Disclosure of Your Personal Data",
            content:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.'
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris'
                'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in'
                'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla'
                'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in'
                'culpa qui officia deserunt mollit anim id est laborum."',
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}

class PolicySection extends StatelessWidget {
  final String title;
  final String content;

  const PolicySection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: context.textColor,
            fontSize: 25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          content,
          style: GoogleFonts.urbanist(
            color: context.textSmallGrayColor,
            fontSize: 18.sp,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
