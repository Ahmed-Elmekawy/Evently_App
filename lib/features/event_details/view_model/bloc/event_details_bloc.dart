import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/event_details/data/repositories/event_details_repository.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_event.dart';
import 'package:evently_app/features/event_details/view_model/bloc/event_details_state.dart';

class EventDetailsBloc extends Bloc<EventDetailsEvent, EventDetailsState> {
  final EventDetailsRepository eventDetailsRepository;

  EventDetailsBloc({required this.eventDetailsRepository})
    : super(EventDetailsInitial()) {
    on<DeleteEvent>((event, emit) async {
      emit(EventDetailsLoading());
      final result = await eventDetailsRepository.deleteEvent(event.eventId);
      result.fold(
        (failure) => emit(EventDetailsError(failure.message)),
        (_) => emit(EventDeletedSuccess()),
      );
    });

    on<UpdateEvent>((event, emit) async {
      emit(EventDetailsLoading());
      final result = await eventDetailsRepository.updateEvent(event.event);
      result.fold(
        (failure) => emit(EventDetailsError(failure.message)),
        (_) => emit(EventUpdatedSuccess()),
      );
    });
  }
}

