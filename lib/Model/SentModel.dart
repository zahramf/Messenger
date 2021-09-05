import 'Attache.dart';
import 'Deputy.dart';
import 'Part.dart';
import 'Post.dart';
import 'Receiver.dart';
import 'Sender.dart';

class SentModel {
  int mailId;
  String title;
  DateTime date;
  String text;
  bool isSeen;
  Sender sender;
  //Sender send = new Sender();
  List<Receivers> receivers;
  List<Attache> attaches;

  SentModel(
      {this.mailId,
      this.title,
      this.date,
      this.receivers,
      this.attaches,
      this.isSeen,
      // this.send,
      this.sender,
      this.text});

  SentModel.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    title = json['title'];
    text = json['text'] != null ? json['text'] : "";
    isSeen =
        json["isSeen"] != null ? (json['isSeen'] == 1 ? true : false) : false;
    date = DateTime.parse(json['date'].toString());
    if (json['receivers'] != null) {
      // ignore: deprecated_member_use
      receivers = new List<Receivers>();
      json['receivers'].forEach((v) {
        receivers.add(new Receivers.fromJson(v));
      });
    }
    if (json['attaches'] != null) {
      // ignore: deprecated_member_use
      attaches = new List<Attache>();
      json['attaches'].forEach((v) {
        attaches.add(new Attache.fromJson(v));
      });
    }

    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['title'] = this.title;
    data['date'] = this.date;
    data['isSeen'] = this.isSeen;

    if (this.receivers != null) {
      data['receivers'] = this.receivers.map((v) => v.toJson()).toList();
    }
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }

  @override
  // TODO: implement props
  List<Object> get props => [mailId, title, date, sender];
}

class User {
  int userId;
  String fullname;
  String lastname;
  int deputyId;
  int partId;
  int postId;
  String pathCover;
  Deputy deputy;
  Part part;
  Post post;

  User(
      {this.userId,
      this.fullname,
      this.lastname,
      this.deputyId,
      this.partId,
      this.postId,
      this.pathCover,
      this.deputy,
      this.part,
      this.post});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullname = json['fullname'] != null ? json['fullname'] : "";
    lastname = json['lastname'];
    deputyId = json['deputy_id'];
    partId = json['part_id'];
    postId = json['post_id'];
    pathCover = json['pathCover'];
    deputy =
        json['deputy'] != null ? new Deputy.fromJson(json['deputy']) : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['fullname'] = this.fullname;
    data['lastname'] = this.lastname;
    data['deputy_id'] = this.deputyId;
    data['part_id'] = this.partId;
    data['post_id'] = this.postId;
    data['pathCover'] = this.pathCover;
    if (this.deputy != null) {
      data['deputy'] = this.deputy.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part.toJson();
    }
    if (this.post != null) {
      data['post'] = this.post.toJson();
    }
    return data;
  }
}
