import 'package:evently_app/core/ex/date_ex.dart';
import 'package:evently_app/core/utils/routes_manager.dart';
import 'package:evently_app/core/di/injection_container.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/home/tabs/favourite_tab/data/repositories/favourite_repository.dart';
import '../../features/home/tabs/favourite_tab/view_model/bloc/favourite_bloc.dart';
import '../../features/home/tabs/favourite_tab/view_model/bloc/favourite_event.dart';
import '../constants/constants_manager.dart';

class EventItem extends StatefulWidget {
  const EventItem({
    super.key,
    required this.event,
    required this.markAsFavourite,
    required this.user,
  });
  final EventModel event;
  final bool markAsFavourite;
  final UserModel? user;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  late bool favourite = widget.markAsFavourite;

  @override
  void didUpdateWidget(covariant EventItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.markAsFavourite != widget.markAsFavourite) {
      favourite = widget.markAsFavourite;
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.event.category ??= CategoryModel.getCategoriesWithAll(context)
        .firstWhere(
          (c) => c.id == widget.event.categoryId,
          orElse: () => CategoryModel.getCategoriesWithAll(context).first,
        );

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutesManager.eventDetails,
          arguments: widget.event,
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(widget.event.category!.image),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: REdgeInsets.all(8),
              child: Padding(
                padding: REdgeInsets.all(8.0),
                child: Text(
                  widget.event.dateTime!.getMonth(context),
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
            SizedBox(height: 97.h),
            Card(
              margin: REdgeInsets.all(8),
              child: Padding(
                padding: REdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.event.title ?? "",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      onPressed: _markEventAsFavourite,
                      icon: Icon(
                        favourite ? Icons.favorite : Icons.favorite_border,
                        color: favourite ? Colors.red : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _markEventAsFavourite() async {
    if (widget.user == null) return;
    final favouriteRepository = sl<FavouriteRepository>();

    final newUserIds = List<String>.from(widget.user!.favouriteEventsIds);
    bool isAdding = !favourite;

    if (isAdding) {
      if (!newUserIds.contains(widget.event.id)) {
        newUserIds.add(widget.event.id!);
      }
    } else {
      newUserIds.remove(widget.event.id);
    }

    final updatedUser = widget.user!.copyWith(favouriteEventsIds: newUserIds);

    setState(() {
      favourite = isAdding;
    });

    context.read<AuthBloc>().add(UpdateUserRequested(updatedUser));

    if (isAdding) {
      await favouriteRepository.addEventToFavourite(widget.event, widget.user!);
    } else {
      await favouriteRepository.removeEventFromFavourite(widget.event, widget.user!);
    }

    if (mounted) {
      try {
        context.read<FavouriteBloc>().add(FetchFavourites(updatedUser));
      } catch (_) {}
    }
  }
}
