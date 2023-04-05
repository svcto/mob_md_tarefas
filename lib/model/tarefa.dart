import 'package:intl/intl.dart';

class Tarefa {
  static const tableName = "tarefa";

  static const campoId = "id";
  static const campoDescricao = "descricao";
  static const campoPrazo = "prazo";

  int id;
  String descricao;
  DateTime? prazo;

  Tarefa({required this.id, required this.descricao, this.prazo});

  String get prazoFormatado{
    if (prazo == null) {
      return "";
    }
    return DateFormat("dd/MM/yyy").format(prazo!);
  }
  
  Map<String, dynamic> toMap() => <String, dynamic> {
    campoId: id,
    campoDescricao: descricao,
    campoPrazo: prazo == null ? null : DateFormat("yyy-MM-dd").format(prazo!)
  };
  
  factory Tarefa.fromMap(Map<String, dynamic> map) => Tarefa(
      id: map[campoId] is int ? map[campoId] : null,
      descricao: map[campoDescricao] is String ? map[campoDescricao] : '',
      prazo: map[campoPrazo] == null ? null :
        DateFormat("yyy-MM-dd").parse(map[campoPrazo]));
}