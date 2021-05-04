part of 'new_messageBloc.dart';

abstract class NewmessageState extends Equatable {
  const NewmessageState();

  @override
  List<Object> get props => [];
}

class NewmessageInitial extends NewmessageState {}

class NewmessageInProgress extends NewmessageState {}

class NewmessageError extends NewmessageState {}

class NewmessageCompleted extends NewmessageState {}
