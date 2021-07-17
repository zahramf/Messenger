import 'package:flutter/cupertino.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SentModel.dart';

class MessageRepository {
  final ApiProvider apiProvider;

  MessageRepository({@required this.apiProvider})
      : assert((apiProvider != null));

  Future<List<InboxModel>> recive({int page = 1}) async {
    page = 1;
    List<InboxModel> message;
    var response = await apiProvider.get("mail/inbox?page=$page");

    if (response.statusCode == 200 && response != null) {
      message = (response.data["data"] as List)
          .map((item) => InboxModel.fromJson(item))
          .toList();
      return message;
      // return InboxModel.fromJson(response.data);
    }
    return message;
  }

  Future<List<SentModel>> sent({int page = 1}) async {
    page = 1;
    List<SentModel> message;
    var response = await apiProvider.get("mail/sent?page=$page");

    if (response.statusCode == 200 && response != null) {
      message = (response.data["data"] as List)
          .map((item) => SentModel.fromJson(item))
          .toList();
      return message;
    }
    return message;
  }
}
