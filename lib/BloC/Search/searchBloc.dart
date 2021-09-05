import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:messenger/Model/InboxModel.dart';
import 'package:messenger/Model/SentModel.dart';
import 'package:messenger/Repository/MessageRepository.dart';
import 'package:messenger/Repository/SearchRepository.dart';

part 'searchEvent.dart';
part 'searchState.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;
  SearchBloc() : super(SearchStateInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchEventSearch) {
      yield SearchStateInProgress();

      final result = await searchRepository.search(
          title: event.title, user: event.name, text: event.text);

      if (result == null) {
        print("object");
      }

      if (result != null) {
        yield SearchStateCompleted(searchMessage: result);
      }
//send request
      yield SearchStateCompleted();
    }
  }
}
