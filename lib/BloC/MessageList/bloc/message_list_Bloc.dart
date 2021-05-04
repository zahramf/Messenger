import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_list_Event.dart';
part 'message_list_State.dart';

class MessageListBloc extends Bloc<MessageListEvent, MessageListState> {
  MessageListBloc() : super(MessageListInitial());

  @override
  Stream<MessageListState> mapEventToState(
    MessageListEvent event,
  ) async* {}
}
