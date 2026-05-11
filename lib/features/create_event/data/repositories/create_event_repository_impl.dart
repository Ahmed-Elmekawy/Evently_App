import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository.dart';
import 'package:evently_app/features/create_event/data/sources/create_event_remote_data_source.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';

class CreateEventRepositoryImpl implements CreateEventRepository {
  final CreateEventRemoteDataSource remoteDataSource;

  CreateEventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addEvent(EventModel event) async {
    try {
      await remoteDataSource.addEventToFireStore(event);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
