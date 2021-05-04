part of 'searchBloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventSearch extends SearchEvent {
  final String subject;
  final String name;
  final String word;

  SearchEventSearch({this.subject, this.name, this.word});
}
