import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Subject.dart';

class SubjectEdit extends StatelessWidget {
  String? subjectDescription;
  String? subjectMenu;  
  String? subjectId;

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _menuController = TextEditingController();
  SubjectEdit({Key? key, this.subjectDescription,  this.subjectMenu, this.subjectId}) : super(key: key);


  
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _descriptionController,
                          keyboardType: TextInputType.text,
                          maxLength: 50,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                              labelText: "Nome do curso",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.book)),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Informe o nome do curso!";
                            }
                          },
                        ),
                        SizedBox(height: 32,),
                        TextFormField(
                          controller: _menuController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                              labelText: "Ementa",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              prefixIcon: Icon(Icons.description)),
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return "Informe a ementa!";
                            }
                          },
                        ),
                      ],
                    )),
                ),
                SizedBox(
                  height: 16,
                ),
                FloatingActionButton.extended(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Subject subject = Subject(description: _descriptionController.text, menu: _menuController.text, id: subjectId);
                      _descriptionController.text = "";
                      _menuController.text = "";

                      final response = await subject.update();
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
    _descriptionController.text = this.subjectDescription.toString();
    _menuController.text = this.subjectMenu.toString();
  }
}