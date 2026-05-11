import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/auth/data/repositories/auth_repository.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final result = await authRepository.getUserData(currentUser.uid);
        result.fold(
          (failure) => emit(AuthInitial()),
          (user) => emit(AuthSuccess(user: user)),
        );
      } else {
        emit(AuthInitial());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepository.loginWithEmail(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepository.registerWithEmail(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<GoogleLoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await authRepository.loginWithGoogle();

      result.fold(
        (failure) => emit(AuthError(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.logout();
      emit(AuthInitial());
    });

    on<UpdateUserRequested>((event, emit) {
      emit(AuthSuccess(user: event.user));
    });
  }
}
