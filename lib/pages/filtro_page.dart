import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:md_tarefas/model/tarefa.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FiltroPage extends StatefulWidget {
  static const routeName = '/filtro';
  static const chaveCampoOrdenacao = "campoOrdenacao";
  static const chaveUsarOrdemDescrescente = "usarOrdemDescrescente";
  static const chaveCampoDescricao = "campoDescricao";

  @override
  FiltroPageState createState() => FiltroPageState();
}

class FiltroPageState extends State<FiltroPage> {
  final _camposParaOrdenacao = {
    Tarefa.campoId: 'Código',
    Tarefa.campoDescricao: 'Descrição',
    Tarefa.campoPrazo: 'Prazo'
  };
  late final SharedPreferences _prefes;
  final TextEditingController _descricaoController = TextEditingController();
  String _campoOrdenacao = Tarefa.campoId;
  bool _usarOrdemDescrescente = false;
  bool _alterouValores = false;

  @override
  void initState() {
    _carregaPreferences();
  }

  void _carregaPreferences() async {
    _prefes = await SharedPreferences.getInstance();
    setState(() {
      _campoOrdenacao =
          _prefes.getString(FiltroPage.chaveCampoOrdenacao) ?? Tarefa.campoId;
      _usarOrdemDescrescente =
          _prefes.getBool(FiltroPage.chaveUsarOrdemDescrescente) == true;
      _descricaoController.text =
          _prefes.getString(FiltroPage.chaveCampoDescricao) ?? '';
    });
  }

  Widget _criarBody() {
    return ListView(children: [
      Padding(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Text('Campos para ordenação')),
      for (final campo in _camposParaOrdenacao.keys)
        Row(
          children: [
            Radio(
                value: campo,
                groupValue: _campoOrdenacao,
                onChanged: _onCampoParaOrdenacaoChanged),
            Text(_camposParaOrdenacao[campo]!)
          ],
        ),
      const Divider(),
      Row(
        children: [
          Checkbox(
              value: _usarOrdemDescrescente,
              onChanged: _onUsarOrdemDecrescenteChanged),
          const Text('Usar ordem descrescente')
        ],
      ),
      const Divider(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
            decoration: const InputDecoration(
              labelText: 'Descrição começa com...',
            ),
            controller: _descricaoController,
            onChanged: _onFiltroDescricaoChanged),
      )
    ]);
  }

  void _onFiltroDescricaoChanged(String? value) {
    _prefes.setString(FiltroPage.chaveCampoDescricao, value!);
    _alterouValores = true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onVoltarClick,
        child: Scaffold(
          appBar: AppBar(title: const Text('Filtro e Ordenação')),
          body: _criarBody(),
        ));
  }

  Future<bool> _onVoltarClick() {
    return Future(() => false);
  }

  void _onCampoParaOrdenacaoChanged(String? value) {
    _prefes.setString(FiltroPage.chaveCampoOrdenacao, value!);
    _alterouValores = true;
    setState(() {
      _campoOrdenacao = value;
    });
  }

  void _onUsarOrdemDecrescenteChanged(bool? value) {
    _prefes.setBool(FiltroPage.chaveUsarOrdemDescrescente, value!);
    _alterouValores = true;
    setState(() {
      _usarOrdemDescrescente = value;
    });
  }
}
