class InboxModel {
  int mailId;
  String title;
  int isSeen;
  String date;
  Sender sender;

  InboxModel({this.mailId, this.title, this.isSeen, this.date, this.sender});

  InboxModel.fromJson(Map<String, dynamic> json) {
    mailId = json['mail_id'];
    title = json['title'];
    isSeen = json['isSeen'];
    date = json['date'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mail_id'] = this.mailId;
    data['title'] = this.title;
    data['isSeen'] = this.isSeen;
    data['date'] = this.date;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    return data;
  }
}

class Sender {
  int userId;
  String fullname;
  String lastname;
  int deputyId;
  int partId;
  int postId;
  Null pathCover;
  Deputy deputy;
  Part part;
  Post post;

  Sender(
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

  Sender.fromJson(Map<String, dynamic> json) {
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

class Deputy {
  int deputyId;
  String title;

  Deputy({this.deputyId, this.title});

  Deputy.fromJson(Map<String, dynamic> json) {
    deputyId = json['deputy_id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deputy_id'] = this.deputyId;
    data['title'] = this.title;
    return data;
  }
}

class Part {
  int partId;
  String title;
  int deputyId;

  Part({this.partId, this.title, this.deputyId});

  Part.fromJson(Map<String, dynamic> json) {
    partId = json['part_id'];
    title = json['title'];
    deputyId = json['deputy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['part_id'] = this.partId;
    data['title'] = this.title;
    data['deputy_id'] = this.deputyId;
    return data;
  }
}

class Post {
  int postId;
  String title;
  int levelId;
  int deputyId;

  Post({this.postId, this.title, this.levelId, this.deputyId});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    title = json['title'];
    levelId = json['level_id'];
    deputyId = json['deputy_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['title'] = this.title;
    data['level_id'] = this.levelId;
    data['deputy_id'] = this.deputyId;
    return data;
  }
}
