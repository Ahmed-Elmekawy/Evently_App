import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import '../../../../../../core/constants/constants_manager.dart';
import '../sources/home_remote_data_source.dart';
import 'home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failure, List<EventModel>>> getEvents([
    CategoryModel? selectedCategory,
  ]) async {
    try {
      final events = await homeRemoteDataSource.getEventsFromFireStore(
        selectedCategory,
      );
      return Right(events);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<EventModel>>> getEventsStream([
    CategoryModel? selectedCategory,
  ]) async* {
    try {
      yield* homeRemoteDataSource
          .getEventsFromFireStoreRealTime(selectedCategory)
          .map((events) => Right<Failure, List<EventModel>>(events));
    } catch (e) {
      yield Left(ServerFailure(e.toString()));
    }
  }
}
