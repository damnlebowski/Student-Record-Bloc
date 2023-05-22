import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(modelList: studentList)) {
    on<AddStudent>((event, emit) {
      studentList.add(event.model);
      return emit(HomeState(modelList: studentList));
    });

    on<DeleteStudent>((event, emit) {
      studentList.removeAt(event.index);
      return emit(HomeState(modelList: studentList));
    });

    on<EditStudent>((event, emit) {
      studentList.removeAt(event.index);
      studentList.insert(event.index, event.model);
      return emit(HomeState(modelList: studentList));
    });
  }
}