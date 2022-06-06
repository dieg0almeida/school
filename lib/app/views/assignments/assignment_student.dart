import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Student.dart';
import 'package:vrsoftware/app/views/assignments/assignment_subject.dart';
import 'package:vrsoftware/app/widgets/custom_drawer.dart';

class AssignmentStudent extends StatefulWidget {
  const AssignmentStudent({Key? key}) : super(key: key);

  @override
  State<AssignmentStudent> createState() => _AssignmentStudentState();
}

class _AssignmentStudentState extends State<AssignmentStudent> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _students = [];
  final _student = Student();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selecione um aluno"),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
              child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.text,
                    maxLength: 50,
                    style: TextStyle(fontSize: 24),
                    decoration: InputDecoration(
                        labelText: "Pesquise pelo nome",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        prefixIcon: Icon(Icons.search)),
                    validator: (value) {
                      if (value != null && value.isEmpty) {
                        return "Informe o nome do aluno!";
                      }
                    },
                    onEditingComplete: () {
                      if (_formKey.currentState!.validate()) {
                        _search(_searchController.text);
                      }
                    },
                  )),
            )
          ])),
          SliverList(
              delegate: SliverChildBuilderDelegate(childCount: _students.length,
                  (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Card(
                child: Column(children: [
                  SizedBox(height: 16),
                  Text(
                    _students[index]['name'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AssignmentSubjet(studentId: _students[index]['id'].toString()),
                              ));
                    },
                    label: Text("Selecionar"),
                    icon: Icon(Icons.check),
                    backgroundColor: Colors.green.shade900,
                  ),
                  SizedBox(height: 16),
                  Visibility(
                      visible: false,
                      child: Form(
                        child: TextFormField(
                          initialValue: _students[index]['id'].toString(),
                        ),
                      ))
                ]),
              ),
            );
          }))
        ],
      ),
      drawer: CustomDrawer(),
    );
  }

  _search(String name) async {
    _students.clear();
    _students = await _student.findByName(name);
    setState(() {
      _students;
    });
  }
}
