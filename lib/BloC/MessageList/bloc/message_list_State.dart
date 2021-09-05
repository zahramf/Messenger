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

class MessageListShowSentStateMessage extends MessageListState {
  final SentModel showMessage;
  MessageListShowSentStateMessage({this.showMessage});
}

class MessageListSendStateLoad extends MessageListState {
  final List<SentModel> message;
  final bool maxItemNum;

  MessageListSendStateLoad({this.message, this.maxItemNum});
  MessageListSendStateLoad copyWith(
      {List<SentModel> message, bool maxItemNum}) {
    return MessageListSendStateLoad(
        message: message ?? this.message,
        maxItemNum: maxItemNum ?? this.maxItemNum);
  }

  @override
  List<Object> get props => [message, maxItemNum];
}

class MessageListShowReciveStateMessage extends MessageListState {
  final InboxModel showMessage;
  MessageListShowReciveStateMessage({this.showMessage});
}

class MessageListReciveStateLoad extends MessageListState {
  final List<InboxModel> message;
  //final InboxModel showMessage;
  final bool maxItemNum;

  MessageListReciveStateLoad({this.message, this.maxItemNum});
  MessageListReciveStateLoad copyWith(
      {List<InboxModel> message, bool maxItemNum}) {
    return MessageListReciveStateLoad(
        message: message ?? this.message,
        maxItemNum: maxItemNum ?? this.maxItemNum);
  }

  @override
  List<Object> get props => [message, maxItemNum];
}
