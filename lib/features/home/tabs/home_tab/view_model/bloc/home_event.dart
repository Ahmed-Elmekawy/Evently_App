import 'package:equatable/equatable.dart';
import '../../../../../../core/constants/constants_manager.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchEvents extends HomeEvent {
  final CategoryModel? selectedCategory;

  const FetchEvents({this.selectedCategory});

  @override
  List<Object?> get props => [selectedCategory];
}
