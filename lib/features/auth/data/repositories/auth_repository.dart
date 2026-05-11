import 'package:dartz/dartz.dart';
import 'package:evently_app/core/errors/failures.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> registerWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> loginWithGoogle();

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, UserModel>> getUserData(String uid);
}

