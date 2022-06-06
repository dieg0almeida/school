import 'package:dio/dio.dart';

class Subject{
  String? id;
  String? description;
  String? menu;

  Subject({this.id, this.description, this.menu});

  final String api = "http://10.0.2.2:5000/api/subjects";


  Future<List<dynamic>> all() async {
    final response = await Dio().get(api);
    List list = response.data['subjects'];

    return list;
  }
  

  Future<List<dynamic>> create() async {

    final response = await Dio().post(api, data: {"description": description, "menu": menu});
    print(response);
    List list = [response.data['message']];
    

    return list;
  }

  Future<List<dynamic>> findByName(String description) async {
    final response = await Dio().post("$api/search", data: {"description": description});
    print(response);
    List list = response.data['subjects'];

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
  
  @override
  findById() {
    // TODO: implement findById
    throw UnimplementedError();
  }
  
  Future<List?> update() async {
    String url = "$api/${this.id.toString()}";
    final response = await Dio().put("$api/${this.id.toString()}", data: {"description": this.description, "menu": this.menu});
    List list = [response.data['message']];
    

    return list;
  }
}