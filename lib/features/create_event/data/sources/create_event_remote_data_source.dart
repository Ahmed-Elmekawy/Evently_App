import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import '../../../../core/constants/constants_manager.dart';

abstract class CreateEventRemoteDataSource {
  Future<void> addEventToFireStore(EventModel event);
}

class CreateEventRemoteDataSourceImpl implements CreateEventRemoteDataSource {
  final FirebaseFirestore firestore;

  CreateEventRemoteDataSourceImpl({required this.firestore});

  CollectionReference<EventModel> _getEventsCollection() {
    return firestore
        .collection(RemoteConstant.eventsCollection)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  @override
  Future<void> addEventToFireStore(EventModel event) async {
    final eventsCollection = _getEventsCollection();
    final eventDocument = eventsCollection.doc();
    event.id = eventDocument.id;
    await eventDocument.set(event);
  }
}
