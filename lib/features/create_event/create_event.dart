import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/category_selector.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_bloc.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_event.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_state.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import 'widgets/date_time_row.dart';
import 'widgets/event_form_fields.dart';

import '../../core/constants/constants_manager.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late AppLocalizations appLocalizations;
  DateTime selectedDateTime = DateTime.now();
  TimeOfDay pickedTime = TimeOfDay.now();
  late CategoryModel selectedCategory;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      appLocalizations = AppLocalizations.of(context)!;
      selectedCategory = CategoryModel.getCategories(context)[0];
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
      isInitialized = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.add_event)),
      body: BlocListener<CreateEventBloc, CreateEventState>(
        listener: (context, state) {
          if (state is CreateEventLoading) {
            DialogUtils.showLoading(context);
          } else if (state is CreateEventSuccess) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: appLocalizations.event_created_successfully,
              bgColor: Colors.green,
            );
            Navigator.pop(context);
          } else if (state is CreateEventError) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: state.message,
              bgColor: Colors.red,
            );
          }
        },
        child: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CategorySelector(
                selectedCategory: selectedCategory,
                onCategoryChanged: (newCategory) {
                  setState(() {
                    selectedCategory = newCategory;
                  });
                },
              ),
              SizedBox(height: 16.h),
              EventFormFields(
                titleController: _titleController,
                descriptionController: _descriptionController,
              ),
              SizedBox(height: 16.h),
              DateTimeRow(
                icon: Icons.date_range_outlined,
                label: selectedDateTime.getFormattedDate(context),
                buttonTitle: appLocalizations.choose_date,
                onTap: _selectEventData,
              ),
              SizedBox(height: 20.h),
              DateTimeRow(
                icon: Icons.access_time,
                label: selectedDateTime.getFormattedTime(context),
                buttonTitle: appLocalizations.choose_time,
                onTap: _chooseEventTime,
              ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                title: appLocalizations.add_event,
                onClick: _addEvent,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  void _addEvent() {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      EventModel event = EventModel(
        ownerId: authState.user.id,
        id: "",
        categoryId: selectedCategory.id,
        title: _titleController.text,
        description: _descriptionController.text,
        dateTime: selectedDateTime,
      );
      context.read<CreateEventBloc>().add(SubmitEvent(event));
    }
  }

  void _selectEventData() async {
    selectedDateTime =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        ) ??
        selectedDateTime;
    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );
    setState(() {});
  }

  void _chooseEventTime() async {
    pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        pickedTime;
    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );
    setState(() {});
  }
}
