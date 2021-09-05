import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/Repository/MessageRepository.dart';
import 'package:messenger/Widget/Tuple.dart';

part 'message_list_Event.dart';
part 'message_list_State.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  final MessageRepository messageRepository;

  MessageListBloc(this.messageRepository) : super(MessageListStateInitial());

  @override
  Stream<MessageListState> mapEventToState(
    MessageListEvent event,
  ) async* {
    final currentState = state;

    if (event is MessageListEventShowInboxMessage) {
      if (currentState is MessageListShowReciveStateMessage ||
          currentState is MessageListReciveStateLoad) {
        final result = await messageRepository.showInboxMessage(
            messageId: event.messageId);

        if (result != null) {
          yield MessageListShowReciveStateMessage(showMessage: result);
        }
      }
    }
    if (event is MessageListEventShowSentMessage) {
      if (currentState is MessageListShowSentStateMessage ||
          currentState is MessageListStateInitial ||
          currentState is MessageListSendStateLoad) {
        final result =
            await messageRepository.showSendMessage(messageId: event.messageId);

        if (result != null) {
          yield MessageListShowSentStateMessage(showMessage: result);
        }
      }
    }

    if (event is MessageListEvantRecive) {
      if (currentState is MessageListStateInitial ||
          currentState is MessageListSendStateLoad ||
          currentState is MessageListShowReciveStateMessage) {
        final result = await messageRepository.recive(page: event.page);

        if (result.a != null && result.b == false) {
          yield MessageListReciveStateLoad(
              message: result.a, maxItemNum: false);
        } else if (result.b == true) {
          yield MessageListStateErrore();
        }
      }

      if (currentState is MessageListReciveStateLoad) {
        final result = await messageRepository.recive(page: event.page);

        if (result.a.isEmpty) {
          yield currentState.copyWith(maxItemNum: true);

          //Snack Bar Show
        } else if (result.a != null && result.b == false) {
          yield MessageListReciveStateLoad(
              message: currentState.message + result.a, maxItemNum: false);
        } else if (result.b == true) {
          yield MessageListStateErrore();
        }
      }
    }

    if (event is MessageListEventaSend) {
      if (currentState is MessageListStateInitial ||
          currentState is MessageListReciveStateLoad ||
          currentState is MessageListShowSentStateMessage) {
        final result = await messageRepository.sent(page: event.page);

        if (result.a != null && result.b == false) {
          yield MessageListSendStateLoad(message: result.a, maxItemNum: false);
        } else if (result.b == true) {
          yield MessageListStateErrore();
        }
      }
      if (currentState is MessageListSendStateLoad) {
        final result = await messageRepository.sent(page: event.page);

        if (result.a.isEmpty) {
          yield currentState.copyWith(maxItemNum: true);

          //Snack Bar Show
        } else if (result.a != null && result.b == false) {
          yield MessageListSendStateLoad(
              message: currentState.message + result.a, maxItemNum: false);
        }
      }
    }
  }
}
