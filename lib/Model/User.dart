class User {
  int userId;
  String username;
  String fullname;
  String lastname;
  String pathCover;
  int deputyId;
  int partId;
  int postId;
  Deputy deputy;
  Part part;
  Post post;

  User(
      {this.userId,
      this.username,
      this.fullname,
      this.lastname,
      this.pathCover,
      this.deputyId,
      this.partId,
      this.postId,
      this.deputy,
      this.part,
      this.post});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    fullname = json['fullname'] != null ? json['fullname'] : "";
    lastname = json['lastname'];
    pathCover = json['pathCover'] != null ? json['pathCover'] : null;
    deputyId = json['deputy_id'];
    partId = json['part_id'];
    postId = json['post_id'];
    deputy =
        json['deputy'] != null ? new Deputy.fromJson(json['deputy']) : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['fullname'] = this.fullname;

    data['lastname'] = this.lastname;
    data['pathCover'] = this.pathCover;
    data['deputy_id'] = this.deputyId;
    data['part_id'] = this.partId;
    data['post_id'] = this.postId;
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
