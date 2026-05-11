import 'package:equatable/equatable.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavourites extends FavouriteEvent {
  final UserModel user;
  const FetchFavourites(this.user);

  @override
  List<Object> get props => [user];
}

class AddToFavourite extends FavouriteEvent {
  final EventModel event;
  final UserModel user;
  const AddToFavourite(this.event, this.user);

  @override
  List<Object> get props => [event, user];
}

class RemoveFromFavourite extends FavouriteEvent {
  final EventModel event;
  final UserModel user;
  const RemoveFromFavourite(this.event, this.user);

  @override
  List<Object> get props => [event, user];
}
