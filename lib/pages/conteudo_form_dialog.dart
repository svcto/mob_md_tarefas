import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:md_tarefas/model/tarefa.dart';
import 'package:md_tarefas/pages/lista_tarefas_page.dart';

class ConteudoFormDialog extends StatefulWidget {

  final Tarefa? tarefaAtual;

  ConteudoFormDialog({Key? key, this.tarefaAtual}) : super (key: key)

  @override
  _ConteudoFormDialogState createState() => _ConteudoFormDialogState();

}

class _ConteudoFormDialogState extends State<ConteudoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final prazoController = TextEditingController();
  final _dateFormat = DateFormat("dd/MM/yyy");

  @override
  void initState() {
    super.initState();
    if (widget.tarefaAtual == null) {

    }
  }

  Widget build(BuildContext context) {
    return Form(key: formKey, child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(controller: descricaoController,
          decoration: const InputDecoration(labelText: "Descrição"),
          validator: (String? valor) {
            if (valor == null || valor.isEmpty) {
              return "Informe a descrição!";
            }
            return null;
          },
        ),
        TextFormField(controller: prazoController,
          decoration: InputDecoration(labelText: "Prazo",
              prefixIcon: IconButton(icon: Icon(Icons.calendar_month),
                onPressed: _mostrarCalendario(),
              ),
            suffixIcon: IconButton(icon: Icon(Icons.close),
              onPressed: () => prazoController.clear(),
            )
          ),
          readOnly: true,
        )
      ],
    ));
  }

  _mostrarCalendario() {}


}