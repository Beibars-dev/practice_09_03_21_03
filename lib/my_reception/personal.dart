import 'package:chat_bot_project/core/bottom_navbar/bottom_navigation_bar.dart';
import 'package:chat_bot_project/core/common/custom_date_picker.dart';
import 'package:chat_bot_project/core/common/custom_textfield.dart';
import 'package:chat_bot_project/core/common/custom_time_picker.dart';
import 'package:chat_bot_project/core/get_it/injection_container.dart';
import 'package:chat_bot_project/core/styles/colors.dart';
import 'package:chat_bot_project/core/styles/textStyles.dart';
import 'package:chat_bot_project/features/screens/directory/logic/bloc/directory_bloc.dart';
import 'package:chat_bot_project/features/screens/home/widgets/text_box.dart';
import 'package:chat_bot_project/features/screens/personal_reception/logic/bloc/personal_reception_bloc.dart';
import 'package:chat_bot_project/features/screens/personal_reception/logic/data/models/region_model.dart';
import 'package:chat_bot_project/features/screens/personal_reception/logic/data/repositories/personal_reception_repository.dart';
import 'package:chat_bot_project/features/screens/personal_reception/widgets/choosabe_list.dart';
import 'package:chat_bot_project/features/screens/personal_reception/screens/personal_list.dart';
import 'package:chat_bot_project/features/screens/personal_reception/screens/personal_reception_sub_level.dart';
import 'package:chat_bot_project/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalReception extends StatefulWidget {
  final int? personalIndex;
  const PersonalReception({super.key, this.personalIndex = 0});

  @override
  State<PersonalReception> createState() => _PersonalReceptionState();
}

class _PersonalReceptionState extends State<PersonalReception>
    with TickerProviderStateMixin {
  RegionModel? selectedRegion;
  RegionModel? selectedProsecutorOffice;
  RegionModel? selectedQuestionType;
  String? selectedPersenId;
  Map? selectedPerson;

  String _noticeDate = '';
  String _noticeTime = '';

  void onNoticeDate(date) {
    setState(() {
      _noticeDate = date.toString();
    });
  }

  void onNoticeTime(date) {
    setState(() {
      _noticeTime = date.toString();
    });
  }

  late int regionId = 0;
  late int organId = 0;
  late int characterId = 0;

  List<String> regionArray = [];
  List<String> organArray = [];

  List<RegionModel> region = [];
  List<RegionModel> organ = [];
  List<RegionModel> character = [];

  TextEditingController _descriptionController = TextEditingController();
  late TabController tabController;

  @override
  void initState() {
    context
        .read<PersonalReceptionBloc>()
        .add(PersonalReceptionGet(isFirst: true));
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalReceptionBloc, PersonalReceptionState>(
      listener: (context, state) {
        if (state is PersonalReceptionSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (_) => BottomNavBar(
                index: 1,
                personalIndex: 1,
              ),
            ),
            (route) => false,
          );
          showSuccesDialog(
            context: context,
            title: '${LocaleKeys.completed.tr(context: context)}!',
            subtitle: LocaleKeys.succesRequestPersonal.tr(context: context),
            spanText: '«${LocaleKeys.requesthistory.tr(context: context)}»',
            color: const Color(0xff02BA18),
            isSpan: true,
          );
        }
        if (state is PersonalReceptionFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(LocaleKeys.uncorrectinfo.tr(context: context))));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff6f6f6),
        appBar: AppBar(
          backgroundColor: ColorStyles.backgroundColor,
          surfaceTintColor: ColorStyles.backgroundColor,
          title: Text(
            LocaleKeys.personalreception.tr(context: context),
            style: montserattTitle12.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          child: DefaultTabController(
            initialIndex: widget.personalIndex ?? 0,
            length: 2,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  indicatorColor: ColorStyles.lightBlueColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelColor: Colors.grey,
                  overlayColor: MaterialStateProperty.all(
                      ColorStyles.lightBlueColor.withValues(alpha: 0.1)),
                  labelStyle: montserattTitle12.copyWith(
                    color: ColorStyles.lightBlueColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  onTap: (value) {
                    if (value == 0) {
                      selectedRegion = null;
                      selectedProsecutorOffice = null;
                      selectedQuestionType = null;
                      context
                          .read<PersonalReceptionBloc>()
                          .add(PersonalReceptionGet(isFirst: true));
                    }
                  },
                  tabs: [
                    Tab(text: LocaleKeys.signreception.tr(context: context)),
                    Tab(text: LocaleKeys.requesthistory.tr(context: context)),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildPersonalReception(context),
                      const PersonalList()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalReception(BuildContext context) {
    return RefreshIndicator(
      color: ColorStyles.lightBlueColor,
      backgroundColor: ColorStyles.highlightColorShimmer,
      onRefresh: () async {
        context.read<PersonalReceptionBloc>().add(PersonalReceptionGet());
        return Future<void>.delayed(const Duration(seconds: 1));
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: Column(
            children: [
              BlocConsumer<PersonalReceptionBloc, PersonalReceptionState>(
                listener: (context, state) {
                  if (state is PersonalReceptionGetSuccess) {
                    region = state.region ?? region;
                    if (selectedProsecutorOffice == null &&
                        selectedPerson == null) {
                      organ = state.organ ?? organ;
                    }
                    character = state.character ?? character;
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      // region
                      ChoosableList(
                        hintText: LocaleKeys.region.tr(context: context),
                        items: region,
                        value: selectedRegion,
                        onChanged: (RegionModel? value) {
                          setState(() {
                            selectedRegion = value;
                            selectedProsecutorOffice = null;
                            selectedPersenId = null;
                          });
                          context.read<PersonalReceptionBloc>().add(
                                PersonalReceptionGet(id: value?.id ?? 0),
                              );
                          regionId = value?.id ?? 0;
                        },
                      ),

                      // organ proc
                      ChoosableList(
                        hintText:
                            LocaleKeys.organprosecutor.tr(context: context),
                        onChanged: (RegionModel? value) {
                          setState(() {
                            selectedProsecutorOffice = value;
                            selectedPersenId = null;
                          });
                          organId = value?.id ?? 0;
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MultiBlocProvider(
                                providers: [
                                  BlocProvider<PersonalReceptionBloc>(
                                    create: (_) => PersonalReceptionBloc(
                                      PersonalReceptionRepositoryImpl(sl()),
                                    ),
                                  ),
                                  BlocProvider<DirectoryBloc>(
                                    create: (_) => sl(),
                                  ),
                                ],
                                child: PersonalReceptionSubLevel(
                                  id: organId,
                                  selectedProsecutorOffice:
                                      selectedProsecutorOffice,
                                ),
                              );
                            },
                          )).then((v) {
                            if (v != null) {
                              setState(() {
                                selectedPersenId =
                                    v['position_code_v2'].toString();
                                selectedPerson = v as Map;
                              });
                            }
                          });
                        },
                        items: organ,
                        value: selectedProsecutorOffice,
                      ),

                      // procuror info
                      if (selectedPerson != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: CustomTextBox(
                            text:
                                "${selectedPerson?['last_name_rus'] ?? "-"} ${selectedPerson?['first_name_rus'] ?? "-"} ${selectedPerson?['middle_name_rus'] ?? "-"}"
                                " (${selectedPerson?['position_name_rus'] ?? "-"})",
                            color: ColorStyles.lightBlueColor,
                            fontSize: 14,
                            maxLines: null,
                            overflow: null,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 13),
                            borderRadius: 10,
                          ),
                        ),

                      // question type
                      ChoosableList(
                        hintText: LocaleKeys.questiontype.tr(context: context),
                        onChanged: (RegionModel? value) {
                          setState(() {
                            selectedQuestionType = value;
                          });
                          characterId = value?.id ?? 0;
                        },
                        items: character,
                        value: selectedQuestionType,
                      ),
                      const SizedBox(height: 5),

                      // date & time
                      Row(
                        children: [
                          Expanded(
                            child: CustomDatePicker(
                              callback: onNoticeDate,
                              selected: _noticeDate.isEmpty
                                  ? LocaleKeys.datePicker.tr(context: context)
                                  : _noticeDate,
                              expanded: false,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: CustomTimePicker(
                              callback: onNoticeTime,
                              selected: _noticeTime.isEmpty
                                  ? LocaleKeys.timePicker.tr(context: context)
                                  : _noticeTime,
                              expanded: false,
                              startTime: const TimeOfDay(
                                hour: 9,
                                minute: 0,
                              ),
                              endTime: const TimeOfDay(
                                hour: 18,
                                minute: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // description
                      CustomTextField(
                        controller: _descriptionController,
                        maxLines: 4,
                        hintStyle: montserattTitle14,
                        hintText: LocaleKeys.description.tr(context: context),
                        fillColor: Colors.white,
                        borderColor:
                            ColorStyles.lightBlueColor.withValues(alpha: 0.2),
                        enableBorderColor:
                            ColorStyles.lightBlueColor.withValues(alpha: 0.2),
                      ),
                      const SizedBox(height: 40),

                      // buttons
                      BlocBuilder<PersonalReceptionBloc,
                          PersonalReceptionState>(
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: state is PersonalReceptionLoading
                                ? null
                                : () {
                                    String t = _noticeTime;
                                    if (int.parse(t.split(':')[0]) < 10) {
                                      t = '0$t';
                                    }
                                    context.read<PersonalReceptionBloc>().add(
                                          PersonalReceptionSubmit(
                                            date:
                                                "${_noticeDate.substring(0, 10)} $t",
                                            description:
                                                _descriptionController.text,
                                            region: regionId,
                                            organ: organId,
                                            character: characterId,
                                            selectedEmployee: selectedPersenId,
                                          ),
                                        );
                                  },
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ColorStyles.lightBlueColor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Text(
                                state is PersonalReceptionLoading
                                    ? "Загрузка..."
                                    : LocaleKeys.signreception
                                        .tr(context: context),
                                style: customListTextTitle.copyWith(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BottomNavBar(index: 0),
                            ),
                          );
                        },
                        child: Text(
                          LocaleKeys.cancel.tr(context: context),
                          style: montserattTitle12.copyWith(
                            color: Colors.black.withValues(alpha: 0.5),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

showSuccesDialog({
  required BuildContext context,
  required String title,
  required String subtitle,
  required Color color,
  bool isSpan = false,
  String spanText = '',
  Color spanTextColor = Colors.black,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffFCFCFC),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: montserattTitle14.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 3),
                    isSpan
                        ? RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: subtitle,
                              style: montserattTitle14.copyWith(
                                fontWeight: FontWeight.w400,
                                height: 1.3,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: spanText,
                                  style: montserattTitle14.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                    color: spanTextColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: montserattTitle14.copyWith(
                              fontWeight: FontWeight.w400,
                              height: 1.3,
                              color: Colors.black,
                            ),
                          ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
