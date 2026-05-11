import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/event_details/data/repositories/event_details_repository.dart';
import 'package:evently_app/features/event_details/data/sources/event_details_remote_data_source.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

class EventDetailsRepositoryImpl implements EventDetailsRepository {
  final EventDetailsRemoteDataSource eventDetailsRemoteDataSource;

  EventDetailsRepositoryImpl({required this.eventDetailsRemoteDataSource});

  @override
  Future<Either<Failure, void>> deleteEvent(String id) async {
    try {
      await eventDetailsRemoteDataSource.deleteEvent(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEvent(EventModel event) async {
    try {
      await eventDetailsRemoteDataSource.updateEvent(event);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
