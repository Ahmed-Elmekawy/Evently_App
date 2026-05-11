import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/home_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc({required this.homeRepository}) : super(HomeInitial()) {
    on<FetchEvents>((event, emit) async {
      emit(HomeLoading());
      await emit.forEach(
        homeRepository.getEventsStream(event.selectedCategory),
        onData: (result) {
          return result.fold(
            (failure) => HomeError(failure.message),
            (events) => HomeLoaded(events),
          );
        },
        onError: (error, stackTrace) => HomeError(error.toString()),
      );
    });
  }
}
