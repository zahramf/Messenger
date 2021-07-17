part of 'message_list_Bloc.dart';

abstract class MessageListEvent extends Equatable {
  const MessageListEvent();

  @override
  List<Object> get props => [];
}

class MessageListEvantRecive extends MessageListEvent {
  final int page;

  MessageListEvantRecive({this.page = 1});
}

class MessageListEventaSend extends MessageListEvent {
  final int page;

  MessageListEventaSend({this.page = 1});
}
