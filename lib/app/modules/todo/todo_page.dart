import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/core/utils/assets_path.dart';
import 'package:todo/app/modules/todo/todo_controller.dart';

class TodoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _formKeyEdit = GlobalKey<FormState>();
  final desController = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<TodoController>(context);
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
        // FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: controller.getData,
            child: Observer(
              builder: (_) {
                if (!controller.isData) {
                  controller.getData();
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 36,
                          width: double.infinity,
                        ),
                        Text('Hello, ${controller.user.firstName}!',
                            style: textTheme.headline5
                                .copyWith(fontWeight: FontWeight.w600)),
                        SizedBox(height: 10),
                        Text(
                            controller.todos.isEmpty
                                ? 'You have no tasks'
                                : 'You have ${controller.uTasks} unfinished tasks',
                            style: textTheme.subtitle1.copyWith()),
                        SizedBox(height: 36),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: desController,
                            decoration: InputDecoration(labelText: 'Add todo'),
                            textCapitalization: TextCapitalization.sentences,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            onFieldSubmitted: (val) {
                              if (_formKey.currentState.validate()) {
                                controller.createTask(val);
                                desController.clear();
                              }
                            },
                          ),
                        ),
                        controller.todos.isEmpty
                            ? buildNoTasksView(textTheme)
                            : Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 36),
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: controller.todosList.length,
                                      itemBuilder: (context, index) {
                                        var todos = controller.todosList;
                                        return Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          key: Key('$index'),
                                          secondaryActions: <Widget>[
                                            todos[index].completedAt == null
                                                ? IconSlideAction(
                                                    color: Colors.blueAccent,
                                                    icon: Icons.edit,
                                                    onTap: () {
                                                      showEditSheet(
                                                          context,
                                                          todos[index]
                                                              .description,
                                                          controller,
                                                          todos[index].id);
                                                    },
                                                  )
                                                : Container(),
                                            IconSlideAction(
                                              color: Colors.redAccent,
                                              icon: Icons.delete,
                                              onTap: () {
                                                controller.deleteTask(
                                                    todos[index].id);
                                              },
                                            ),
                                          ],
                                          child: ListTile(
                                            title: Text(
                                              todos[index].description,
                                              style: TextStyle(
                                                  decoration: todos[index]
                                                              .completedAt ==
                                                          null
                                                      ? TextDecoration.none
                                                      : TextDecoration
                                                          .lineThrough),
                                            ),
                                            enabled: todos[index].completedAt ==
                                                null,
                                            leading: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              alignment: Alignment.centerLeft,
                                              onPressed: todos[index]
                                                          .completedAt !=
                                                      null
                                                  ? null
                                                  : () {
                                                      controller.completeTask(
                                                          todos[index].id);
                                                    },
                                              icon: Icon(
                                                todos[index].completedAt != null
                                                    ? Icons.check_circle
                                                    : Icons
                                                        .radio_button_off_outlined,
                                                color:
                                                    todos[index].completedAt !=
                                                            null
                                                        ? Colors.green
                                                        : Colors.grey,
                                              ),
                                            ),
                                            // onTap: () {

                                            // },
                                            horizontalTitleGap: 0,
                                          ),
                                        );
                                      }),
                                ),
                              ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Column buildNoTasksView(TextTheme textTheme) {
    return Column(
      children: [
        SizedBox(
          height: 72,
        ),
        SizedBox(
          height: 124,
          child: SvgPicture.asset(
            AssetsPath.chillSvg,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Align(
          child: Text(
            'No tasks for today. \nEnjoy your day.',
            style: textTheme.caption,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  void showEditSheet(BuildContext context, String description,
      TodoController controller, int id) {
    editController.text = description;
    showModalBottomSheet(
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKeyEdit,
                  child: TextFormField(
                    autofocus: true,
                    controller: editController,
                    decoration: InputDecoration(labelText: 'Edit'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onFieldSubmitted: (val) {
                      if (_formKeyEdit.currentState.validate()) {
                        controller.updateTask(val, id);
                        editController.clear();
                      }
                    },
                  ),
                ),
              ),
            ),
          );
        },
        context: context);
  }
}
