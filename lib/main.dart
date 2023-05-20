import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_record_bloc/bloc/add_image/add_image_bloc.dart';
import 'package:student_record_bloc/bloc/home/home_bloc.dart';
import 'package:student_record_bloc/bloc/image/image_bloc.dart';
import 'package:student_record_bloc/db/model/student_model.dart';
import 'package:student_record_bloc/screens/screen_home.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }

  await Hive.openBox<StudentModel>('student_box');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(),
        ),
        BlocProvider(
          create: (context) => ImageBloc(),
        ),
        BlocProvider(
          create: (context) => AddImageBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
