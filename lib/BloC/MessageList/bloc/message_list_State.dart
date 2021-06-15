part of 'message_list_Bloc.dart';

abstract class MessageListState extends Equatable {
  const MessageListState();

  @override
  List<Object> get props => [];
}

class MessageListStateInitial extends MessageListState {}

class MessageListSendStateInProgress extends MessageListState {}

class MessageListReciveStateInProgress extends MessageListState {}

class MessageListStateErrore extends MessageListState {}

class MessageListSendStateComplete extends MessageListState {}

class MessageListReciveStateComplete extends MessageListState {}
