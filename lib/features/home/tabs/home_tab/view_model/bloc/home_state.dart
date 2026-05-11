import 'package:equatable/equatable.dart';
import '../../../../../create_event/data/models/event_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<EventModel> events;

  const HomeLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
