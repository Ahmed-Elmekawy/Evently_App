import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/constants_manager.dart';
import '../../../../core/widgets/category_selector.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/ex/date_ex.dart';
import '../../../create_event/widgets/date_time_row.dart';
import '../../../create_event/widgets/event_form_fields.dart';

class EditEventBody extends StatelessWidget {
  final CategoryModel selectedCategory;
  final Function(CategoryModel) onCategoryChanged;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime selectedDateTime;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;
  final VoidCallback onUpdateEvent;

  const EditEventBody({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.titleController,
    required this.descriptionController,
    required this.selectedDateTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.onUpdateEvent,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: REdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CategorySelector(
            selectedCategory: selectedCategory,
            onCategoryChanged: onCategoryChanged,
          ),
          SizedBox(height: 16.h),
          EventFormFields(
            titleController: titleController,
            descriptionController: descriptionController,
          ),
          SizedBox(height: 16.h),
          DateTimeRow(
            icon: Icons.calendar_month_outlined,
            label: appLocalizations.event_date,
            buttonTitle: selectedDateTime.getFormattedDate(context),
            onTap: onSelectDate,
          ),
          SizedBox(height: 20.h),
          DateTimeRow(
            icon: Icons.access_time,
            label: appLocalizations.event_time,
            buttonTitle: selectedDateTime.getFormattedTime(context),
            onTap: onSelectTime,
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            title: appLocalizations.update_event,
            onClick: onUpdateEvent,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
