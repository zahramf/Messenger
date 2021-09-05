import 'package:equatable/equatable.dart';
import 'package:messenger/Model/Attache.dart';
import 'package:messenger/Model/Receiver.dart';

import 'Sender.dart';

// ignore: must_be_immutable
class InboxModel extends Equatable {
  int mailId;
  String title;
  String text;
  bool isSeen;
  DateTime date;
  Sender sender;
  Sender send = new Sender();
  List<Receivers> receivers;
  List<Attache> attaches;

  InboxModel(
      {this.mailId,
      this.title,
      this.isSeen,
      this.date,
      this.sender,
      this.send,
      this.text,
      this.attaches,
      this.receivers});

  InboxModel.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    title = json['title'];
    text = json['text'] != null ? json['text'] : "";
    isSeen =
        json["isSeen"] != null ? (json['isSeen'] == 1 ? true : false) : false;
    // json['isSeen'];
    date = DateTime.parse(json['date'].toString());
    if (json['attaches'] != null) {
      // ignore: deprecated_member_use
      attaches = new List<Attache>();
      json['attaches'].forEach((v) {
        attaches.add(new Attache.fromJson(v));
      });
    }

    if (json['receivers'] != null) {
      // ignore: deprecated_member_use
      receivers = new List<Receivers>();
      json['receivers'].forEach((v) {
        receivers.add(new Receivers.fromJson(v));
      });
    }

    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['title'] = this.title;
    data['isSeen'] = this.isSeen;
    if (this.receivers != null) {
      data['receivers'] = this.receivers.map((v) => v.toJson()).toList();
    }

    data['date'] = this.date;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mailId, title, date, sender];
}
