import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_tarefas/model/tarefa.dart';
import 'package:md_tarefas/widgets/conteudo_form_dialog.dart';

class ListaTarefaPage extends StatefulWidget {
  @override
  _ListaTarefasPageState createState() => _ListaTarefasPageState();
}

class _ListaTarefasPageState extends State<ListaTarefaPage> {

  static const ACAO_EDITAR = 'editar';
  static const ACAO_EXCLUIR = 'excluir';

  final tarefas = <Tarefa>[
    Tarefa(
      id: 1,
      descricao: "Minha tarefa",
      //prazo: DateTime.now().add(Duration(days: 5))
    )
  ];

  var _ultimoId = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _criarAppBar(),
      body: _criarBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _abrirForm,
        tooltip: "Nova tarefa",
        child: const Icon(Icons.add),
      ),
    );
  }

  void _abrirForm({Tarefa? tarefaAtual, int? index}) {
    final key = GlobalKey<ConteudoFormDialogState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tarefaAtual == null
                ? "Nova tarefa"
                : "Alterar tarefa" + tarefaAtual.id.toString()),
            content: ConteudoFormDialog(key: key, tarefaAtual: tarefaAtual),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () => {
                        if (key.currentState != null &&
                            key.currentState!.dadosValidados())
                          {
                            setState(() {
                              final novaTarefa = key.currentState!.novaTarefa;
                              if (index == null) {
                                novaTarefa.id = ++_ultimoId;
                                tarefas.add(novaTarefa);
                              } else {
                                tarefas[index] = novaTarefa;
                              }

                              Navigator.pop(context);
                            })
                          }
                      },
                  child: Text("Salvar"))
            ],
          );
        });
  }

  AppBar _criarAppBar() {
    return AppBar(
      title: const Text("Gerenciador de Tarefas MD"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
      ],
    );
  }

  void _showAlertDialog(BuildContext context, int index) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Não"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sim"),
      onPressed:  () {
        setState(() {
          tarefas.remove(tarefas[index]);
        });

        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Atenção"),
      content: Text("Deseja exluir esse registro?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
            title: Column(
              children: <Widget>[
                Container(
                    child: Row(
                      children: <Widget>[
                        Text('${tarefa.id} - ${tarefa.descricao}'),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _abrirForm(tarefaAtual: tarefa, index: index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showAlertDialog(context, index);
                          },
                        ),
                      ],
                    ))
              ],
            ),
            subtitle:
            Text(tarefa.prazo == null
                ? "Sem prazo"
                : 'Prazo: ${tarefa.prazoFormatado}')
          );
          /*return PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => _criarItensMenu(),
              onSelected: (String valorSelecionado) {
                if (valorSelecionado == ACAO_EDITAR) {
                  _abrirForm(tarefaAtual: tarefa, index: index);
                } else if (valorSelecionado == ACAO_EXCLUIR) {
                  _showAlertDialog(context, index);
                }
              },
              child: ListTile(
                title: Text('${tarefa.id} - ${tarefa.descricao}'),
                subtitle: Text(tarefa.prazo == null
                    ? "Sem prazo"
                    : 'Prazo: ${tarefa.prazoFormatado}'),
              ));*/
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemCount: tarefas.length);
  }

  /*List<PopupMenuItem<String>> _criarItensMenu() {
    return [
      PopupMenuItem(
        value: ACAO_EDITAR,
        child: Row(
          children: [
            Icon(Icons.edit, color: Colors.black),
            Padding(padding: EdgeInsets.only(left: 10), child: Text("Editar")),
          ],
        ),
      ),
      PopupMenuItem(
        value: ACAO_EXCLUIR,
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.black),
            Padding(padding: EdgeInsets.only(left: 10), child: Text("Excluir")),
          ],
        ),
      )
    ];
  }*/
}
