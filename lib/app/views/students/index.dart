import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Student.dart';
import 'package:vrsoftware/app/views/students/edit.dart';

class StudentIndex extends StatefulWidget {
  const StudentIndex({Key? key}) : super(key: key);

  @override
  State<StudentIndex> createState() => _StudentIndexState();
}

class _StudentIndexState extends State<StudentIndex> {
  final _student = Student();
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _student.all(),
        builder: (context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasError) {
            return Text("Um erro aconteceu!");
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
                itemCount: list!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(16),
                    child: Card(
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                          child: Text(
                            "${list[index]['name']}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton.extended(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => StudentEdit(
                                    studentId: list[index]['id'].toString(),
                                    studentName: list[index]['name'],
                                  ),
                                ));
                              },
                              label: Text("Editar"),
                              icon: Icon(Icons.edit),
                              backgroundColor: Colors.deepPurple,
                            ),
                            FloatingActionButton.extended(
                              onPressed: () {
                                _confimartionDialog(
                                    list[index]['id'].toString());
                              },
                              label: Text("Excluir"),
                              icon: Icon(Icons.delete),
                              backgroundColor: Colors.pinkAccent.shade700,
                            )
                          ],
                        ),
                        SizedBox(height: 16)
                      ]),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  _confimartionDialog(String studentid) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Deseja mesmo excluir o aluno?"),
            actions: [
              FlatButton(
                  child: Text(
                    "Sim",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    final response = await _student.delete(studentid);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        response![0],
                        style: TextStyle(fontSize: 20),
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.deepPurple,
                    ));
                    Navigator.of(context).pop();
                    setState(() {});
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green))),
              FlatButton(
                  child: Text(
                    "Não",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red))),
            ],
          );
        });
  }
}
