class Pessoa {
  String _nome = "";

  String get nome => _nome;
  set nome(String nome) {
    _nome = nome;
  }

  Pessoa(String nome) {
    _nome = nome;
  }
}
