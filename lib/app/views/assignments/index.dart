import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Assignment.dart';
import 'package:vrsoftware/app/views/students/edit.dart';
import 'package:vrsoftware/app/widgets/custom_drawer.dart';
import 'package:vrsoftware/app/widgets/refresh_buttom.dart';

class AssignmentIndex extends StatefulWidget {
  const AssignmentIndex({Key? key}) : super(key: key);

  @override
  State<AssignmentIndex> createState() => _AssignmentIndexState();
}

class _AssignmentIndexState extends State<AssignmentIndex> {
  final _assignment = Assigment();
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          refreshButton((){
            setState(() {
              
            });
          })
        ],
        title: Text("Matrículas"),
      ),
      body: FutureBuilder<List>(
          future: _assignment.all(),
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
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 16, bottom: 16),
                            child: Text(
                              "Aluno: ${list[index]['student_name']}",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 16, bottom: 16),
                            child: Text(
                              "Curso: ${list[index]['subject_description']}",
                              style: TextStyle(
                                  fontSize: 20, overflow: TextOverflow.fade),
                            ),
                          ),
                          FloatingActionButton.extended(
                            onPressed: () {
                              _confimartionDialog(
                                list[index]['id'].toString()
                              );
                            },
                            label: Text("Desmatricular"),
                            icon: Icon(Icons.delete_forever),
                            backgroundColor: Colors.deepPurple,
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
          }),
          drawer: CustomDrawer(),
    );
  }

  _confimartionDialog(String assignmentId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Deseja mesmo desmatricular o aluno do curso?"),
            actions: [
              FlatButton(
                  child: Text(
                    "Sim",
                    style: TextStyle(color: Colors.green),
                  ),
                  onPressed: () async {
                    final response = await _assignment.delete(assignmentId);
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
