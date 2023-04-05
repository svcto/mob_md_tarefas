import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_tarefas/model/tarefa.dart';

class DetalhePage extends StatefulWidget {
  final Tarefa tarefa;

  const DetalhePage({Key? key, required this.tarefa}): super(key: key);

  @override
  DetalhePageState createState() => DetalhePageState();
}
class DetalhePageState extends State<DetalhePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da tarefa ${widget.tarefa.id}')),
      body: _criarBody()
    );
  }

  Widget _criarBody() {
    return Padding(padding: EdgeInsets.all(10),
      child: ListView(children: [
        Row(children: [
          const Campo(descricao: 'Código: '),
          Valor(valor: '${widget.tarefa.id}')
        ]),
        Row(children: [
          const Campo(descricao: 'Descrição: '),
          Valor(valor: widget.tarefa.descricao)
        ]),
        Row(children: [
          const Campo(descricao: 'Prazo: '),
          Valor(valor: widget.tarefa.prazoFormatado.isEmpty ? 'Tarefa sem prazo definido' : widget.tarefa.prazoFormatado)
        ])
      ])
    );
  }
}

class Campo extends StatelessWidget {
  final String descricao;

  const Campo({Key? key, required this.descricao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
        child: Text(descricao,
          style: TextStyle(fontWeight: FontWeight.bold)
        ));
  }
}

class Valor extends StatelessWidget {
  final String valor;

  const Valor({Key? key, required this.valor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 4,
        child: Text(valor));
  }
}