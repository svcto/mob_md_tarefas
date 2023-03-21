import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:md_tarefas/model/tarefa.dart';
import 'package:md_tarefas/pages/lista_tarefas_page.dart';

class ConteudoFormDialog extends StatefulWidget {

  final Tarefa? tarefaAtual;

  ConteudoFormDialog({Key? key, this.tarefaAtual}) : super (key: key);

  @override
  ConteudoFormDialogState createState() => ConteudoFormDialogState();

}

class ConteudoFormDialogState extends State<ConteudoFormDialog> {
  final formKey = GlobalKey<FormState>();
  final descricaoController = TextEditingController();
  final prazoController = TextEditingController();
  final _dateFormat = DateFormat("dd/MM/yyy");

  @override
  void initState() {
    super.initState();
    if (widget.tarefaAtual != null) {
      descricaoController.text = widget.tarefaAtual!.descricao;
      prazoController.text = widget.tarefaAtual!.prazoFormatado;
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
              prefixIcon: IconButton(icon: const Icon(Icons.calendar_month),
                onPressed: _mostrarCalendario,
              ),
              suffixIcon: IconButton(icon: const Icon(Icons.close),
                onPressed: () => prazoController.clear(),
              )
          ),
          readOnly: true,
        )
      ],
    ));
  }

  _mostrarCalendario() {
    final dataFormatada = prazoController.text;
    var data = DateTime.now();
    if (dataFormatada.isNotEmpty) {
      data = _dateFormat.parse(dataFormatada);
    }
    showDatePicker(context: context,
        initialDate: data,
        firstDate: data.subtract(Duration(days: 365 * 5)),
        lastDate: data.add(Duration(days: 365 * 5))
    ).then((DateTime? dataSelecionada) {
      if (dataSelecionada != null) {
        prazoController.text = _dateFormat.format(dataSelecionada);
      }
    });
  }

  bool dadosValidados() => formKey.currentState?.validate() == true;

  Tarefa get novaTarefa => Tarefa(
      id: widget.tarefaAtual?.id ?? 0,
      descricao: descricaoController.text,
      prazo: prazoController.text.isEmpty ?
        null : _dateFormat.parse(prazoController.text)
  );
}