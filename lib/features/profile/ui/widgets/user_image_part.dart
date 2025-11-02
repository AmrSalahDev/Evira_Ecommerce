import 'package:cached_network_image/cached_network_image.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/profile/ui/bloc/profile_image_bloc.dart';
import 'package:evira_e_commerce/features/profile/ui/bloc/profile_image_picker_bloc.dart';
import 'package:evira_e_commerce/shared/widgets/image_file_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class UserImagePart extends StatefulWidget {
  const UserImagePart({super.key});

  @override
  State<UserImagePart> createState() => _UserImagePartState();
}

class _UserImagePartState extends State<UserImagePart> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileImageBloc>().add(GetUserImage());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 180.h,
          height: 180.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: context.profileBgColor,
          ),
          child: BlocConsumer<ProfileImagePickerBloc, ProfileImagePickerState>(
            listener: (context, state) {
              if (state is ProfileImagePicked) {
                context.read<ProfileImageBloc>().add(
                  UpdateUserImage(imageFile: state.imageFile),
                );
              }
            },
            builder: (context, state) {
              if (state is ProfileImagePicked) {
                return ClipOval(
                  child: ImageFileLoading(
                    file: state.imageFile,
                    width: 180.h,
                    height: 180.h,
                    fit: BoxFit.cover,
                    onError: Assets.icons.profile.svg(
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        context.profileIconColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              } else {
                return BlocBuilder<ProfileImageBloc, ProfileImageState>(
                  builder: (context, state) {
                    if (state is ProfileImageLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is ProfileImageLoaded &&
                        state.imageUrl.isNotEmpty) {
                      return ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: state.imageUrl,
                          fit: BoxFit.cover,
                          height: 180.h,
                          width: 180.h,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: context.shimmerBaseColor,
                            highlightColor: context.shimmerHighlightColor,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.shimmerBaseColor,
                              ),
                              width: 180.h,
                              height: 180.h,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Assets.icons.profile.svg(
                                width: 150.w,
                                height: 150.h,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  context.profileIconColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                        ),
                      );
                    }
                    return Assets.icons.profile.svg(
                      width: 150.w,
                      height: 150.h,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        context.profileIconColor,
                        BlendMode.srcIn,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          right: 10.w,
          bottom: 5.h,
          child: GestureDetector(
            onTap: () =>
                context.read<ProfileImagePickerBloc>().add(PickImageEvent()),
            child: Container(
              width: 37.h,
              height: 37.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: context.iconColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                FontAwesomeIcons.pen,
                color: context.textActiveColor,
                size: 22.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
