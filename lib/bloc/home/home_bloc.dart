import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(modelList: studentListNotifier.value)) {
    on<AddStudent>((event, emit) {
      studentListNotifier.value.add(event.model);
      return emit(HomeState(modelList: studentListNotifier.value));
    });

    on<DeleteStudent>((event, emit) {
      studentListNotifier.value.removeAt(event.index);
      return emit(HomeState(modelList: studentListNotifier.value));
    });

    
    on<EditStudent>((event, emit) {
      studentListNotifier.value.removeAt(event.index);
      studentListNotifier.value.insert(event.index, event.model);
      return emit(HomeState(modelList: studentListNotifier.value));
    });
  }
}
