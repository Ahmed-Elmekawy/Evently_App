import 'package:equatable/equatable.dart';

abstract class EventDetailsState extends Equatable {
  const EventDetailsState();

  @override
  List<Object> get props => [];
}

class EventDetailsInitial extends EventDetailsState {}

class EventDetailsLoading extends EventDetailsState {}

class EventDeletedSuccess extends EventDetailsState {}

class EventUpdatedSuccess extends EventDetailsState {}

class EventDetailsError extends EventDetailsState {
  final String message;

  const EventDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
