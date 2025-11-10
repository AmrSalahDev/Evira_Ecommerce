import 'package:animate_do/animate_do.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/address/ui/bloc/address_bloc.dart';
import 'package:evira_e_commerce/features/address/ui/widgets/address_card.dart';
import 'package:evira_e_commerce/features/address/ui/widgets/shimmer_address_card.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen>
    with StatefulScreenMixin, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(GetAddressesEvent());
  }

  @override
  String get title => EviraLang.of(context).address;

  @override
  Widget? buildBottomNavigationBar() {
    return BlocSelector<AddressBloc, AddressState, bool>(
      selector: (state) {
        return state.isFetchingAddresses;
      },
      builder: (context, isLoading) {
        return isLoading
            ? const SizedBox.shrink()
            : SlideInUp(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOut,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h),
                  child: CustomButton(
                    title: EviraLang.of(context).addNewAddress,
                    onPressed: () => context.push(AppPaths.addNewAddress),
                    backgroundColor: context.buttonColor,
                    textColor: context.buttonTextColor,
                  ),
                ),
              );
      },
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocConsumer<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state.errorMessage.isNotEmpty) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.errorMessage,
          );
        }
      },
      builder: (context, state) {
        if (state.isFetchingAddresses) {
          return const ShimmerAddressCard();
        }
        if (state.isFetchingAddresses == false) {
          if (state.addresses.isEmpty) {
            return Center(
              child: Text(
                EviraLang.of(context).noAddressesYet,
                style: TextStyle(color: context.textColor, fontSize: 20.sp),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.addresses.length,
            itemBuilder: (context, index) =>
                AddressCard(address: state.addresses[index], onTap: () {}),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
