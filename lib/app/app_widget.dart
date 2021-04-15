import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/app/modules/todo/todo_controller.dart';
import 'package:todo/app/modules/todo/todo_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return MultiProvider(
      providers: [
        Provider<TodoController>(create: (context) => TodoController())
      ],
      child: MaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.montserratTextTheme(baseTheme.textTheme).copyWith(
              headline6: GoogleFonts.comfortaa(),
              headline5: GoogleFonts.comfortaa(),
              headline4: GoogleFonts.comfortaa(),
            )),
        home: TodoModule(),
      ),
    );
  }
}
