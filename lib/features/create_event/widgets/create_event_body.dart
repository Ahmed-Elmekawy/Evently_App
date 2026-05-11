import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/constants_manager.dart';
import '../../../../core/widgets/category_selector.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/ex/date_ex.dart';
import 'date_time_row.dart';
import 'event_form_fields.dart';

class CreateEventBody extends StatelessWidget {
  final CategoryModel selectedCategory;
  final Function(CategoryModel) onCategoryChanged;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final DateTime selectedDateTime;
  final VoidCallback onSelectDate;
  final VoidCallback onSelectTime;
  final VoidCallback onAddEvent;

  const CreateEventBody({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.titleController,
    required this.descriptionController,
    required this.selectedDateTime,
    required this.onSelectDate,
    required this.onSelectTime,
    required this.onAddEvent,
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
            icon: Icons.date_range_outlined,
            label: selectedDateTime.getFormattedDate(context),
            buttonTitle: appLocalizations.choose_date,
            onTap: onSelectDate,
          ),
          SizedBox(height: 20.h),
          DateTimeRow(
            icon: Icons.access_time,
            label: selectedDateTime.getFormattedTime(context),
            buttonTitle: appLocalizations.choose_time,
            onTap: onSelectTime,
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            title: appLocalizations.add_event,
            onClick: onAddEvent,
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
