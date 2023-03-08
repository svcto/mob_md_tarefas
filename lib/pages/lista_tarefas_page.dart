import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_tarefas/model/tarefa.dart';

class ListaTarefaPage extends StatefulWidget {
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefaPage> {
  final tarefas = <Tarefa>[
    Tarefa(
        id: 1,
        descricao: "Minha tarefa",
        prazo: DateTime.now().add(Duration(days: 5)))
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: "Nova tarefa",
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _criarAppBar() {
    return AppBar(
      title: const Text("Gerenciador de Tarefas MD"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
      ],
    );
  }

  Widget _criarBody() {
    if (tarefas.isEmpty) {
      return const Center(
        child: Text("Nenhuma tarefa",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      );
    }
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final tarefa = tarefas[index];
          return ListTile(
            title: Text('${tarefa.id} - ${tarefa.descricao}'),
            subtitle: Text('Prazo: ${tarefa.prazoFormatado}'),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: tarefas.length);
  }
}
