import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

abstract class CreateEventRepository {
  Future<Either<Failure, void>> addEvent(EventModel event);
}

