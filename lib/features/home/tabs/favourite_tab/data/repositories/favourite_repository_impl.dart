import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import '../sources/favourite_remote_data_source.dart';
import 'favourite_repository.dart';

class FavouriteRepositoryImpl implements FavouriteRepository {
  final FavouriteRemoteDataSource remoteDataSource;

  FavouriteRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addEventToFavourite(
    EventModel event,
    UserModel user,
  ) async {
    try {
      await remoteDataSource.addEventToFavourite(event, user);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeEventFromFavourite(
    EventModel event,
    UserModel user,
  ) async {
    try {
      await remoteDataSource.removeEventFromFavourite(event, user);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getFavouriteEvents(
    UserModel user,
  ) async {
    try {
      final events = await remoteDataSource.getFavouriteEvents(user);
      return Right(events);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
