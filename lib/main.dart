import 'package:flutter/material.dart';
import 'package:md_tarefas/pages/filtro_page.dart';
import 'package:md_tarefas/pages/lista_tarefas_page.dart';

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
        primarySwatch: Colors.green,
      ),
      home: ListaTarefaPage(),
      routes: {
        FiltroPage.routeName: (BuildContext context) => FiltroPage()
      },
    );
  }
}

