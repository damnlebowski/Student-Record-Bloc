import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record_bloc/bloc/home/home_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';

class StudentAdd extends StatefulWidget {
  StudentAdd({super.key});

  @override
  State<StudentAdd> createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {
  String imagePath = 'x';

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                  // borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: imagePath == 'x'
                      ? AssetImage('assests/avatar.png') as ImageProvider
                      : FileImage(File(imagePath)),
                ),
                onTap: () {
                  takePic();
                },
              )),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  hintText: 'Enter Your Name',
                  labelText: 'Name',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Your Age',
                  labelText: 'Age',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Enter Your Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (nameController.text.trim().isNotEmpty &&
                          ageController.text.trim().isNotEmpty &&
                          emailController.text.trim().isNotEmpty &&
                          phoneController.text.trim().isNotEmpty) {
                        StudentModel model = StudentModel(
                            name: nameController.text.trim(),
                            age: ageController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                            imagepath: imagePath);
                        addStudent(model, context);
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Save'))
              ],
            )
          ]),
        ),
      ),
    );
  }

  takePic() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        imagePath = imageFile.path;
      });
    }
  }
}
