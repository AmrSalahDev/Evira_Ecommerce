import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/dialog_service.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/language/models/language_model.dart';
import 'package:evira_e_commerce/features/profile/ui/bloc/profile_info_bloc.dart';
import 'package:evira_e_commerce/features/profile/ui/widgets/user_image_part.dart';
import 'package:evira_e_commerce/shared/cubits/language_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/social_auth_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/theme_cubit.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with StatefulScreenMixin {
  @override
  bool get showBackButton => false;

  @override
  String get title => EviraLang.of(context).profile;

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
  void initState() {
    super.initState();
    context.read<ProfileInfoBloc>().add(GetProfileInfoEvent());
  }

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const UserImagePart(),
            SizedBox(height: 20.h),
            const UserNameAndPhonePart(),
            SizedBox(height: 20.h),
            Divider(color: context.dividerColor),
            SizedBox(height: 10.h),
            CustomListTile(
              title: EviraLang.of(context).editProfile,
              svgPath: Assets.icons.userOutline.path,
              onTap: () {},
            ),
            CustomListTile(
              title: EviraLang.of(context).address,
              svgPath: Assets.icons.locationOutline.path,
              onTap: () {},
            ),
            CustomListTile(
              title: EviraLang.of(context).notification,
              svgPath: Assets.icons.notificationOutline.path,
              onTap: () {},
            ),
            CustomListTile(
              title: EviraLang.of(context).payment,
              svgPath: Assets.icons.walletOutline.path,
              onTap: () {},
            ),
            CustomListTile(
              title: EviraLang.of(context).security,
              svgPath: Assets.icons.securityOutline.path,
              onTap: () {},
            ),
            BlocBuilder<LanguageCubit, Locale>(
              builder: (context, locale) {
                return CustomListTile(
                  title: EviraLang.of(context).language,
                  svgPath: Assets.icons.languageOutline.path,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LanguageModel.getLanguageName(locale.languageCode),
                        style: GoogleFonts.urbanist(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: context.textColor,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: context.iconColor,
                        size: 25.h,
                      ),
                    ],
                  ),
                  onTap: () {
                    context.push(AppPaths.language);
                  },
                );
              },
            ),

            SwitchListTilePart(),

            CustomListTile(
              title: EviraLang.of(context).privacyPolicy,
              svgPath: Assets.icons.privacyPolicyOutline.path,
              onTap: () {
                context.push(AppPaths.privacyPolicy);
              },
            ),
            CustomListTile(
              title: EviraLang.of(context).helpCenter,
              svgPath: Assets.icons.helpCenterOutline.path,
              onTap: () {},
            ),
            CustomListTile(
              title: EviraLang.of(context).inviteFriends,
              svgPath: Assets.icons.inviteFriendsOutline.path,
              onTap: () {
                context.push(AppPaths.inviteFriends);
              },
            ),
            CustomListTile(
              title: EviraLang.of(context).logout,
              svgPath: Assets.icons.logoutOutline.path,
              color: Colors.redAccent,
              showArrow: false,
              onTap: () {
                showLogoutDialog(context);
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  DialogService.showCustomSimpleDialog(
    context: context,
    title: EviraLang.of(context).logout,
    content: EviraLang.of(context).logoutDescription,
    confirmText: EviraLang.of(context).logout,
    cancelText: EviraLang.of(context).cancel,
    onConfirm: () async {
      await getIt<SocialAuthCubit>().signOut();
    },
    onCancel: () {
      Navigator.pop(context);
    },
  );
}

class SwitchListTilePart extends StatelessWidget {
  const SwitchListTilePart({super.key});

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
        EviraLang.of(context).darkMode,
        style: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: context.textColor,
        ),
      ),
      value: context.isDark,
      onChanged: (value) {
        context.read<ThemeCubit>().toggleTheme();
      },
      secondary: SvgPicture.asset(
        Assets.icons.darkmodeOutline.path,
        height: 30.h,
        width: 30.h,
        colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final String title;
  final String svgPath;
  final Color? color;
  final bool showArrow;
  final Widget? trailing;
  final void Function()? onTap;
  const CustomListTile({
    super.key,
    required this.title,
    required this.svgPath,
    this.onTap,
    this.color,
    this.showArrow = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(
        svgPath,
        height: 30.h,
        width: 30.h,
        colorFilter: ColorFilter.mode(
          color ?? context.iconColor,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: color ?? context.textColor,
        ),
      ),
      trailing: showArrow
          ? trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  color: context.iconColor,
                  size: 25.h,
                )
          : null,
    );
  }
}

class UserNameAndPhonePart extends StatelessWidget {
  const UserNameAndPhonePart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileInfoBloc, ProfileInfoState>(
      listener: (context, state) {
        if (state is ProfileInfoError) {
          getIt<ToastService>().showErrorToast(
            message: state.message,
            context: context,
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileInfoLoading) {
          return Column(
            children: [
              ShimmerBox(height: 30.h, width: context.screenWidth * 0.4),
              SizedBox(height: 10.h),
              ShimmerBox(height: 30.h, width: context.screenWidth * 0.3),
            ],
          );
        } else if (state is ProfileInfoLoaded) {
          return Column(
            children: [
              Text(
                state.profile.fullname,
                style: GoogleFonts.urbanist(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: context.textColor,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                state.profile.phone,
                style: GoogleFonts.urbanist(
                  fontSize: 18.sp,
                  color: context.textColor,
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
