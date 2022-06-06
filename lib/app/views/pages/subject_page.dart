import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Subject.dart';
import 'package:vrsoftware/app/views/students/create.dart';
import 'package:vrsoftware/app/views/students/index.dart';
import 'package:vrsoftware/app/views/students/search.dart';
import 'package:vrsoftware/app/views/subjects/create.dart';
import 'package:vrsoftware/app/views/subjects/index.dart';
import 'package:vrsoftware/app/views/subjects/search.dart';
import 'package:vrsoftware/app/widgets/custom_drawer.dart';
import 'package:vrsoftware/app/widgets/refresh_buttom.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({Key? key}) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentName = TextEditingController();
  final _searchController = TextEditingController();
  

  final _student = Subject();

  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cursos"),
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
          CreateSubject(),
          SubjectIndex(),
          SubjectSearch()
        ]),
        drawer: CustomDrawer(),
      ),
    );
  }
}
