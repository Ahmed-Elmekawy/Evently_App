import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/widgets/event_item.dart';
import '../../../../../auth/data/models/user_model.dart';
import '../../../../../create_event/data/models/event_model.dart';

class FavouriteList extends StatelessWidget {
  final List<EventModel> events;
  final UserModel? user;

  const FavouriteList({super.key, required this.events, required this.user});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) =>
            EventItem(event: events[index], markAsFavourite: true, user: user),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: events.length,
      ),
    );
  }
}
