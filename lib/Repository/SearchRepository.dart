import 'package:flutter/material.dart';
import 'package:messenger/DataProvider/ApiProvider.dart';
import 'package:messenger/Model/InboxModel.dart';

class SearchRepository {
  final ApiProvider apiProvider;

  SearchRepository({@required this.apiProvider})
      : assert((apiProvider != null));

  Future<List<InboxModel>> search(
      {int page, String title, String user, String text}) async {
    List<InboxModel> searchMessage;

    String url = "mail/inbox?page=$page&per_page=20";

    if (title != null && title.isNotEmpty) {
      url += "&title=" + title;
    }
    if (user != null && user.isNotEmpty) {
      url += "&sender=" + user;
    }
    if (text != null && text.isNotEmpty) {
      url += "&text=" + text;
    }

    var response = await apiProvider.get(url);

    if (response.statusCode == 200 && response != null) {
      searchMessage = (response.data["data"] as List)
          .map((item) => InboxModel.fromJson(item))
          .toList();
      return searchMessage;
    }
  }
}
