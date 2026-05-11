import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';

import '../../../../../../core/constants/constants_manager.dart';

abstract class FavouriteRemoteDataSource {
  Future<void> addEventToFavourite(EventModel event, UserModel user);
  Future<void> removeEventFromFavourite(EventModel event, UserModel user);
  Future<List<EventModel>> getFavouriteEvents(UserModel user);
}

class FavouriteRemoteDataSourceImpl implements FavouriteRemoteDataSource {
  final FirebaseFirestore firestore;

  FavouriteRemoteDataSourceImpl({required this.firestore});

  CollectionReference<UserModel> _getUsersCollection() {
    return firestore
        .collection(RemoteConstant.userCollection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

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
  Future<void> addEventToFavourite(EventModel event, UserModel user) async {
    if (!user.favouriteEventsIds.contains(event.id)) {
      user.favouriteEventsIds.add(event.id!);
    }
    final usersCollection = _getUsersCollection();
    final userDocument = usersCollection.doc(user.id);
    await userDocument.set(user);
  }

  @override
  Future<void> removeEventFromFavourite(EventModel event, UserModel user) async {
    user.favouriteEventsIds.remove(event.id);
    final usersCollection = _getUsersCollection();
    final userDocument = usersCollection.doc(user.id);
    await userDocument.set(user);
  }

  @override
  Future<List<EventModel>> getFavouriteEvents(UserModel user) async {
    if (user.favouriteEventsIds.isEmpty) return [];
    final eventsCollection = _getEventsCollection();
    final snapshot = await eventsCollection.get();
    final allEvents = snapshot.docs.map((doc) => doc.data()).toList();
    
    return allEvents
        .where((event) => user.favouriteEventsIds.contains(event.id))
        .toList();
  }
}
