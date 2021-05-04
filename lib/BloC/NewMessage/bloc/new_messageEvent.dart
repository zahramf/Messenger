part of 'new_messageBloc.dart';

abstract class NewmessageEvent extends Equatable {
  const NewmessageEvent();

  @override
  List<Object> get props => [];
}

class NewmessageEventSend extends NewmessageEvent {
  final String receiver;
  final String subject;
  final String text;
  // final File file;

  NewmessageEventSend({this.receiver, this.subject, this.text});
}
