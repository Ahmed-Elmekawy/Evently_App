import 'package:evently_app/features/create_event/data/models/event_model.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_bloc.dart';
import 'package:evently_app/features/auth/view_model/bloc/auth_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/favourite_repository.dart';
import 'favourite_event.dart';
import 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteRepository favouriteRepository;
  final AuthBloc authBloc;

  FavouriteBloc({required this.favouriteRepository, required this.authBloc})
    : super(FavouriteInitial()) {
    on<FetchFavourites>((event, emit) async {
      emit(FavouriteLoading());
      final result = await favouriteRepository.getFavouriteEvents(event.user);
      result.fold(
        (failure) => emit(FavouriteError(failure.message)),
        (events) => emit(FavouriteLoaded(events)),
      );
    });

    on<AddToFavourite>((event, emit) async {
      final newUserIds = List<String>.from(event.user.favouriteEventsIds);
      if (!newUserIds.contains(event.event.id)) {
        newUserIds.add(event.event.id!);
      }
      final updatedUser = event.user.copyWith(favouriteEventsIds: newUserIds);
      authBloc.add(UpdateUserRequested(updatedUser));

      final result = await favouriteRepository.addEventToFavourite(
        event.event,
        event.user,
      );
      result.fold(
        (failure) {
          authBloc.add(UpdateUserRequested(event.user));
          emit(FavouriteError(failure.message));
        },
        (_) {
          if (state is FavouriteLoaded) {
            add(FetchFavourites(updatedUser));
          }
        },
      );
    });

    on<RemoveFromFavourite>((event, emit) async {
      final newUserIds = List<String>.from(event.user.favouriteEventsIds);
      newUserIds.remove(event.event.id);
      final updatedUser = event.user.copyWith(favouriteEventsIds: newUserIds);
      authBloc.add(UpdateUserRequested(updatedUser));

      final result = await favouriteRepository.removeEventFromFavourite(
        event.event,
        event.user,
      );
      result.fold(
        (failure) {
          authBloc.add(UpdateUserRequested(event.user));
          emit(FavouriteError(failure.message));
        },
        (_) {
          if (state is FavouriteLoaded) {
            final currentEvents = List<EventModel>.from(
              (state as FavouriteLoaded).events,
            );
            currentEvents.removeWhere((e) => e.id == event.event.id);
            emit(FavouriteLoaded(currentEvents));
          }
        },
      );
    });
  }
}
