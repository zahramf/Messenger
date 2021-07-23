import 'Deputy.dart';
import 'Part.dart';
import 'Post.dart';

class SentModel {
  int mailId;
  String title;
  DateTime date;
  List<Receivers> receivers;

  SentModel({this.mailId, this.title, this.date, this.receivers});

  SentModel.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    title = json['title'];
    date = DateTime.parse(json['date'].toString());
    if (json['receivers'] != null) {
      receivers = new List<Receivers>();
      json['receivers'].forEach((v) {
        receivers.add(new Receivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['title'] = this.title;
    data['date'] = this.date;
    if (this.receivers != null) {
      data['receivers'] = this.receivers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Receivers {
  int receiverId;
  int mailId;
  int receiver;
  bool archive;
  bool bookmark;
  bool isSeen;
  bool isReplyed;
  bool isCopy;
  bool isSecretCopy;
  bool archiveSent;
  User user;

  Receivers(
      {this.receiverId,
      this.mailId,
      this.receiver,
      this.archive,
      this.bookmark,
      this.isSeen,
      this.isReplyed,
      this.isCopy,
      this.isSecretCopy,
      this.archiveSent,
      this.user});

  Receivers.fromJson(Map<String, dynamic> json) {
    receiverId = json['receiver_id'];
    mailId = json['mail_id'];
    receiver = json['receiver'];
    archive =
        json['archive'] != null ? (json['archive'] == 1 ? true : false) : false;
    bookmark = json['bookmark'] != null
        ? (json['bookmark'] == 1 ? true : false)
        : false;
    isSeen = json['isSeen'] == 1 ? true : false;
    isReplyed = json['isReplyed'] != null
        ? (json['isReplyed'] == 1 ? true : false)
        : false;
    isCopy = json['isCopy'] == 1 ? true : false;
    isSecretCopy = json['isSecretCopy'] == 1 ? true : false;
    archiveSent = json['archiveSent'] != null
        ? (json['archiveSent'] == 1 ? true : false)
        : false;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver_id'] = this.receiverId;
    data['mail_id'] = this.mailId;
    data['receiver'] = this.receiver;
    data['archive'] = this.archive;
    data['bookmark'] = this.bookmark;
    data['isSeen'] = this.isSeen;
    data['isReplyed'] = this.isReplyed;
    data['isCopy'] = this.isCopy;
    data['isSecretCopy'] = this.isSecretCopy;
    data['archiveSent'] = this.archiveSent;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
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
    fullname = json['fullname'];
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
