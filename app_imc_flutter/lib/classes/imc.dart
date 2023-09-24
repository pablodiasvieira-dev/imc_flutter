import 'package:flutter/material.dart';

class IMC {
  final String _id = UniqueKey().toString();
  double _peso = 0.0;
  int _altura = 0;
  bool _status = false;
  String _dataHora = "";
  // DateFormat('MMM D, HH:mm').format(DataTime.now())

  String get id => _id;
  String get dataHora => _dataHora;
  set dataHora(String dataHora) {
    _dataHora = dataHora;
  }

  double get peso => _peso;
  set peso(double peso) {
    _peso = peso;
  }

  int get altura => _altura;
  set altura(int altura) {
    _altura = altura;
  }

  bool get status => _status;
  set status(bool status) {
    _status = status;
  }

  IMC(double peso, int altura, String dataHora) {
    _peso = peso;
    _altura = altura;
    _dataHora = dataHora;
  }

  double calculaImc(double peso, int altura) {
    if (peso <= 0 || altura <= 0) {
      return 0;
    }
    double imcDouble = peso / ((altura / 100) * (altura / 100));
    String imcString = imcDouble.toStringAsFixed(2);
    return double.parse(imcString);
  }

  int faixaImc(double imcCalculado) {
    int faixa;
    if (imcCalculado <= 0) {
      faixa = 0;
    } else if (imcCalculado < 16) {
      faixa = 1;
    } else if (imcCalculado < 17) {
      faixa = 2;
    } else if (imcCalculado < 18.5) {
      faixa = 3;
    } else if (imcCalculado < 25) {
      faixa = 4;
    } else if (imcCalculado < 30) {
      faixa = 5;
    } else if (imcCalculado < 35) {
      faixa = 6;
    } else if (imcCalculado < 40) {
      faixa = 7;
    } else {
      faixa = 8;
    }
    return faixa;
  }

  String informaFaixaImc(peso, altura) {
    int faixaIntImc = faixaImc(calculaImc(peso, altura));
    String faixa;
    switch (faixaIntImc) {
      case 1:
        faixa = "Magreza Grave";
        break;
      case 2:
        faixa = "Magreza Moderada";
        break;
      case 3:
        faixa = "Magreza Leve";
        break;
      case 4:
        faixa = "Magreza Saudável";
        break;
      case 5:
        faixa = "Sobrepeso";
        break;
      case 6:
        faixa = "Obesidade Grau I";
        break;
      case 7:
        faixa = "Obesidade Grau II (severa)";
        break;
      case 8:
        faixa = "Obesidade Grau III (mórbida)";
        break;
      default:
        faixa = "Inválida";
    }
    return faixa;
  }
}
