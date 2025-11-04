import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/language/models/language_model.dart';
import 'package:evira_e_commerce/shared/cubits/language_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).language;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Text(
                EviraLang.of(context).suggested,
                style: GoogleFonts.urbanist(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              SizedBox(height: 25.h),
              ...LanguageModel.suggestedLanguages.map(
                (lang) => LanguageTile(
                  title: lang.name,
                  locale: lang.locale,
                  selected:
                      locale.languageCode == lang.locale.languageCode &&
                      locale.countryCode == lang.locale.countryCode,
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(lang.locale);
                  },
                ),
              ),
              Divider(color: context.dividerColor),
              SizedBox(height: 10.h),
              Text(
                EviraLang.of(context).language,
                style: GoogleFonts.urbanist(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
              SizedBox(height: 20.h),
              ...LanguageModel.languages.map(
                (lang) => LanguageTile(
                  title: lang.name,
                  locale: lang.locale,
                  selected:
                      locale.languageCode == lang.locale.languageCode &&
                      locale.countryCode == lang.locale.countryCode,
                  onTap: () {
                    context.read<LanguageCubit>().changeLanguage(lang.locale);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String title;
  final Locale locale;
  final bool selected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.title,
    required this.locale,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: context.textColor,
              ),
            ),
            Icon(
              selected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off_outlined,
              color: selected ? context.iconColor : context.iconColor,
            ),
          ],
        ),
      ),
    );
  }
}
