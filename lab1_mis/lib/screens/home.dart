import 'package:flutter/material.dart';
import 'package:lab1_mis/widgets/exam_grid.dart';

import '../models/exam_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Exam> exams = [
    Exam(id:0, name: "Веб програмирање", dateTime: DateTime(2025, 11, 15, 9, 0), rooms: ["215", "Lab3"]),
    Exam(id:1, name: "Мобилни информациски системи", dateTime: DateTime(2025, 11, 1, 9, 0), rooms: ["13","3"]),
    Exam(id:2, name: "Алгоритми и податочни структури", dateTime: DateTime(2025, 11, 9, 9, 0), rooms: ["215", "2"]),
    Exam(id:3, name: "Калкулус", dateTime: DateTime(2025, 11, 12, 9, 0), rooms: ["215", "Lab2"]),
    Exam(id:4, name: "Веројатност и статистика", dateTime: DateTime(2025, 11, 12, 9, 0), rooms: ["13","3"]),
    Exam(id:5, name: "Дискретна математика", dateTime: DateTime(2025, 11, 5, 9, 0), rooms: ["215", "Lab2"]),
    Exam(id:6, name: "Менаџмент информациски системи", dateTime: DateTime(2025, 11, 18, 9, 0), rooms: ["13","3"]),
    Exam(id:7, name: "Електронска и мобилна трговија", dateTime: DateTime(2025, 11, 21, 9, 0), rooms: ["215"]),
    Exam(id:8, name: "Дигитална форензика", dateTime: DateTime(2025, 11, 21, 9, 0), rooms: ["215", "Lab2"]),
    Exam(id:9, name: "Напреден веб дизајн", dateTime: DateTime(2025, 11, 15, 9, 0), rooms: ["13","3"]),
    Exam(id:10, name: "Дизајн и архитектура на софтвер", dateTime: DateTime(2025, 11, 22, 9, 0), rooms: ["215", "Lab2"]),
    Exam(id:11, name: "Бази на податоци", dateTime: DateTime(2025, 11, 11, 9, 0), rooms: ["13","3"]),
    Exam(id:12, name: "Дизајн на интеракција човек-компјутер", dateTime: DateTime(2025, 11, 11, 9, 0), rooms: ["215", "Lab2"]),
  ];


  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child:Column(
          children: [
            Expanded(child: ExamGrid(exams: exams)),
            const SizedBox(height: 8),
        Text(
          "Вкупно испити: ${exams.length}",
          style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 8),
          ],
        )
      ),

    );
  }
}

