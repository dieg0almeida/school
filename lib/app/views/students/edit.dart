import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Student.dart';

class StudentEdit extends StatelessWidget {
  String? studentName;  
  String? studentId;

  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  StudentEdit({Key? key, this.studentName,  this.studentId}) : super(key: key);


  
  @override
  Widget build(BuildContext context) {

    _setTextFormField();

    return Scaffold(
      body: Center(
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
                      controller: _studentNameController,
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
                      Student student = Student(name: _studentNameController.text, id: studentId);
                      _studentNameController.text = "";

                      final response = await student.update();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          response![0],
                          style: TextStyle(fontSize: 16),
                        ),
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      ));
                    }
                    Navigator.of(context).pop();
                  },
                  label: Text(
                    "Editar",
                    style: TextStyle(fontSize: 18),
                  ),
                  icon: Icon(Icons.edit),
                  backgroundColor: Colors.deepPurple,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  _setTextFormField(){
    _studentNameController.text = this.studentName.toString();
  }
}