import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/core/utils/app_utils.dart';
import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';
import 'package:evira_e_commerce/features/customer_service/ui/bloc/customer_service_bloc.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:evira_e_commerce/shared/widgets/shimmer_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen>
    with StatefulScreenMixin {
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    context.read<CustomerServiceBloc>().add(GetMessagesEvent());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  String get title => EviraLang.of(context).customerService;

  @override
  bool get applyPaddingForBottomNavigationBar => false;

  @override
  List<Widget>? buildActions() {
    return [
      IconButton(
        icon: Assets.icons.phone.svg(
          height: 30.h,
          width: 30.h,
          colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
        ),
        onPressed: () {},
      ),
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
  Widget? buildBottomNavigationBar() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SendBarPart(
        messageController: _messageController,
        context: context,
        onSendMessage: _sendMessage,
      ),
    );
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder<CustomerServiceBloc, CustomerServiceState>(
      builder: (context, state) {
        if (state is ChatLoadingState) {
          return ListView.builder(
            // Show a few shimmer items to mimic a real conversation
            itemCount: 10,
            itemBuilder: (context, index) {
              // Alternate between user and customer service messages
              return ShimmerMessages(isUser: index % 2 != 0);
            },
          );
        } else if (state is ChatLoadedState) {
          return GroupedListView<MessageEntity, String>(
            elements: state.messages,
            controller: _scrollController,
            clipBehavior: Clip.none,
            useStickyGroupSeparators: true,
            floatingHeader: true,
            groupBy: (message) => AppUtils.getDateGroup(message.createdAt),
            groupComparator: (value1, value2) => value2.compareTo(value1),
            itemComparator: (item1, item2) =>
                item1.createdAt.compareTo(item2.createdAt),
            groupSeparatorBuilder: (String groupByValue) => Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: context.textFieldColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                groupByValue,
                style: TextStyle(fontSize: 16.sp, color: context.textHintColor),
              ),
            ),
            itemBuilder: (context, MessageEntity message) {
              return ChatMessage(
                text: message.content,
                isUser: message.isUserMessage,
                time: DateFormat('h:mm a').format(message.createdAt),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    context.read<CustomerServiceBloc>().add(
      SendMessageEvent(message: _messageController.text.trim()),
    );
    _messageController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}

class ShimmerMessages extends StatelessWidget {
  final bool isUser;

  const ShimmerMessages({super.key, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isUser) ...[
            Shimmer.fromColors(
              baseColor: context.shimmerBaseColor,
              highlightColor: context.shimmerHighlightColor,
              child: CircleAvatar(
                backgroundColor: context.cardColor,
                radius: 16,
                child: Icon(
                  Icons.support_agent,
                  color: context.iconColor,
                  size: 24.h,
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: context.shimmerBaseColor,
                  highlightColor: context.shimmerHighlightColor,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isUser ? context.buttonColor : context.cardColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: isUser
                            ? const Radius.circular(12)
                            : const Radius.circular(0),
                        bottomRight: isUser
                            ? const Radius.circular(0)
                            : const Radius.circular(12),
                      ),
                    ),
                    // Use the ShimmerBox for the message content
                    child: ShimmerBox(
                      height: 30,
                      // Make the width variable to look more natural
                      width:
                          MediaQuery.of(context).size.width *
                          (0.3 + (0.3 * (isUser ? 1 : 0))),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Use the ShimmerBox for the timestamp
                ShimmerBox(
                  height: 12,
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.w),
            Shimmer.fromColors(
              baseColor: context.shimmerBaseColor,
              highlightColor: context.shimmerHighlightColor,
              child: CircleAvatar(
                backgroundColor: context.cardColor,
                radius: 16,
                child: Icon(Icons.person, color: context.iconColor, size: 24.h),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SendBarPart extends StatefulWidget {
  const SendBarPart({
    super.key,
    required TextEditingController messageController,
    required this.context,
    required this.onSendMessage,
  }) : _messageController = messageController;

  final TextEditingController _messageController;
  final BuildContext context;
  final void Function() onSendMessage;

  @override
  State<SendBarPart> createState() => _SendBarPartState();
}

class _SendBarPartState extends State<SendBarPart> {
  late final FocusNode focusNode;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      }
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      color: context.backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.send,
                  controller: widget._messageController,
                  style: TextStyle(color: context.textColor),
                  decoration: InputDecoration(
                    suffixIcon: Transform.scale(
                      scale: 0.5,
                      child: Assets.icons.gallery.svg(
                        height: 24.h,
                        width: 24.h,
                        colorFilter: ColorFilter.mode(
                          isFocused ? context.iconColor : context.hintColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),

                    hintText: EviraLang.of(context).message,
                    hintStyle: TextStyle(color: context.textHintColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: context.textFieldBorderColor,
                      ),
                    ),
                    filled: true,
                    fillColor: context.textFieldColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                  ),
                  onSubmitted: (_) {
                    widget.onSendMessage();
                    setState(() {
                      isFocused = false;
                    });
                    focusNode.unfocus();
                  },
                ),
              ),
              SizedBox(width: 12.w),
              IconButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.all(16)),
                  backgroundColor: WidgetStateProperty.all(context.buttonColor),
                ),
                icon: Icon(
                  Icons.mic,
                  color: context.buttonTextColor,
                  size: 30.h,
                ),
                onPressed: () {
                  widget.onSendMessage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;
  final String time;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isUser,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              backgroundColor: context.cardColor,
              radius: 16,
              child: Icon(
                Icons.support_agent,
                color: context.iconColor,
                size: 24.h,
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isUser ? context.buttonColor : context.cardColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: isUser
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: isUser
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isUser
                          ? context.buttonTextColor
                          : context.textColor,
                      fontSize: 18.sp,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  time,
                  style: TextStyle(
                    color: context.textHintColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            SizedBox(width: 8.w),
            CircleAvatar(
              backgroundColor: context.cardColor,
              radius: 16,
              child: Icon(Icons.person, color: context.iconColor, size: 24.h),
            ),
          ],
        ],
      ),
    );
  }
}
