part of 'home_bloc.dart';

class HomeState {
  final List<StudentModel> modelList;

  HomeState({required this.modelList});
}

class HomeInitial extends HomeState {
  HomeInitial({required super.modelList});
}
