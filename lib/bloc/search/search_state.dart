part of 'search_bloc.dart';

class SearchState {
  final List<StudentModel> searchList;

  SearchState({required this.searchList});
}

class SearchInitial extends SearchState {
  SearchInitial({required super.searchList});
}
