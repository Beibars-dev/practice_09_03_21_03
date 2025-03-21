import 'package:chat_bot_project/core/common/custom_appbar.dart';
import 'package:chat_bot_project/core/styles/colors.dart';
import 'package:chat_bot_project/features/screens/personal_reception/screens/personal_list.dart';
import 'package:chat_bot_project/lang/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/styles/textStyles.dart';

class OpenPersonalReception extends StatelessWidget {
  final data;
  final String updatedAppointedDateString;

  OpenPersonalReception({
    required this.data,
    required this.updatedAppointedDateString,
  });

  final userBox = Hive.box('name');
  final surBox = Hive.box('surname');

  @override
  Widget build(BuildContext context) {
    var status = AppealStatusHelper.getStatus(data['temp_appeal_status']);
    String userName = userBox.get('fnm').toString();
    String surname = surBox.get('lstnm').toString();

    return Scaffold(
      backgroundColor: ColorStyles.backgroundColor,
      appBar: CustomAppBar(
        title:
            '${LocaleKeys.personalreceptionnav.tr(context: context)} №${data['id']}',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffFCFCFC),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
              child: Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorStyles.lightBlueColor.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${userName[0]}${surname[0]}',
                      style: montserattTitle14.copyWith(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '$surname $userName',
                    style: montserattTitle14.copyWith(
                      color: ColorStyles.lightBlueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffFCFCFC),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSubText(
                    title: 'Номер',
                    subtitle: data['id'],
                  ),
                  _buildSubText(
                    title: LocaleKeys.region.tr(context: context),
                    subtitle: data['organization_name'],
                  ),
                  _buildSubText(
                    title: LocaleKeys.questiontype.tr(context: context),
                    subtitle: data['type_of_question'],
                  ),
                  _buildSubText(
                    title: LocaleKeys.datewrite.tr(context: context),
                    subtitle: updatedAppointedDateString,
                  ),
                  _buildSubText(
                    title: LocaleKeys.description.tr(context: context),
                    subtitle: data['description'],
                  ),
                  _buildSubText(
                    title:
                        LocaleKeys.responsibleForReception.tr(context: context),
                    subtitle: data['executor_emp_full_name'],
                  ),
                  _buildSubText(
                    title: LocaleKeys.datecreate.tr(context: context),
                    subtitle: data['start_date'],
                  ),
                  _buildSubText(
                    title: LocaleKeys.status.tr(context: context),
                    subtitle: data['temp_appeal_status'],
                    subtitleColor: AppealStatusHelper.textColors[status],
                    isPadding: false,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column _buildSubText({
    required String title,
    required subtitle,
    Color? subtitleColor = Colors.black,
    bool isPadding = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title:',
          style: montserattTitle12.copyWith(
            color: Colors.black.withValues(alpha: 0.5),
          ),
        ),
        Text(
          subtitle.toString(),
          style: montserattTitle14.copyWith(
            fontWeight: FontWeight.w600,
            color: subtitleColor,
          ),
        ),
        if (isPadding) const SizedBox(height: 10),
      ],
    );
  }
}
