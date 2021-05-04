part of 'message_list_Bloc.dart';

abstract class MessageListState extends Equatable {
  const MessageListState();

  @override
  List<Object> get props => [];
}

class MessageListInitial extends MessageListState {}
