import 'dart:io';

import 'package:flutter/material.dart';
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
        title: Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return Search();
                  },
                ));
              },
              icon: Icon(Icons.search))
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
        child: Icon(Icons.person_add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
          valueListenable: studentListNotifier,
          builder: (context, gettingStudendList, child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return StudentDetails(index: index);
                        },
                      ));
                    },
                    title: Text(gettingStudendList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('do you want to delete'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        // removeStudent(index);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        removeStudent(index);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Yes'))
                                ],
                              );
                            },
                          );
                        },
                        icon: Icon(Icons.delete)),
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: studentListNotifier
                                    .value[index].imagepath ==
                                'x'
                            ? AssetImage('assests/avatar.png') as ImageProvider
                            : FileImage(File(
                                studentListNotifier.value[index].imagepath!))),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: gettingStudendList.length);
          },
        ),
      ),
    );
  }
}
