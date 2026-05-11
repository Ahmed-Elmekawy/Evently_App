import 'package:equatable/equatable.dart';
import 'package:evently_app/features/auth/data/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class GoogleLoginRequested extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class UpdateUserRequested extends AuthEvent {
  final UserModel user;

  const UpdateUserRequested(this.user);

  @override
  List<Object> get props => [user];
}
