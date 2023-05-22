import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_record_bloc/bloc/search/search_bloc.dart';
import 'package:student_record_bloc/db/functions/db_functions.dart';
import 'package:student_record_bloc/screens/screen_details.dart';

class Search extends StatelessWidget {
  Search({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    log('main builder call', time: DateTime.now());
    BlocProvider.of<SearchBloc>(context)
        .add(OnSearch(allStudents: studentList, value: ''));
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              onChanged: (value) => BlocProvider.of<SearchBloc>(context)
                  .add(OnSearch(allStudents: studentList, value: value)),
              style: const TextStyle(),
              autofocus: true,
              decoration: const InputDecoration(
                  label: Text('Search'), suffixIcon: Icon(Icons.search)),
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                log('bloc builder call', time: DateTime.now());

                return ListView.separated(
                    itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return StudentDetails(
                                    index: studentList
                                        .indexOf(state.searchList[index]));
                              },
                            ));
                          },
                          title: Text(state.searchList[index].name),
                          trailing: IconButton(
                              onPressed: () {
                                removeStudent(
                                    studentList
                                        .indexOf(state.searchList[index]),
                                    context);

                                state.searchList.removeAt(index);
                                BlocProvider.of<SearchBloc>(context).add(
                                    OnSearch(
                                        allStudents: studentList,
                                        value: searchController.text));
                              },
                              icon: const Icon(Icons.delete)),
                          leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  state.searchList[index].imagepath == 'x'
                                      ? const AssetImage('assests/avatar.png')
                                          as ImageProvider
                                      : FileImage(File(
                                          state.searchList[index].imagepath!))),
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.searchList.length);
              },
            ),
          )
        ],
      ),
    );
  }
}
