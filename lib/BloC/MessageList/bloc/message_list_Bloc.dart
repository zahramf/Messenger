import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/Repository/MessageRepository.dart';

part 'message_list_Event.dart';
part 'message_list_State.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  final MessageRepository messageRepository;

  MessageListBloc(this.messageRepository) : super(MessageListStateInitial());

  @override
  Stream<MessageListState> mapEventToState(
    MessageListEvent event,
  ) async* {
    if (event is MessageListEvantRecive) {
      yield MessageListReciveStateInProgress();

      var result = new List();

      result = await messageRepository.recive(page: event.page);

      if (result != null) {
        yield MessageListReciveStateComplete(result);
      }
    }

    if (event is MessageListEventaSend) {
      yield MessageListSendStateInProgress();
      var result = new List();

      result = await messageRepository.sent(page: event.page);

      if (result != null) {
        yield MessageListSendStateComplete(result);
      }
    }
  }
}
