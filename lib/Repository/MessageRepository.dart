import 'package:flutter/cupertino.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SearchModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/Widget/Tuple.dart';

class MessageRepository {
  final ApiProvider apiProvider;

  MessageRepository({@required this.apiProvider})
      : assert((apiProvider != null));

  Future<Tuple<List<InboxModel>, bool>> recive({int page = 1}) async {
    List<InboxModel> message;
    // String url = "mail/inbox?page=$page&per_page=20";

    //  if (searchModel != null) {

    //}

    var response = await apiProvider.get("mail/inbox?page=$page&per_page=20");

    if (response.statusCode == 200 && response != null) {
      message = (response.data["data"] as List)
          .map((item) => InboxModel.fromJson(item))
          .toList();
      return Tuple<List<InboxModel>, bool>(message, false);
    } else {
      return Tuple<List<InboxModel>, bool>(null, true);
    }
    // Errore;
  }

  Future<Tuple<List<SentModel>, bool>> sent({int page = 1}) async {
    page = 1;
    List<SentModel> message;
    var response = await apiProvider.get("mail/sent?page=$page");

    if (response.statusCode == 200 && response != null) {
      message = (response.data["data"] as List)
          .map((item) => SentModel.fromJson(item))
          .toList();
      return Tuple<List<SentModel>, bool>(message, false);
    } else
    // if (response.statusCode != 200)
    {
      //statusErrore = true;
      return Tuple<List<SentModel>, bool>(null, true);
    }
  }

  Future<InboxModel> showInboxMessage({int messageId}) async {
    var response = await apiProvider.get("mail/$messageId/show");
    if (response.statusCode == 200 && response != null) {
      return InboxModel.fromJson(response.data);

      // return InboxModel.fromJson(response.data);
    }
  }

  Future<SentModel> showSendMessage({int messageId}) async {
    var response = await apiProvider.get("mail/$messageId/sent");
    if (response.statusCode == 200 && response != null) {
      return SentModel.fromJson(response.data);

      // return InboxModel.fromJson(response.data);
    }
  }
}
