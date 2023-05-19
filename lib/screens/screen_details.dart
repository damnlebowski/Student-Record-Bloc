import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/screens/screen_edit.dart';

class StudentDetails extends StatelessWidget {
  StudentDetails({super.key, required int this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      studentListNotifier.value[index].imagepath == 'x'
                          ? AssetImage('assests/avatar.png') as ImageProvider
                          : FileImage(
                              File(studentListNotifier.value[index].imagepath!)),
                  radius: 80,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Name:              ${studentListNotifier.value[index].name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Age:                ${studentListNotifier.value[index].age}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email:              ${studentListNotifier.value[index].email}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone:              ${studentListNotifier.value[index].phone}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return StudentUpdate(
                  student: studentListNotifier.value[index], index: index);
            },
          ));
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
