import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently_app/features/create_event/data/repositories/create_event_repository.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_event.dart';
import 'package:evently_app/features/create_event/view_model/bloc/create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  final CreateEventRepository createEventRepository;

  CreateEventBloc({required this.createEventRepository})
    : super(CreateEventInitial()) {
    on<SubmitEvent>((event, emit) async {
      emit(CreateEventLoading());
      final result = await createEventRepository.addEvent(event.event);
      result.fold(
        (failure) => emit(CreateEventError(failure.message)),
        (_) => emit(CreateEventSuccess()),
      );
    });
  }
}

