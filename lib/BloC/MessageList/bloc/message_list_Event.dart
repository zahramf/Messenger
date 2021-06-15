part of 'message_list_Bloc.dart';

abstract class MessageListEvent extends Equatable {
  const MessageListEvent();

  @override
  List<Object> get props => [];
}

class MessageListEvantRecive extends MessageListEvent {}

class MessageListEventaSend extends MessageListEvent {}
