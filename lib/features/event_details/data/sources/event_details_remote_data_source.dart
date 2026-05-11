import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import '../../../../core/constants/constants_manager.dart';

abstract class EventDetailsRemoteDataSource {
  Future<void> deleteEvent(String id);
  Future<void> updateEvent(EventModel event);
}

class EventDetailsRemoteDataSourceImpl implements EventDetailsRemoteDataSource {
  final FirebaseFirestore firestore;

  EventDetailsRemoteDataSourceImpl({required this.firestore});

  CollectionReference<EventModel> _getEventsCollection() {
    return firestore
        .collection(RemoteConstant.eventsCollection)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) => EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  @override
  Future<void> deleteEvent(String id) async {
    final eventsCollection = _getEventsCollection();
    await eventsCollection.doc(id).delete();
  }

  @override
  Future<void> updateEvent(EventModel event) async {
    final eventsCollection = _getEventsCollection();
    await eventsCollection.doc(event.id).set(event);
  }
}
