import 'package:mobx/mobx.dart';
import 'package:todo/app/models/todo_model.dart';
import 'package:todo/app/models/user_model.dart';
import 'package:todo/app/modules/todo/todo_service.dart';

part 'todo_controller.g.dart';

class TodoController = _TodoBase with _$TodoController;

abstract class _TodoBase with Store {
  final service = TodoService();

  @observable
  Set<TodoModel> todos;

  @observable
  int uTasks = 0;

  @observable
  UserModel user;

  @observable
  bool isLoading = false;

  @action
  Future<void> getData() async {
    isLoading = true;
    try {
      todos = (await service.getTasks()).toSet();
      user = await service.getUser();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> createTask(String des) async {
    isLoading = true;
    try {
      await service.createTask(des);
      todos = (await service.getTasks()).toSet();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> completeTask(int id) async {
    isLoading = true;
    try {
      await service.completeTask(id);
      todos = (await service.getTasks()).toSet();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> deleteTask(int id) async {
    isLoading = true;
    try {
      await service.deleteTask(id);
      todos = (await service.getTasks()).toSet();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> updateTask(String des, int id) async {
    isLoading = true;
    try {
      await service.updateTask(des, id);
      todos = (await service.getTasks()).toSet();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  @computed
  bool get isData => todos != null && user != null;

  @computed
  List<TodoModel> get todosList {
    List<TodoModel> uList = [];
    List<TodoModel> cList = [];
    var list = todos.toList();
    if (list.isNotEmpty) {
      for (int i = 0; i < list.length; i++) {
        if (list[i].completedAt == null)
          uList.add(list[i]);
        else
          cList.add(list[i]);
      }

      uList.sort((a, b) {
        return b.createdAt.compareTo(a.createdAt);
      });
      cList.sort((a, b) {
        return b.completedAt.compareTo(a.completedAt);
      });
    }
    uTasks = uList.length;
    // list.reversed can also be used instead of sorting
    return uList + cList;
  }
}
