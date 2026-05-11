import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class EventDetailsRepository {
  Future<Either<Failure, void>> deleteEvent(String id);
  Future<Either<Failure, void>> updateEvent(EventModel event);
}

