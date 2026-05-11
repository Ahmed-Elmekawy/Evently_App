import 'package:equatable/equatable.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class CreateEventEvent extends Equatable {
  const CreateEventEvent();

  @override
  List<Object> get props => [];
}

class SubmitEvent extends CreateEventEvent {
  final EventModel event;

  const SubmitEvent(this.event);

  @override
  List<Object> get props => [event];
}

