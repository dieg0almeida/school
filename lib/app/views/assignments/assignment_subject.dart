import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Assignment.dart';
import 'package:vrsoftware/app/models/Subject.dart';
import 'package:vrsoftware/app/views/subjects/edit.dart';
import 'package:vrsoftware/app/widgets/custom_drawer.dart';

class AssignmentSubjet extends StatefulWidget {
  String? studentId;
  AssignmentSubjet({Key? key, required this.studentId}) : super(key: key);

  @override
  State<AssignmentSubjet> createState() => _AssignmentSubjetState();
}

class _AssignmentSubjetState extends State<AssignmentSubjet> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _subjects = [];
  final _subject = Subject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Selecione um curso"),
          centerTitle: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                margin:
                    EdgeInsets.only(top: 16, right: 16, left: 16, bottom: 32),
                child: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _searchController,
                      keyboardType: TextInputType.text,
                      maxLength: 50,
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                          labelText: "Pesquise pelo descriçao",
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: Icon(Icons.search)),
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return "Informe a descrição do curso!";
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
                delegate:
                    SliverChildBuilderDelegate(childCount: _subjects.length,
                        (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(16),
                child: Card(
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 16),
                      child: Text(
                        "Nome do curso: ${_subjects[index]['description']}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 8, right: 8, top: 16, bottom: 16),
                      child: Text(
                        "Ementa: ${_subjects[index]['menu']}",
                        style: TextStyle(
                            fontSize: 20, overflow: TextOverflow.fade),
                      ),
                    ),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        Assigment assignment = Assigment(
                            studentId: widget.studentId,
                            subjectId: _subjects[index]['id'].toString());
                        final response = await assignment.create();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            response[0],
                            style: TextStyle(fontSize: 16),
                          ),
                          duration: Duration(seconds: 3),
                          backgroundColor: Colors.green,
                        ));
                        if(!mounted) return; 
                        Navigator.of(context).pop();
                      },
                      label: Text("Matricular"),
                      icon: Icon(Icons.check),
                      backgroundColor: Colors.green.shade900,
                    ),
                    SizedBox(height: 16),
                    Visibility(
                        visible: false,
                        child: Form(
                          child: TextFormField(
                            initialValue: _subjects[index]['id'].toString(),
                          ),
                        ))
                  ]),
                ),
              );
            }))
          ],
        ));
  }

  _search(String name) async {
    _subjects.clear();
    _subjects = await _subject.findByName(name);
    setState(() {
      _subjects;
    });
  }
}
