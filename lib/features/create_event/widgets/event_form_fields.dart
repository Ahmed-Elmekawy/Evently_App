import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../l10n/app_localizations.dart';

class EventFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const EventFormFields({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(appLocalizations.title, style: theme.textTheme.displayLarge),
        SizedBox(height: 8.h),
        CustomTextFormField(
          controller: titleController,
          hintText: appLocalizations.event_title,
        ),
        SizedBox(height: 16.h),
        Text(
          appLocalizations.description,
          style: theme.textTheme.displayLarge,
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          controller: descriptionController,
          hintText: appLocalizations.event_description,
          maxLines: 4,
        ),
      ],
    );
  }
}
