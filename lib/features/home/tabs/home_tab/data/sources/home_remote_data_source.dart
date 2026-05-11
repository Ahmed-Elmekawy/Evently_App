import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import '../../../../../../core/constants/constants_manager.dart';

abstract class HomeRemoteDataSource {
  Future<List<EventModel>> getEventsFromFireStore([
    CategoryModel? selectedCategory,
  ]);
  Stream<List<EventModel>> getEventsFromFireStoreRealTime([
    CategoryModel? selectedCategory,
  ]);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;

  HomeRemoteDataSourceImpl({required this.firestore});

  CollectionReference<EventModel> _getEventsCollection() {
    return firestore
        .collection(RemoteConstant.eventsCollection)
        .withConverter<EventModel>(
          fromFirestore: (snapshot, _) =>
              EventModel.fromJson(snapshot.data()!),
          toFirestore: (event, _) => event.toJson(),
        );
  }

  @override
  Future<List<EventModel>> getEventsFromFireStore([
    CategoryModel? selectedCategory,
  ]) async {
    final eventsCollection = _getEventsCollection();
    var query = eventsCollection.orderBy("dateTime");

    if (selectedCategory != null && selectedCategory.id != '0') {
      query = query.where("categoryId", isEqualTo: selectedCategory.id);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((documentSnapshot) => documentSnapshot.data())
        .toList();
  }

  @override
  Stream<List<EventModel>> getEventsFromFireStoreRealTime([
    CategoryModel? selectedCategory,
  ]) async* {
    final eventsCollection = _getEventsCollection();
    var query = eventsCollection.orderBy("dateTime");

    if (selectedCategory != null && selectedCategory.id != '0') {
      query = query.where("categoryId", isEqualTo: selectedCategory.id);
    }

    yield* query.snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((documentSnapshot) => documentSnapshot.data())
              .toList(),
        );
  }
}
