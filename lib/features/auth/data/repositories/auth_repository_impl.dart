import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';
import 'package:evently_app/features/auth/data/repositories/auth_repository.dart';
import 'package:evently_app/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserModel>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await authRemoteDataSource.login(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        UserModel? user = await authRemoteDataSource.getUserFromFirStore(
          credential.user!.uid,
        );
        return Right(user!);
      }
      return const Left(ServerFailure('Login failed'));
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Authentication error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await authRemoteDataSource.register(
        email: email,
        password: password,
      );

      UserModel user = UserModel(
        id: credential.user!.uid,
        name: name,
        email: email,
        favouriteEventsIds: [],
      );
      await authRemoteDataSource.addUserToFireStore(user);
      return Right(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(ServerFailure('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(
          ServerFailure('The account already exists for that email.'),
        );
      }
      return Left(ServerFailure(e.message ?? 'Registration error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> loginWithGoogle() async {
    try {
      final credential = await authRemoteDataSource.googleLogin();
      if (credential != null && credential.user != null) {
        UserModel? user = await authRemoteDataSource.getUserFromFirStore(
          credential.user!.uid,
        );
        return Right(user!);
      }
      return const Left(ServerFailure('Google login failed'));
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? 'Google sign-in failed'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await authRemoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData(String uid) async {
    try {
      UserModel? user = await authRemoteDataSource.getUserFromFirStore(uid);
      return Right(user!);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

