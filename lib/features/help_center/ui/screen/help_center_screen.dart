import 'package:evira_e_commerce/core/gen/assets.gen.dart';
import 'package:evira_e_commerce/core/lang_generated/l10n.dart';
import 'package:evira_e_commerce/core/routes/app_router.dart';
import 'package:evira_e_commerce/core/theme/app_theme.dart';
import 'package:evira_e_commerce/features/help_center/data/models/contact_method_model.dart';
import 'package:evira_e_commerce/features/help_center/data/models/question_model.dart';
import 'package:evira_e_commerce/shared/mixins/stateful_screen_mixin.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with StatefulScreenMixin, SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  String get title => EviraLang.of(context).helpCenter;

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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        TabBarPart(tabController: _tabController),
        SizedBox(height: 20.h),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            clipBehavior: Clip.none,
            children: [
              FAQTabView(),
              ContactUsTabView(
                onTap: (int index) {
                  switch (index) {
                    case 0:
                      context.push(AppPaths.customerService);
                      break;
                      
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContactUsTabView extends StatefulWidget {
  final void Function(int index) onTap;
  const ContactUsTabView({super.key, required this.onTap});

  @override
  State<ContactUsTabView> createState() => _ContactUsTabViewState();
}

class _ContactUsTabViewState extends State<ContactUsTabView> {
  final List<ContactMethodModel> contactMethods = [
    ContactMethodModel(
      name: EviraLang.current.customerService,
      iconPath: Assets.icons.customerService.path,
    ),
    ContactMethodModel(
      name: EviraLang.current.whatsapp,
      iconPath: Assets.icons.whatsapp.path,
    ),
    ContactMethodModel(
      name: EviraLang.current.website,
      iconPath: Assets.icons.website.path,
    ),
    ContactMethodModel(
      name: EviraLang.current.facebook,
      iconPath: Assets.icons.facebook2.path,
    ),
    ContactMethodModel(
      name: EviraLang.current.twitter,
      iconPath: Assets.icons.twitter.path,
    ),
    ContactMethodModel(
      name: EviraLang.current.instagram,
      iconPath: Assets.icons.instagram.path,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactMethods.length,
      itemBuilder: (context, index) {
        final method = contactMethods[index];
        return Container(
          decoration: BoxDecoration(
            color: context.textFieldColor,
            borderRadius: BorderRadius.circular(15),
          ),

          margin: EdgeInsets.only(bottom: 20.h),
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: ListTile(
            onTap: () => widget.onTap(index),
            leading: SvgPicture.asset(
              method.iconPath,
              height: 30.h,
              width: 30.h,
              colorFilter: ColorFilter.mode(context.iconColor, BlendMode.srcIn),
            ),
            title: Text(
              method.name,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: context.iconColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FAQTabView extends StatefulWidget {
  const FAQTabView({super.key});

  @override
  State<FAQTabView> createState() => _FAQTabViewState();
}

class _FAQTabViewState extends State<FAQTabView> {
  QuestionModel? _selectedQuestion;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.backgroundColor,
      child: Column(
        children: [
          HelpCenterCategoryBar(onCategorySelected: () {}),
          SizedBox(height: 20.h),
          SearchBarPart(
            onQuestionSelected: (question) {
              setState(() {
                _selectedQuestion = question;
              });
            },
          ),
          SizedBox(height: 30.h),
          ExpansionTileCardPart(selectedQuestion: _selectedQuestion),
        ],
      ),
    );
  }
}

class ExpansionTileCardPart extends StatefulWidget {
  final QuestionModel? selectedQuestion;

  const ExpansionTileCardPart({super.key, this.selectedQuestion});

  @override
  State<ExpansionTileCardPart> createState() => _ExpansionTileCardPartState();
}

class _ExpansionTileCardPartState extends State<ExpansionTileCardPart> {
  final ScrollController _scrollController = ScrollController();
  int? _expandedIndex;

  @override
  void didUpdateWidget(ExpansionTileCardPart oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if a new question was selected
    if (widget.selectedQuestion != null &&
        widget.selectedQuestion != oldWidget.selectedQuestion) {
      // Find the index of the selected question
      final index = QuestionModel.questions.indexOf(widget.selectedQuestion!);
      if (index != -1) {
        setState(() {
          _expandedIndex = index;
        });
        // Scroll to the selected item
        Future.delayed(const Duration(milliseconds: 100), () {
          if (_scrollController.hasClients) {
            // Calculate the position to scroll to
            double position = 0.0;
            for (int i = 0; i < index; i++) {
              position += 100.0; // Approximate height of each item
            }
            _scrollController.animateTo(
              position,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: QuestionModel.questions.length,
        itemBuilder: (context, index) {
          final question = QuestionModel.questions[index];
          final isExpanded = _expandedIndex == index;
          return Column(
            children: [
              ExpansionTileCard(
                key: ValueKey(
                  'question-$index-${isExpanded ? "expanded" : "collapsed"}',
                ),
                initiallyExpanded: isExpanded,
                borderRadius: BorderRadius.circular(15),
                title: Text(
                  question.question,
                  style: GoogleFonts.urbanist(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: context.textColor,
                  ),
                ),
                onExpansionChanged: (expanded) {
                  setState(() {
                    _expandedIndex = expanded ? index : null;
                  });
                },
                baseColor: context.textFieldColor,
                expandedColor: context.textFieldColor,
                shadowColor: Colors.transparent,
                expandedTextColor: context.textSmallGrayColor,
                children: <Widget>[
                  Divider(
                    color: context.dividerColor,
                    indent: 15.w,
                    endIndent: 15.w,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: Text(
                        question.answer,
                        style: GoogleFonts.urbanist(
                          fontSize: 18.sp,
                          color: context.textSmallGrayColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25.h),
            ],
          );
        },
      ),
    );
  }
}

class SearchBarPart extends StatefulWidget {
  final Function(QuestionModel)? onQuestionSelected;

  const SearchBarPart({super.key, this.onQuestionSelected});

  @override
  State<SearchBarPart> createState() => _SearchBarPartState();
}

class _SearchBarPartState extends State<SearchBarPart> {
  QuestionModel? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<QuestionModel>(
      displayStringForOption: (QuestionModel option) => '',
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<QuestionModel>.empty();
        }
        return QuestionModel.questions.where((QuestionModel option) {
          return option.question.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          );
        });
      },
      onSelected: (QuestionModel selection) {
        setState(() {
          _selectedOption = selection;
        });

        // Notify parent widget about the selection
        widget.onQuestionSelected?.call(selection);
      },
      fieldViewBuilder:
          (context, textEditingController, focusNode, onFieldSubmitted) {
            return TextField(
              controller: textEditingController,
              focusNode: focusNode,
              onSubmitted: (value) {
                onFieldSubmitted();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: context.textFieldColor,
                prefixIcon: Icon(
                  Icons.search,
                  color: context.hintColor,
                  size: 30.h,
                ),
                suffixIcon: Transform.scale(
                  scale: 0.5,
                  child: Assets.icons.slidersSimple.svg(
                    width: 30.w,
                    height: 30.h,
                    colorFilter: ColorFilter.mode(
                      context.iconColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 22.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide(color: context.textFieldBorderColor),
                ),
                hintText: EviraLang.of(context).search,
                hintStyle: GoogleFonts.urbanist(
                  color: context.textHintColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            );
          },
      optionsViewBuilder: (context, onSelected, options) {
        // Define heights for different scenarios
        final itemHeight = 60.h; // Default ListTile height
        final maxHeight = 250.h; // Maximum height regardless of number of items
        final minHeight = 70.h; // Minimum height for the dropdown

        // Calculate the total height needed
        final calculatedHeight = (options.length * itemHeight).clamp(
          minHeight,
          maxHeight,
        );
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            elevation: 4.0,
            surfaceTintColor: context.backgroundColor,
            color: context.backgroundColor,
            borderRadius: BorderRadius.circular(15.r),
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              height: calculatedHeight,
              width:
                  MediaQuery.of(context).size.width -
                  40.w, // Adjust width as needed

              decoration: BoxDecoration(
                color: context.textFieldColor,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: options.length,
                separatorBuilder: (context, index) => Divider(
                  color: context.dividerColor,
                  endIndent: 15.w,
                  indent: 15.w,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final QuestionModel option = options.elementAt(index);
                  return ListTile(
                    minTileHeight: 60.h,
                    title: Text(
                      option.question,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        color: context.textColor,
                      ),
                    ),
                    onTap: () {
                      onSelected(option);
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class HelpCenterCategoryBar extends StatefulWidget {
  final void Function() onCategorySelected;
  const HelpCenterCategoryBar({super.key, required this.onCategorySelected});

  @override
  State<HelpCenterCategoryBar> createState() => _HelpCenterCategoryBarState();
}

class _HelpCenterCategoryBarState extends State<HelpCenterCategoryBar> {
  List<String> _categories = [];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    _categories = <String>[
      EviraLang.of(context).general,
      EviraLang.of(context).account,
      EviraLang.of(context).service,
      EviraLang.of(context).payment,
    ];
    return SizedBox(
      height: 70.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => selectedIndex = index);
              widget.onCategorySelected();
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Chip(
                label: Text(
                  _categories[index],
                  style: GoogleFonts.urbanist(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: context.textColor,
                  ),
                ),
                shape: StadiumBorder(
                  side: BorderSide(color: context.cardColor, width: 1.5),
                ),
                backgroundColor: isSelected
                    ? context.cardColor
                    : context.backgroundColor,
              ),
            ),
          );
        },
        itemCount: _categories.length,
      ),
    );
  }
}

class TabBarPart extends StatelessWidget {
  const TabBarPart({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: context.textColor,
      dividerColor: context.dividerColor,
      unselectedLabelColor: context.textHintColor,
      dividerHeight: 1.5,
      labelStyle: TextStyle(fontSize: 20.sp, color: context.textColor),
      tabs: [
        Tab(text: EviraLang.of(context).faq),
        Tab(text: EviraLang.of(context).contactUs),
      ],
    );
  }
}
