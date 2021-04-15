// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TodoController on _TodoBase, Store {
  Computed<bool> _$isDataComputed;

  @override
  bool get isData => (_$isDataComputed ??=
          Computed<bool>(() => super.isData, name: '_TodoBase.isData'))
      .value;
  Computed<List<TodoModel>> _$todosListComputed;

  @override
  List<TodoModel> get todosList =>
      (_$todosListComputed ??= Computed<List<TodoModel>>(() => super.todosList,
              name: '_TodoBase.todosList'))
          .value;

  final _$todosAtom = Atom(name: '_TodoBase.todos');

  @override
  Set<TodoModel> get todos {
    _$todosAtom.reportRead();
    return super.todos;
  }

  @override
  set todos(Set<TodoModel> value) {
    _$todosAtom.reportWrite(value, super.todos, () {
      super.todos = value;
    });
  }

  final _$uTasksAtom = Atom(name: '_TodoBase.uTasks');

  @override
  int get uTasks {
    _$uTasksAtom.reportRead();
    return super.uTasks;
  }

  @override
  set uTasks(int value) {
    _$uTasksAtom.reportWrite(value, super.uTasks, () {
      super.uTasks = value;
    });
  }

  final _$userAtom = Atom(name: '_TodoBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_TodoBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getDataAsyncAction = AsyncAction('_TodoBase.getData');

  @override
  Future<void> getData() {
    return _$getDataAsyncAction.run(() => super.getData());
  }

  final _$createTaskAsyncAction = AsyncAction('_TodoBase.createTask');

  @override
  Future<void> createTask(String des) {
    return _$createTaskAsyncAction.run(() => super.createTask(des));
  }

  final _$completeTaskAsyncAction = AsyncAction('_TodoBase.completeTask');

  @override
  Future<void> completeTask(int id) {
    return _$completeTaskAsyncAction.run(() => super.completeTask(id));
  }

  final _$deleteTaskAsyncAction = AsyncAction('_TodoBase.deleteTask');

  @override
  Future<void> deleteTask(int id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  final _$updateTaskAsyncAction = AsyncAction('_TodoBase.updateTask');

  @override
  Future<void> updateTask(String des, int id) {
    return _$updateTaskAsyncAction.run(() => super.updateTask(des, id));
  }

  @override
  String toString() {
    return '''
todos: ${todos},
uTasks: ${uTasks},
user: ${user},
isLoading: ${isLoading},
isData: ${isData},
todosList: ${todosList}
    ''';
  }
}
