import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/screens/screen_edit.dart';

const kHight = SizedBox(height: 10);

class StudentDetails extends StatelessWidget {
  StudentDetails({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: studentList[index].imagepath == 'x'
                      ? const AssetImage('assests/avatar.png') as ImageProvider
                      : FileImage(File(studentList[index].imagepath!)),
                  radius: 80,
                ),
                const SizedBox(height: 20),
                Table(children: [
                  TableRow(children: [
                    ProfileText(data: 'Name'),
                    ProfileText(data: studentList[index].name),
                  ]),
                  TableRow(children: [
                    ProfileText(data: 'Age'),
                    ProfileText(data: studentList[index].age),
                  ]),
                  TableRow(children: [
                    ProfileText(data: 'Email'),
                    ProfileText(data: studentList[index].email),
                  ]),
                  TableRow(children: [
                    ProfileText(data: 'Phone'),
                    ProfileText(data: studentList[index].phone),
                  ]),
                ]),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
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
              return StudentUpdate(student: studentList[index], index: index);
            },
          ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}

class ProfileText extends StatelessWidget {
  ProfileText({super.key, required this.data});
  String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        data,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip),
      ),
    );
  }
}
