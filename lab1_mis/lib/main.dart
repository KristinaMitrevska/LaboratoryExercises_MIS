import 'package:flutter/material.dart';
import 'package:lab1_mis/screens/details.dart';
import 'package:lab1_mis/screens/home.dart';

import 'models/exam_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Распоред за испити - 223177',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)
        ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Распоред за испити - 223177'),
        '/details': (context) {
          final exam = ModalRoute.of(context)!.settings.arguments as Exam;
          return ExamDetailScreen(exam: exam);
        },
      },

    );
  }
}