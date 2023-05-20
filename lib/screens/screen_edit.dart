import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record_bloc/bloc/image/image_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';
import 'package:student_record_bloc/screens/screen_home.dart';

class StudentUpdate extends StatelessWidget {
  StudentUpdate({super.key, required this.student, required this.index});
  StudentModel student;
  int index;

  String tempImgView = '';

  late TextEditingController nameController =
      TextEditingController(text: student.name);

  late TextEditingController ageController =
      TextEditingController(text: student.age);

  late TextEditingController emailController =
      TextEditingController(text: student.email);

  late TextEditingController phoneController =
      TextEditingController(text: student.phone);

  @override
  Widget build(BuildContext context) {
    // print('tempImgView => $tempImgView');

    tempImgView = studentListNotifier.value[index].imagepath!;
    // print('tempImgView => $tempImgView');

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                updatePic(context);
              },
              child: BlocBuilder<ImageBloc, ImageState>(
                builder: (context, state) {
                  tempImgView = (tempImgView != student.imagepath
                      ? state.imgPath
                      : tempImgView)!;
                  return CircleAvatar(
                      radius: 75,
                      backgroundImage: tempImgView == 'x'
                          ? const AssetImage('assests/avatar.png')
                              as ImageProvider
                          : FileImage(File(tempImgView)));
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Name',
                  labelText: 'Name',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: ageController,
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Age',
                  labelText: 'Age',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Email',
                  labelText: 'Email',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Enter Your Phone Number',
                  labelText: 'Phone',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      tempImgView = '';
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                const SizedBox(
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
                          imagepath: tempImgView);

                      updateStudent(index, model, context);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                          (route) => false);
                    }
                  },
                  child: const Text('Update'),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  updatePic(BuildContext context) async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      // setState(() {
      tempImgView = imageFile.path;
      // print('tempImgView => $tempImgView');
      BlocProvider.of<ImageBloc>(context)
          .add(OnImageChange(imgPath: tempImgView));
      // });
    }
  }
}
