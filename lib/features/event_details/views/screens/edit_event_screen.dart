import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/core/constants/constants_manager.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_bloc.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_event.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_state.dart';
import '../widgets/edit_event_body.dart';

class EditEventScreen extends StatefulWidget {
  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  late AppLocalizations appLocalizations;
  late DateTime selectedDateTime;
  late TimeOfDay pickedTime;
  late CategoryModel selectedCategory;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool isInitialized = false;
  late EventModel event;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      event = ModalRoute.of(context)!.settings.arguments as EventModel;
      selectedDateTime = event.dateTime ?? DateTime.now();
      pickedTime = TimeOfDay.fromDateTime(selectedDateTime);
      selectedCategory = CategoryModel.getCategoriesWithAll(context).firstWhere(
        (c) => c.id == event.categoryId,
        orElse: () => CategoryModel.getCategoriesWithAll(context).first,
      );
      _titleController = TextEditingController(text: event.title);
      _descriptionController = TextEditingController(text: event.description);
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
    appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations.update_event)),
      body: BlocListener<EventDetailsBloc, EventDetailsState>(
        listener: (context, state) {
          if (state is EventDetailsLoading) {
            DialogUtils.showLoading(context);
          } else if (state is EventUpdatedSuccess) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: appLocalizations.event_updated_successfully,
              bgColor: Colors.green,
            );
            Navigator.pop(context);
            Navigator.pop(context);
          } else if (state is EventDetailsError) {
            DialogUtils.hideDialog(context);
            DialogUtils.showToastMessage(
              message: state.message,
              bgColor: Colors.red,
            );
          }
        },
        child: EditEventBody(
          selectedCategory: selectedCategory,
          onCategoryChanged: (cat) => setState(() => selectedCategory = cat),
          titleController: _titleController,
          descriptionController: _descriptionController,
          selectedDateTime: selectedDateTime,
          onSelectDate: _selectEventData,
          onSelectTime: _chooseEventTime,
          onUpdateEvent: _updateEvent,
        ),
      ),
    );
  }

  void _updateEvent() {
    event.title = _titleController.text;
    event.description = _descriptionController.text;
    event.dateTime = selectedDateTime;
    event.categoryId = selectedCategory.id;

    context.read<EventDetailsBloc>().add(UpdateEvent(event));
  }

  void _selectEventData() async {
    selectedDateTime =
        await showDatePicker(
          context: context,
          initialDate: selectedDateTime,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
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
        await showTimePicker(context: context, initialTime: pickedTime) ??
        pickedTime;
    selectedDateTime = selectedDateTime.copyWith(
      hour: pickedTime.hour,
      minute: pickedTime.minute,
    );
    setState(() {});
  }
}
