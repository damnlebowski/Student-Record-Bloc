part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class AddStudent extends HomeEvent {
  final StudentModel model;

  AddStudent({required this.model});
}

class DeleteStudent extends HomeEvent {
  final int index;

  DeleteStudent({required this.index});
}

class EditStudent extends HomeEvent {
  final int index;
  final StudentModel model;

  EditStudent({required this.index, required this.model});
}
