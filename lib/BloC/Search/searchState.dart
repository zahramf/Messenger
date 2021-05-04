part of 'searchBloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchStateInitial extends SearchState {}

class SearchStateInProgress extends SearchState {}

class SearchStateError extends SearchState {}

class SearchStateCompleted extends SearchState {}
