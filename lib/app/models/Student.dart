import 'package:dio/dio.dart';

class Student {
  String? id;
  String? name;

  Student({this.id, this.name});

  final String api = "http://10.0.2.2:5000/api/students";

  Future<List<dynamic>> all() async {
    final response = await Dio().get(api);
    List list = response.data['students'];

    return list;
  }

  Future<List<dynamic>> create() async {
    final response = await Dio().post(api, data: {"name": name});
    List list = [response.data['message']];
    

    return list;
  }

  Future<List<dynamic>> findByName(String name) async {
    final response = await Dio().post("$api/search", data: {"name": name});
    print(response);
    List list = response.data['students'];

    print(list);
    return list;
  }

  Future<List?> delete(String? id) async {
    String url = "$api/$id";
    print(url);
    final response = await Dio().delete(url);
    List list = [response.data['message']];

    return list;
  }


  Future<List?> findById() {
    // TODO: implement findById
    throw UnimplementedError();
  }

  Future<List?> update() async {
    String url = "$api/${this.id.toString()}";
    final response = await Dio().put("$api/${this.id.toString()}", data: {"name": this.name});
    List list = [response.data['message']];
    

    return list;
  }
}
