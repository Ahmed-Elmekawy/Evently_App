import 'package:equatable/equatable.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class EventDetailsEvent extends Equatable {
  const EventDetailsEvent();

  @override
  List<Object> get props => [];
}

class DeleteEvent extends EventDetailsEvent {
  final String eventId;

  const DeleteEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class UpdateEvent extends EventDetailsEvent {
  final EventModel event;

  const UpdateEvent(this.event);

  @override
  List<Object> get props => [event];
}

