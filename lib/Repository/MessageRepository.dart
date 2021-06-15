import 'package:flutter/cupertino.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Model/InboxModel.dart';

class MessageRepository {
  final ApiProvider apiProvider;

  MessageRepository({@required this.apiProvider})
      : assert((apiProvider != null));

  Future<InboxModel> recive({int page = 10}) async {
    var response = await apiProvider.get("mail/inbox?page=$page");

    if (response.statusCode == 200 && response != null) {
      return InboxModel.fromJson(response.data);
    }
    return InboxModel();
  }
}
