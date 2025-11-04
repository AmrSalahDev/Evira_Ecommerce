import 'package:contacts_service_plus/contacts_service_plus.dart';
import 'package:evira_e_commerce/core/di/di.dart';
import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/services/toast_service.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/invite_friends/domain/enum/invite_method.dart';
import 'package:evira_e_commerce/features/invite_friends/ui/bloc/invite_friends_bloc.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_toolkit/core/extensions/context_extensions.dart';

class InviteFriendsScreen extends StatefulWidget {
  const InviteFriendsScreen({super.key});

  @override
  State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
}

class _InviteFriendsScreenState extends State<InviteFriendsScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).inviteFriends;

  @override
  void initState() {
    super.initState();
    context.read<InviteFriendsBloc>().add(GetFriendsEvent());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocListener<InviteFriendsBloc, InviteFriendsState>(
      listener: (context, state) {
        if (state is InviteFriendsError) {
          getIt<ToastService>().showErrorToast(
            context: context,
            message: state.message,
          );
        }
      },
      child: BlocBuilder<InviteFriendsBloc, InviteFriendsState>(
        builder: (context, state) {
          if (state is InviteFriendsLoading) {
            return ShimmerFriendsPart();
          } else if (state is InviteFriendsLoaded) {
            if (state.contacts.isEmpty) {
              return Center(
                child: Text(
                  EviraLang.of(context).noContactsFound,
                  style: GoogleFonts.urbanist(
                    color: context.textColor,
                    fontSize: 30.sp,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.contacts.length,
                itemBuilder: (context, index) {
                  final contact = state.contacts[index];
                  final isInvited = state.invitedContacts.contains(
                    contact.identifier,
                  );

                  return ContactListItem(
                    contact: contact,
                    isInvited: isInvited,
                    onInvite: () => _showInviteOptions(context, contact),
                  );
                },
              );
            }
          } else if (state is InviteFriendsError) {
            if (state.message.contains("PermissionManager")) {
              return ShimmerFriendsPart();
            }
            return const SizedBox.shrink();
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showInviteOptions(BuildContext context, Contact contact) {
    final bloc = context.read<InviteFriendsBloc>();
    showModalBottomSheet(
      context: context,
      backgroundColor: context.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${EviraLang.of(context).invite} ${contact.displayName ?? EviraLang.of(context).unknown}',
              style: GoogleFonts.urbanist(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: context.textColor,
              ),
            ),
            SizedBox(height: 20.h),
            if (contact.phones != null && contact.phones!.isNotEmpty)
              ListTile(
                leading: Icon(Icons.message, color: context.iconColor),
                title: Text(
                  EviraLang.of(context).sendSms,
                  style: GoogleFonts.urbanist(
                    color: context.textColor,
                    fontSize: 20.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  bloc.add(
                    InviteFriendEvent(
                      contact: contact,
                      method: InviteMethod.sms,
                    ),
                  );
                },
              ),
            if (contact.emails != null && contact.emails!.isNotEmpty)
              ListTile(
                leading: Icon(Icons.email, color: context.iconColor),
                title: Text(
                  EviraLang.of(context).sendEmail,
                  style: GoogleFonts.urbanist(
                    color: context.textColor,
                    fontSize: 20.sp,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  bloc.add(
                    InviteFriendEvent(
                      contact: contact,
                      method: InviteMethod.email,
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class ShimmerFriendsPart extends StatelessWidget {
  const ShimmerFriendsPart({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            children: [
              ShimmerBox(height: 75.h, width: 75.h, borderRadius: 100),
              SizedBox(width: 15.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerBox(height: 25.h, width: context.screenWidth * 0.4),
                  SizedBox(height: 10.h),
                  ShimmerBox(height: 25.h, width: context.screenWidth * 0.3),
                ],
              ),
              const Spacer(),
              ShimmerBox(height: 40.h, width: 70.w, borderRadius: 30),
            ],
          ),
        );
      },
    );
  }
}

class ContactListItem extends StatelessWidget {
  final Contact contact;
  final bool isInvited;
  final VoidCallback onInvite;

  const ContactListItem({
    super.key,
    required this.contact,
    required this.isInvited,
    required this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25.h),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
                contact.avatar != null && contact.avatar!.isNotEmpty
                ? MemoryImage(contact.avatar!)
                : null,
            backgroundColor: context.profileBgColor,
            child: contact.avatar == null || contact.avatar!.isEmpty
                ? Assets.icons.person.image(
                    color: context.iconColor,
                    width: 35.h,
                    height: 35.h,
                  )
                : null,
          ),
          SizedBox(width: 15.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.displayName ?? EviraLang.of(context).unknown,
                  style: GoogleFonts.urbanist(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: context.textColor,
                  ),
                ),
                if (contact.phones != null && contact.phones!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      contact.phones!.first.value ?? '',
                      style: GoogleFonts.urbanist(
                        fontSize: 18.sp,
                        color: context.textSmallGrayColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            onTap: isInvited ? null : onInvite,
            child: Container(
              decoration: BoxDecoration(
                color: isInvited ? Colors.transparent : context.cardColor,
                border: Border.all(color: context.cardColor, width: 2),
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

              child: Text(
                isInvited
                    ? EviraLang.of(context).invited
                    : EviraLang.of(context).invite,
                style: GoogleFonts.urbanist(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
