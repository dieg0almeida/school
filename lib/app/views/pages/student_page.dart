import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Student.dart';
import 'package:vrsoftware/app/views/students/create.dart';
import 'package:vrsoftware/app/views/students/index.dart';
import 'package:vrsoftware/app/views/students/search.dart';
import 'package:vrsoftware/app/widgets/custom_drawer.dart';
import 'package:vrsoftware/app/widgets/refresh_buttom.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentName = TextEditingController();
  final _searchController = TextEditingController();
  

  final _student = Student();

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Alunos"),
          centerTitle: true,
          actions: [refreshButton(() {
            setState(() {
              
            });
          })],
          bottom: TabBar(tabs: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Cadasto"),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Listagem"),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Busca"),
            )
          ]),
        ),
        body: TabBarView(children: [
          CreateStudent(),
          StudentIndex(),
          StudentSearch()
        ]),
        drawer: CustomDrawer(),
      ),
    );
  }
}
