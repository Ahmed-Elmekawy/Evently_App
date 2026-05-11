import 'package:equatable/equatable.dart';

import '../../../../../create_event/data/models/event_model.dart';

abstract class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<EventModel> events;

  const FavouriteLoaded(this.events);

  @override
  List<Object> get props => [events];
}

class FavouriteError extends FavouriteState {
  final String message;

  const FavouriteError(this.message);

  @override
  List<Object> get props => [message];
}
