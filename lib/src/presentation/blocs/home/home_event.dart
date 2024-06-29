import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class GetMoreBooks extends HomeEvent {
  const GetMoreBooks();

  @override
  List<Object> get props => [];
}
