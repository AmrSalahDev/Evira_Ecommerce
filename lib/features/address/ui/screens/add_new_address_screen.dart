import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/address/ui/bloc/address_bloc.dart';
import 'package:evira_e_commerce/features/address/ui/bloc/location_bloc.dart';
import 'package:evira_e_commerce/features/address/ui/widgets/address_form_sheet.dart';
import 'package:evira_e_commerce/features/address/ui/widgets/map_widget.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen>
    with StatefulScreenMixin {
  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(ListenToLocationServiceStatusEvent());
    context.read<LocationBloc>().add(GetCurrentLocationEvent());
  }

  @override
  String get title => EviraLang.of(context).addNewAddress;

  @override
  bool get addPadding => false;

  @override
  String? get routeName => AppPaths.addNewAddress;

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
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            height: context.screenHeight * 0.4,
            child: BlocConsumer<LocationBloc, LocationState>(
              listener: (context, state) {
                if (state is LocationError) {
                  getIt<ToastService>().showErrorToast(
                    message: state.message,
                    context: context,
                  );
                }
              },
              builder: (context, state) {
                if (state is LocationLoading) {
                  return ShimmerBox(
                    height: context.screenHeight * 0.4,
                    width: double.infinity,
                    borderRadius: 0,
                  );
                }
                if (state is LocationError) {
                  return ShimmerBox(
                    height: context.screenHeight * 0.4,
                    width: double.infinity,
                    borderRadius: 0,
                  );
                }
                if (state is LocationLoaded) {
                  return MapWidget(initialPosition: state.position);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: context.screenHeight * 0.55,
            width: context.screenWidth,
            decoration: BoxDecoration(
              color: context.backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: BlocBuilder<AddressBloc, AddressState>(
              builder: (context, state) {
                final isAdding = state.isAddingAddress;
                final isFetchingCurrentAddress = state.isFetchingCurrentAddress;

                return BlocSelector<AddressBloc, AddressState, String>(
                  selector: (state) {
                    return state.addressDetails;
                  },
                  builder: (context, addressDetails) {
                    return AddressFormSheet(
                      isAdding: isAdding,
                      isFetchingCurrentAddress: isFetchingCurrentAddress,
                      addressDetails: addressDetails,
                      nameAddress: EviraLang.of(context).unNamed,
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
