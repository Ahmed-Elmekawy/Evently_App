import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/features/auth/data/repositories/auth_repository.dart';
import 'package:evently_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:evently_app/features/auth/data/sources/auth_remote_data_source.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository_impl.dart';
import 'package:evently_app/features/create_event/data/sources/create_event_remote_data_source.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_bloc.dart';
import 'package:evently_app/features/event_details/data/repositories/event_details_repository.dart';
import 'package:evently_app/features/event_details/data/repositories/event_details_repository_impl.dart';
import 'package:evently_app/features/event_details/data/sources/event_details_remote_data_source.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../features/home/tabs/profile_tab/view_model/profile_bloc.dart';
import '../../features/home/tabs/favourite_tab/data/repositories/favourite_repository.dart';
import '../../features/home/tabs/favourite_tab/data/repositories/favourite_repository_impl.dart';
import '../../features/home/tabs/favourite_tab/data/sources/favourite_remote_data_source.dart';
import '../../features/home/tabs/favourite_tab/view_model/bloc/favourite_bloc.dart';
import '../../features/home/tabs/home_tab/data/repositories/home_repository.dart';
import '../../features/home/tabs/home_tab/data/repositories/home_repository_impl.dart';
import '../../features/home/tabs/home_tab/data/sources/home_remote_data_source.dart';
import '../../features/home/tabs/home_tab/view_model/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ─── External Dependencies ──────────────────────────────────────────────────
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn.instance);

  // ─── Auth Feature ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuth: sl(),
      googleSignIn: sl(),
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => AuthBloc(authRepository: sl()));

  // ─── Profile Feature ────────────────────────────────────────────────────────
  sl.registerLazySingleton(() => ProfileBloc());

  // ─── Home Feature ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(homeRemoteDataSource: sl()),
  );
  sl.registerFactory(() => HomeBloc(homeRepository: sl()));

  // ─── Favourite Feature ──────────────────────────────────────────────────────
  sl.registerLazySingleton<FavouriteRemoteDataSource>(
    () => FavouriteRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<FavouriteRepository>(
    () => FavouriteRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(
    () => FavouriteBloc(favouriteRepository: sl(), authBloc: sl()),
  );

  // ─── Create Event Feature ───────────────────────────────────────────────────
  sl.registerLazySingleton<CreateEventRemoteDataSource>(
    () => CreateEventRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<CreateEventRepository>(
    () => CreateEventRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerFactory(() => CreateEventBloc(createEventRepository: sl()));

  // ─── Event Details Feature ──────────────────────────────────────────────────
  sl.registerLazySingleton<EventDetailsRemoteDataSource>(
    () => EventDetailsRemoteDataSourceImpl(firestore: sl()),
  );
  sl.registerLazySingleton<EventDetailsRepository>(
    () => EventDetailsRepositoryImpl(eventDetailsRemoteDataSource: sl()),
  );
  sl.registerFactory(() => EventDetailsBloc(eventDetailsRepository: sl()));
}
