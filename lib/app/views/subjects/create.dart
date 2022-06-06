import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Subject.dart';

class CreateSubject extends StatefulWidget {
  const CreateSubject({Key? key}) : super(key: key);

  @override
  State<CreateSubject> createState() => _CreateSubjectState();
}

class _CreateSubjectState extends State<CreateSubject> {
  final _formKey = GlobalKey<FormState>();
  final _subjectDescription = TextEditingController();
  final _subjectMenu = TextEditingController();
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
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _subjectDescription,
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
                          controller: _subjectMenu,
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
                    Subject subject = Subject(description: _subjectDescription.text, menu: _subjectMenu.text);
                    _subjectDescription.text = "";
                    _subjectMenu.text = "";

                    final response = await subject.create();
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
