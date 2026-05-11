import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';

abstract class FavouriteRepository {
  Future<Either<Failure, void>> addEventToFavourite(EventModel event, UserModel user);
  Future<Either<Failure, void>> removeEventFromFavourite(EventModel event, UserModel user);
  Future<Either<Failure, List<EventModel>>> getFavouriteEvents(UserModel user);
}
