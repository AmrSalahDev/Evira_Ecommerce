import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/address/domain/entities/address_entity.dart';
import 'package:evira_e_commerce/features/address/ui/bloc/address_bloc.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_cubit.dart';
import 'package:evira_e_commerce/shared/cubits/text_field_state.dart';
import 'package:evira_e_commerce/shared/widgets/custom_button.dart';
import 'package:evira_e_commerce/shared/widgets/custom_checkbox.dart';
import 'package:evira_e_commerce/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddressFormSheet extends StatefulWidget {
  final bool isAdding;
  final bool isFetchingCurrentAddress;
  final String addressDetails;
  final String nameAddress;

  const AddressFormSheet({
    super.key,
    required this.isAdding,
    required this.isFetchingCurrentAddress,
    required this.addressDetails,
    required this.nameAddress,
  });

  @override
  State<AddressFormSheet> createState() => _AddressFormSheetState();
}

class _AddressFormSheetState extends State<AddressFormSheet> {
  late final TextEditingController _addressDetailsController;
  late final TextEditingController _nameAddressController;
  late final GlobalKey<FormState> _formKey;
  late bool _isDefaultAddress;

  @override
  void initState() {
    super.initState();
    _addressDetailsController = TextEditingController(
      text: widget.addressDetails,
    );
    _nameAddressController = TextEditingController(text: widget.nameAddress);
    _formKey = GlobalKey<FormState>();
    _isDefaultAddress = false;

    context.read<TextFieldCubit>().setRequiredFields([
      'nameAddress',
      'addressDetails',
    ]);
  }

  @override
  void dispose() {
    _addressDetailsController.dispose();
    _nameAddressController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AddressFormSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _addressDetailsController.text = widget.addressDetails;
  }

  @override
  Widget build(BuildContext context) {
    context.read<TextFieldCubit>().updateField(
      'nameAddress',
      widget.nameAddress,
    );
    context.read<TextFieldCubit>().updateField(
      'addressDetails',
      widget.addressDetails,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 60.w,
            height: 5.h,
            decoration: BoxDecoration(
              color: context.cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            EviraLang.of(context).addressDetails,
            style: GoogleFonts.urbanist(
              fontWeight: FontWeight.bold,
              fontSize: 25.sp,
              color: context.textColor,
            ),
          ),
          SizedBox(height: 20.h),
          Divider(color: context.dividerColor),
          SizedBox(height: 20.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    EviraLang.of(context).nameAddress,
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: context.textColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    fieldKey: 'nameAddress',
                    controller: _nameAddressController,
                    validator: (value) =>
                        value!.isEmpty ? EviraLang.of(context).required : null,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    EviraLang.of(context).addressDetails,
                    style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: context.textColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomTextField(
                    fieldKey: 'addressDetails',
                    controller: _addressDetailsController,
                    isSuffixLoading: widget.isFetchingCurrentAddress,
                    suffixLoading: LoadingAnimationWidget.threeRotatingDots(
                      size: 30.h,
                      color: context.iconColor,
                    ),

                    suffix: Icon(
                      Icons.location_on,
                      color: context.iconColor,
                      size: 30.h,
                    ),
                    validator: (value) =>
                        value!.isEmpty ? EviraLang.of(context).required : null,
                  ),
                  SizedBox(height: 20.h),
                  CustomCheckbox(
                    value: _isDefaultAddress,
                    title: EviraLang.of(context).makeDefaultAddress,
                    onChecked: (value) {
                      setState(() {
                        _isDefaultAddress = value;
                      });
                    },
                  ),
                  SizedBox(height: 25.h),
                  BlocBuilder<TextFieldCubit, TextFieldState>(
                    builder: (context, state) {
                      final isEnabled =
                          state is TextFieldsUpdated && state.allFieldsFilled;
                      return CustomButton(
                        handleNoInternet: true,
                        isLoading: widget.isAdding,
                        title: EviraLang.of(context).add,
                        onPressed: isEnabled
                            ? () {
                                if (_formKey.currentState!.validate()) {
                                  final AddressEntity address = AddressEntity(
                                    name: _nameAddressController.text,
                                    address: _addressDetailsController.text,
                                    isDefault: _isDefaultAddress,
                                  );
                                  context.read<AddressBloc>().add(
                                    AddAddressEvent(address),
                                  );
                                }
                              }
                            : null,
                        backgroundColor: isEnabled
                            ? context.buttonActiveColor
                            : context.buttonInactiveColor,
                        textColor: isEnabled
                            ? context.textActiveColor
                            : context.textInactiveColor,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
