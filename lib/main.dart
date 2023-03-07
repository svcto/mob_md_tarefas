import 'package:flutter/material.dart';

void main() {
  runApp(const MdTarefas());
}

class MdTarefas extends StatelessWidget {
  const MdTarefas({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Gerenciador de Tarefas'),
    );
  }
}

