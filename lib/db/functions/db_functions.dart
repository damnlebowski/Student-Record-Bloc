import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_bloc/bloc/home/home_bloc.dart';
import 'package:student_record_bloc/db/model/student_model.dart';

List<StudentModel> studentList = [];

addStudent(StudentModel model, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context).add(AddStudent(model: model));
  box.add(model);
}

updateStudent(int index, StudentModel model, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context)
      .add(EditStudent(index: index, model: model));
  box.putAt(index, model);
}

removeStudent(int index, BuildContext context) {
  final box = Hive.box<StudentModel>('student_box');
  BlocProvider.of<HomeBloc>(context).add(DeleteStudent(index: index));
  box.deleteAt(index);
}

getAllStudent() {
  final box = Hive.box<StudentModel>('student_box');
  studentList.clear();
  studentList.addAll(box.values);
}
