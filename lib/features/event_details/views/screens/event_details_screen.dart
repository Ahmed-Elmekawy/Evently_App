import 'package:evently_app/core/constants/constants_manager.dart';
import 'package:evently_app/core/utils/colors_manager.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/core/ui_utils/dialog_utils.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_bloc.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_event.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_state.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';
import '../widgets/action_icon_button.dart';
import '../widgets/event_details_item.dart';
import '../widgets/event_description.dart';

class EventDetailsScreen extends StatelessWidget {
  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context)!;
    var event = ModalRoute.of(context)!.settings.arguments as EventModel;
    final category = CategoryModel.getCategoriesWithAll(context).firstWhere(
      (c) => c.id == event.categoryId,
      orElse: () => CategoryModel.getCategoriesWithAll(context).first,
    );

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        UserModel? user;
        if (authState is AuthSuccess) {
          user = authState.user;
        }
        bool isOwner = event.ownerId == user?.id;
        return BlocListener<EventDetailsBloc, EventDetailsState>(
          listener: (context, state) {
            if (state is EventDetailsLoading) {
              DialogUtils.showLoading(context);
            } else if (state is EventDeletedSuccess) {
              DialogUtils.hideDialog(context);
              DialogUtils.showToastMessage(
                message: appLocalizations.event_deleted_successfully,
                bgColor: Colors.green,
              );
              Navigator.pop(context);
            } else if (state is EventDetailsError) {
              DialogUtils.hideDialog(context);
              DialogUtils.showToastMessage(
                message: state.message,
                bgColor: Colors.red,
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(appLocalizations.event_details),
              actions: isOwner
                  ? [
                      ActionIconButton(
                        icon: Icons.edit_outlined,
                        color: theme.iconTheme.color ?? ColorsManager.blue,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RoutesManager.editEvent,
                            arguments: event,
                          );
                        },
                      ),
                      SizedBox(width: 8.w),
                      ActionIconButton(
                        icon: Icons.delete_outline,
                        color: Colors.red,
                        onTap: () {
                          context.read<EventDetailsBloc>().add(
                                DeleteEvent(event.id!),
                              );
                        },
                      ),
                      SizedBox(width: 16.w),
                    ]
                  : null,
            ),
            body: SingleChildScrollView(
              padding: REdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.asset(
                      category.image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(event.title ?? "", style: theme.textTheme.displayMedium),
                  SizedBox(height: 16.h),
                  EventDetailsItem(
                    icon: Icons.calendar_month,
                    title: event.dateTime != null
                        ? event.dateTime!.getMonth(context)
                        : "",
                    subtitle: event.dateTime != null
                        ? event.dateTime!.getFormattedTime(context)
                        : "",
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    appLocalizations.description,
                    style: theme.textTheme.headlineMedium,
                  ),
                  SizedBox(height: 8.h),
                  EventDescription(description: event.description ?? ""),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

