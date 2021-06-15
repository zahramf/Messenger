import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/Model/InboxModel.dart';
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

      InboxModel result;

      result = await messageRepository.recive(page: 10);

      if (result != null) {
        yield MessageListReciveStateComplete();
      }
    }
  }
}
