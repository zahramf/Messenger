part of 'searchBloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchEventSearch extends SearchEvent {
  final String title;
  final String name;
  final String text;

  SearchEventSearch({this.title, this.name, this.text});
}
