import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/db/model/student_model.dart';
import 'package:student_record_bloc/screens/screen_details.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<StudentModel> searchList =
      List<StudentModel>.from(studentListNotifier.value);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) => setState(() {
                searchList = studentListNotifier.value
                    .where((element) => element.name
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
              }),
              style: TextStyle(),
              autofocus: true,
              decoration: InputDecoration(
                  label: Text('Search'), suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return StudentDetails(
                                index: studentListNotifier.value
                                    .indexOf(searchList[index]));
                          },
                        ));
                      },
                      title: Text(searchList[index].name),
                      trailing: IconButton(
                          onPressed: () {
                            studentListNotifier.notifyListeners();
                            removeStudent(
                                studentListNotifier.value
                                    .indexOf(searchList[index]),
                                context);

                            searchList.removeAt(index);
                            setState(() {});
                          },
                          icon: Icon(Icons.delete)),
                      leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: studentListNotifier
                                      .value[index].imagepath ==
                                  'x'
                              ? AssetImage('assests/avatar.png')
                                  as ImageProvider
                              : FileImage(File(searchList[index].imagepath!))),
                    ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: searchList.length),
          )
        ],
      ),
    );
  }
}
