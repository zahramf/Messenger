import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'new_messageEvent.dart';
part 'new_messageState.dart';

class NewmessageBloc extends Bloc<NewmessageEvent, NewmessageState> {
  NewmessageBloc() : super(NewmessageInitial());

  @override
  Stream<NewmessageState> mapEventToState(
    NewmessageEvent event,
  ) async* {
    if (event is NewmessageEventSend) {
      yield NewmessageInProgress();
//send request
      yield NewmessageCompleted();
    }
  }
}
