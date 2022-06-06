import 'package:flutter/material.dart';
import 'package:vrsoftware/app/models/Subject.dart';
import 'package:vrsoftware/app/views/subjects/edit.dart';

class SubjectSearch extends StatefulWidget {
  const SubjectSearch({Key? key}) : super(key: key);

  @override
  State<SubjectSearch> createState() => _SubjectSearchState();
}

class _SubjectSearchState extends State<SubjectSearch> {
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<dynamic> _subjects = [];
  final _subject = Subject();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                      labelText: "Pesquise pelo descriçao",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
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
            delegate: SliverChildBuilderDelegate(childCount: _subjects.length,
                (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Card(
              child: Column(children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                  child: Text(
                    "Nome do curso: ${_subjects[index]['description']}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
                  child: Text(
                    "Ementa: ${_subjects[index]['menu']}",
                    style: TextStyle(fontSize: 20, overflow: TextOverflow.fade),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubjectEdit(
                              subjectId: _subjects[index]['id'].toString(),
                              subjectDescription: _subjects[index]
                                  ['description'],
                              subjectMenu: _subjects[index]['menu']),
                        ));
                      },
                      label: Text("Editar"),
                      icon: Icon(Icons.edit),
                      backgroundColor: Colors.deepPurple,
                    ),
                    FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text("Excluir"),
                      icon: Icon(Icons.delete),
                      backgroundColor: Colors.pinkAccent.shade700,
                    )
                  ],
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
    );
  }

  _search(String name) async {
    _subjects.clear();
    _subjects = await _subject.findByName(name);
    setState(() {
      _subjects;
    });
  }
}
