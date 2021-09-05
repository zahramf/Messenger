part of 'message_list_Bloc.dart';

abstract class MessageListEvent extends Equatable {
  const MessageListEvent();

  @override
  List<Object> get props => [];
}

class MessageListEventShowInboxMessage extends MessageListEvent {
  final int messageId;
  MessageListEventShowInboxMessage({@required this.messageId});
}

class MessageListEvantRecive extends MessageListEvent {
  final int page;

  MessageListEvantRecive({@required this.page});

  @override
  List<Object> get props => [page];
}

class MessageListEventShowSentMessage extends MessageListEvent {
  final int messageId;
  MessageListEventShowSentMessage({@required this.messageId});
}

class MessageListEventaSend extends MessageListEvent {
  final int page;

  MessageListEventaSend({@required this.page});

  @override
  List<Object> get props => [page];
}
