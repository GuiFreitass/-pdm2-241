import 'dart:convert';
//Atividade feita por Guilherme Freitas do Nascimento
class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((dependente) => dependente.toJson()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((funcionario) => funcionario.toJson()).toList(),
    };
  }
}

void main() {
  // 1. Criar varios objetos Dependentes
  var Emily = Dependente('Emily');
  var Marcos = Dependente('Marcos');

  // 2. Criar varios objetos Funcionario
  var funcionario1 = Funcionario('Funcionario1', [Emily]);
  var funcionario2 = Funcionario('Funcionario2', [Marcos]);

  // 3. Associar os Dependentes criados aos respectivos funcionarios
  // (já feito durante a criação dos objetos)

  // 4. Criar uma lista de Funcionarios
  var listaFuncionarios = [funcionario1, funcionario2];

  // 5. criar um objeto Equipe Projeto chamando o metodo
  // contrutor que dá nome ao projeto e insere uma
  // coleção de funcionarios
  var equipeProjeto = EquipeProjeto('Projeto1', listaFuncionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto.
  var equipeProjetoJson = jsonEncode(equipeProjeto.toJson());
  print(equipeProjetoJson);
}
