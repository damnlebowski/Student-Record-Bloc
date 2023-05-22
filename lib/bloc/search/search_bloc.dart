import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';
part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(searchList: studentList)) {
    on<OnSearch>((event, emit) {
      emit(SearchState(
          searchList: event.allStudents
              .where((element) => element.name
                  .toLowerCase()
                  .contains(event.value.toLowerCase()))
              .toList()));
    });
  }
}
