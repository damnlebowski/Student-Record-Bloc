part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnSearch extends SearchEvent {
  final List<StudentModel> allStudents;
  final String value;

  OnSearch({required this.allStudents, required this.value});
}
