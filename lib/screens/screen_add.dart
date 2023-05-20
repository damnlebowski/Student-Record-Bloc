import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_record_bloc/bloc/add_image/add_image_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';

class StudentAdd extends StatelessWidget {
  StudentAdd({super.key});

  String imagePath = 'x';

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('It cant be build more than once');
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
                  child: InkWell(
                child: BlocBuilder<AddImageBloc, AddImageState>(
                  builder: (context, state) {
                    log('It will build more than once');

                    imagePath = state.imagePath!;
                    state.imagePath = 'x';

                    return CircleAvatar(
                      radius: 75,
                      backgroundImage: imagePath == 'x'
                          ? const AssetImage('assests/avatar.png')
                              as ImageProvider
                          : FileImage(File(imagePath)),
                    );
                  },
                ),
                onTap: () {
                  takePic(context);
                },
              )),
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
                            imagepath: imagePath);
                        addStudent(model, context);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Save'))
              ],
            )
          ]),
        ),
      ),
    );
  }

  takePic(BuildContext context) async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      imagePath = imageFile.path;
      BlocProvider.of<AddImageBloc>(context)
          .add(OnImageUpdate(imagePath: imagePath));
    }
  }
}
