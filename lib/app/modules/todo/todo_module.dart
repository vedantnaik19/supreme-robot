import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:todo/app/modules/todo/todo_controller.dart';
import 'package:todo/app/modules/todo/todo_page.dart';

class TodoModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => TodoController()),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => TodoPage();

  static Inject get to => Inject<TodoModule>.of();
}
