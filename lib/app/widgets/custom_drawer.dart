import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:vrsoftware/app/views/assignments/assignment_student.dart';
import 'package:vrsoftware/app/views/assignments/index.dart';
import 'package:vrsoftware/app/views/pages/student_page.dart';
import 'package:vrsoftware/app/views/pages/subject_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.deepPurple,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(
                  Icons.school,
                  size: 72,
                  color: Colors.white,
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  SizedBox(
                    height: 36,
                  ),
                  buildMenuItem(
                      text: "Cursos",
                      icon: Icons.book,
                      onClicked: () {
                        return selectedItem(context, 0);
                      }),
                  buildMenuItem(
                      text: "Alunos",
                      icon: Icons.face,
                      onClicked: () {
                        return selectedItem(context, 1);
                      }),
                  buildMenuItem(
                      text: "Matrícula",
                      icon: Icons.assignment,
                      onClicked: () {
                        return selectedItem(context, 2);
                      }),
                  buildMenuItem(
                      text: "Gerenciar Matrículas",
                      icon: Icons.settings,
                      onClicked: () {
                        return selectedItem(context, 3);
                      })
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubjectPage(),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => StudentPage(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AssignmentStudent(),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AssignmentIndex(),
        ));
        break;
    }
  }
}
