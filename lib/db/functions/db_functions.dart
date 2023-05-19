import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_bloc/bloc/home/home_bloc.dart';
import 'package:student_record_bloc/db/model/student_model.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

addStudent(StudentModel model, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context).add(AddStudent(model: model));
  // studentListNotifier.value.add(model);
  box.add(model);
  // studentListNotifier.notifyListeners();
}

updateStudent(int index, StudentModel model, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context)
      .add(EditStudent(index: index, model: model));
  // studentListNotifier.value.removeAt(index);
  // studentListNotifier.value.insert(index, model);
  box.putAt(index, model);
  studentListNotifier.notifyListeners();
}

removeStudent(int index, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context).add(DeleteStudent(index: index));
  // studentListNotifier.value.removeAt(index);
  box.deleteAt(index);
  // studentListNotifier.notifyListeners();
}

getAllStudent() {
  final box = Hive.box<StudentModel>('student_box');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(box.values);
}
