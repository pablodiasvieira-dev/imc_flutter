import 'package:app_imc_flutter/classes/imc.dart';

class ImcRepository {
  final List<IMC> _listaImcCalculado = [];

  Future<void> adicionar(IMC imc) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _listaImcCalculado.add(imc);
  }

  Future<void> alterar(String id, bool concluido) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _listaImcCalculado.where((element) => element.id == id).first.status;
  }

  Future<void> remover(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _listaImcCalculado.remove(_listaImcCalculado.where((element) => element.id == id).first);
  }

  Future<List<IMC>> listarIMCs() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _listaImcCalculado;
  }
}