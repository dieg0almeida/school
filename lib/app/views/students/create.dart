import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Student.dart';
class CreateStudent extends StatefulWidget {
  const CreateStudent({Key? key}) : super(key: key);

  @override
  State<CreateStudent> createState() => _CreateStudentState();
}

class _CreateStudentState extends State<CreateStudent> {
  final _formKey = GlobalKey<FormState>();
  final _studentName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                    child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _studentName,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                              labelText: "Nome do aluno",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.face)),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Informe o nome do aluno!";
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Student student = Student(name: _studentName.text);
                          _studentName.text = "";

                          final response = await student.create();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              response[0],
                              style: TextStyle(fontSize: 16),
                            ),
                            duration: Duration(seconds: 3),
                            backgroundColor: Colors.green,
                          ));
                        }
                      },
                      label: Text(
                        "Cadastrar",
                        style: TextStyle(fontSize: 18),
                      ),
                      icon: Icon(Icons.add),
                    )
                  ],
                ))
              ],
            ),
          );
  }
}