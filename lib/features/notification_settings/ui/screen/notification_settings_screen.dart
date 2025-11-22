import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/custom_switch_list_tile.dart';
import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen>
    with StatefulScreenMixin {
  @override
  String get title => EviraLang.of(context).notification;

  @override
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Column(
        children: [
          CustomSwitchListTile(
            title: EviraLang.of(context).general_notification,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).sound,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).vibrate,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).specialOffers,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).promoAndDiscount,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).payments,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).cashback,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).appUpdates,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).newServiceAvailable,
            onChanged: (value) {},
          ),
          CustomSwitchListTile(
            title: EviraLang.of(context).newTipsAvailable,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
