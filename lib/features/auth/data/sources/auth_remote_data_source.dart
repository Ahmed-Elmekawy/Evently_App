import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/constants/constants_manager.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> register({
    required String email,
    required String password,
  });
  Future<UserCredential> login({
    required String email,
    required String password,
  });
  Future<UserCredential?> googleLogin();
  Future<void> logout();
  Future<void> addUserToFireStore(UserModel user);
  Future<UserModel?> getUserFromFirStore(String uid);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.firestore,
  });

  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<UserCredential?> googleLogin() async {
    googleSignIn.initialize(
      serverClientId:
          "80611561466-66prffspq0b7fm3g3k7bmt4o4jsblqi2.apps.googleusercontent.com",
    );
    final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    return await firebaseAuth.signInWithCredential(credential);
  }

  @override
  Future<void> logout() async {
    await googleSignIn.signOut();
    await firebaseAuth.signOut();
  }

  CollectionReference<UserModel> _getUsersCollection() {
    return firestore
        .collection(RemoteConstant.userCollection)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
  }

  @override
  Future<void> addUserToFireStore(UserModel user) async {
    final usersCollection = _getUsersCollection();
    final userDocument = usersCollection.doc(user.id);
    await userDocument.set(user);
  }

  @override
  Future<UserModel?> getUserFromFirStore(String uid) async {
    final usersCollection = _getUsersCollection();
    final userDocument = usersCollection.doc(uid);
    final snapshot = await userDocument.get();
    return snapshot.data();
  }
}

