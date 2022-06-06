import 'package:dio/dio.dart';


class Assigment{
  String? studentId;
  String? subjectId;

  Assigment({this.studentId, this.subjectId});

  final String api = "http://10.0.2.2:5000/api/assignments";
  
  Future<List<dynamic>> all() async {
    final response = await Dio().get(api);
    List list = response.data['assignments'];

    return list;
  }
  
  Future<List<dynamic>> create() async {
    final response = await Dio().post(api, data: {"student_id": studentId, "subject_id": subjectId});
    List list = [response.data['message']];
    

    return list;
  }
  

  delete(String? assignment_id) async{
    String url = "$api/$assignment_id";
    print(url);
    final response = await Dio().delete(url);
    List list = [response.data['message']];

    return list;
  }

  
}