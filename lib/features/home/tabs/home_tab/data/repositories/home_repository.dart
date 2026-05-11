import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import '../../../../../../core/constants/constants_manager.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<EventModel>>> getEvents([
    CategoryModel? selectedCategory,
  ]);
  Stream<Either<Failure, List<EventModel>>> getEventsStream([
    CategoryModel? selectedCategory,
  ]);
}
