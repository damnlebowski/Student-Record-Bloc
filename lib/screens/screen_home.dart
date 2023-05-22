import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/home/home_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/screens/screen_add.dart';
import 'package:student_record_bloc/screens/screen_details.dart';
import 'package:student_record_bloc/screens/screen_search.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Search();
                  },
                ));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return StudentAdd();
            },
          ));
        },
        child: const Icon(Icons.person_add),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return StudentDetails(index: index);
                        },
                      ));
                    },
                    title: Text(state.modelList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('do you want to delete'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        removeStudent(index, context);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Yes'))
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.delete)),
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: studentList[index].imagepath == 'x'
                            ? const AssetImage('assests/avatar.png')
                                as ImageProvider
                            : FileImage(File(studentList[index].imagepath!))),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.modelList.length),
          )),
    );
  }
}
