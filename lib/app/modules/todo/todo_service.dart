import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:todo/app/core/network/dio_client.dart';
import 'package:todo/app/core/network/api.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/models/user_model.dart';

class TodoService {
  final _client = DioClient(Api.BASE_URL, Dio());

  Future<List<TodoModel>> getTasks() async {
    final url = Api.TASKS;
    final data = await _client.get(url);
    return List<TodoModel>.from(data.map((x) => TodoModel.fromJson(x)));
  }

  Future<UserModel> getUser() async {
    final data = await _client.get(Api.ME);
    return UserModel.fromJson(data);
  }

  Future<TodoModel> createTask(String description) async {
    final data = await _client.post(Api.TASKS, data: {
      "task": {"description": description}
    });
    return TodoModel.fromJson(data);
  }

  Future<TodoModel> updateTask(String description, int id) async {
    final data = await _client.put('${Api.TASKS}/$id', data: {
      "task": {"description": description}
    });
    return TodoModel.fromJson(data);
  }

  Future<TodoModel> deleteTask(int id) async {
    final data = await _client.delete('${Api.TASKS}/$id');
    return TodoModel.fromJson(data);
  }

  Future<TodoModel> completeTask(int id) async {
    final data = await _client.put('${Api.TASKS}/$id/completed');
    return TodoModel.fromJson(data);
  }
}
